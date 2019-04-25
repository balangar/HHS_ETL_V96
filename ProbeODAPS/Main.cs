using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using log4net;

using CommandLine;

using System.IO;

using CsvHelper;

using ProbeODAPS.sforce;

namespace ProbeODAPS
{
    internal class Main
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        private static string CurrentSFType = string.Empty;
        private static StreamWriter writer = null;
        private static CsvWriter csvWriter = null;

        [Verb("Count", HelpText = "List SF objects to obtain record count")]
        internal class CountOptions
        {
            [Option('o', "Objects", Required = false, HelpText = "List of SF Objects to county")]
            public IEnumerable<string> SFObjectNames { get; set; }
        }

        [Verb("Document", HelpText = "List SF Objects to document")]
        internal class DocumentOptions
        {
            [Option('v', "Verbose", Required = false, Default = false, HelpText = "Set output to verbose messages")]
            public bool Verbose { get; set; }

            [Option('o', "Objects", Required = false, HelpText = "List of SF Objects to describe")]
            public IEnumerable<string> SFObjectNames { get; set; }

            [Option("Path", Required = false, Default = @"C:\Temp", HelpText = "Output file path")]
            public string OutPath { get; set; }
        }

        [Verb("List", HelpText = "List all ODAPS SalesForce Objects")]
        internal class ListOptions
        {
            [Option('v', "Verbose", Required = false, Default = false, HelpText = "Set output to verbose messages.")]
            public bool Verbose { get; set; }

            [Option("Path", Required = false, Default = @"C:\Temp", HelpText = "Output file path")]
            public string OutPath { get; set; }
        }

        [Verb("Extract", HelpText = "Extract data from ODAPS SalesForce Objects")]
        internal class ExtractOptions
        {
            [Option('v', "Verbose", Required = false, Default = false, HelpText = "Set output to verbose messages.")]
            public bool Verbose { get; set; }

            [Option('o', "Object", Required = false, HelpText = "List of SF Objects to extract")]
            public IEnumerable<string> SFObjectNames { get; set; }

            [Option("All", Required = false, Default = false, HelpText = "Extract all fields")]
            public bool All { get; set; }

            [Option("Path", Required = false, Default = @"C:\Temp", HelpText = "Output file path")]
            public string OutPath { get; set; }
        }
        private static int ListSFObjects(ListOptions Options, SoapClient EndPoint)
        {
            // List the objects available
            using (StreamWriter w = new StreamWriter(Path.Combine(Options.OutPath, "ODAPS_Objects.txt")))
            {
                w.WriteLine(SF.GetObjectList(EndPoint, Options.Verbose));
            }
            return 0;
        }
        private static int DocumentSFObject(SoapClient EndPoint, string SFObjectName, bool Verbose, string OutFileSpec)
        {
            Program.Logger.InfoFormat("Document: {0}", SFObjectName);
            Program.Logger.DebugFormat("SF Object Name: {0}   Verbose: {1}  OutPath: {2}  OutFile: {3}", SFObjectName, Verbose, Path.GetDirectoryName(OutFileSpec), Path.GetFileName(OutFileSpec));

            using (StreamWriter w = new StreamWriter(OutFileSpec, false))
            {
                w.WriteLine(SF.GetObjectDocumentation(EndPoint, SFObjectName, Verbose));
            }
            return 0;
        }
        private static int DocumentSFObjects(DocumentOptions Options, SoapClient EndPoint)
        {

            int returnStatus = 0;
            foreach (var objName in Options.SFObjectNames)
            {
                returnStatus += DocumentSFObject(EndPoint, objName, Options.Verbose, Path.Combine(Options.OutPath, objName + ".txt"));
            }
            return returnStatus == 0 ? 0 : -1;
        }
        private static int CountSFObjects(CountOptions Options, SoapClient EndPoint)
        {
            int returnStatus = 0;
            try
            {
                foreach (var oName in Options.SFObjectNames)
                {
                    Logger.Info(string.Format("Record count for {0}: {1}", oName, SF.GetRecordCount(oName, EndPoint)));
                }
            }
            catch (Exception)
            {

                throw;
            }

            return returnStatus == 0 ? 0 : -1;
        }
        private static void PutSFRecord(sObject SFObject, String OutputPath)
        {
            //TODO:  PutSFRecord -- Possible bug. ?Flush if only one SFObject having only one SFRecord?
            string nextSFType = SFObject.type;
            string outputFilePath = OutputPath;
            string outputFileSpec = string.Empty;

            try
            {
                if (nextSFType != CurrentSFType) //New SFObject
                {
                    CurrentSFType = nextSFType;
                    outputFileSpec = outputFilePath + Path.DirectorySeparatorChar + nextSFType + "." + "csv";
                    var config = new CsvHelper.Configuration.Configuration(new System.Globalization.CultureInfo("en-US"))
                    {
                        AllowComments = true,
                        Delimiter = ",",
                        Comment = '#',
                        BadDataFound = null,
                        SanitizeForInjection = false,
                        IgnoreQuotes = false,
                        DetectColumnCountChanges = true
                    };

                    if (writer != null)
                    {
                        writer.Flush();
                    }

                    writer = new StreamWriter(outputFileSpec, false, Encoding.UTF8);
                    csvWriter = new CsvWriter(writer, config);

                    /* Write header record */
                    int d = 0;
                    do
                    {
                        csvWriter.WriteField(SFObject.Any[d].LocalName);
                        d++;
                    } while (d < SFObject.Any.Length);
                    csvWriter.NextRecord();
                }
                /* Write data records */

                int i = 0;
                do
                {
                    csvWriter.WriteField(SFObject.Any[i].InnerText);
                    i++;
                } while (i < SFObject.Any.Length);

                csvWriter.NextRecord();
            }
            catch (Exception ex)
            {
                Logger.Error(ex.Message);
                throw;
            }

            return;
        }
        private static int ExtractSFObjectRecords(string SFObjectName, string Query, string OutFilePath, SoapClient EndPoint)
        {
            int exitStatus = 0;
            int recordCount = 0;
            try
            {
                foreach (sObject o in SF.GetNextSFRecord(SFObjectName, Query, EndPoint))
                {
                    if (recordCount == 0)
                    {
                        PIO.Open(o.type, OutFilePath);
                        PIO.WriterHeader(o);
                        PIO.WriteRecord(o);
                        recordCount += 1;
                    }
                    else
                    {
                        PIO.WriteRecord(o);
                        recordCount += 1;
                    }
                }

            }
            catch (Exception ex)
            {
                Logger.Error(ex.Message);
                exitStatus = -1;
            }
            finally
            {
                PIO.Close();
            }

            Logger.Info(string.Format("{0} record count : {1}", SFObjectName, recordCount));
            return exitStatus;
        }
        private static int ExtractSFObjects(ExtractOptions Options, Dictionary<string, string> SFObjectQueries, SoapClient EndPoint)
        {
            int exitStatus = -1;

            try
            {
                foreach (var q in from o in Options.SFObjectNames from q in SFObjectQueries where o == q.Key select q)
                {
                    Program.Logger.InfoFormat("Extract : {0}", q.Key);
                    Program.Logger.DebugFormat("SF Object Name: {0}   Verbose: {1}  OutPath: {2}.", q.Key, Options.Verbose, Options.OutPath);
                    exitStatus = ExtractSFObjectRecords(q.Key, q.Value, Options.OutPath, EndPoint);
                }
            }
            catch (Exception ex)
            {
                Program.Logger.Error(ex.Message);
                throw;
            }
            return exitStatus;
        }
        internal static int Work(string[] args)
        {
            const string SF_USER_NAME = "api.user@jfs.ohio.gov.uat";
            const string SF_PASS_WORD = "CuyahogaCounty@@@444" + "mkheMFqdQd6dMQYGhNTwerFd"; //Combined password and token.

            Dictionary<string, string> sfObjectQueries = new Dictionary<string, string>()
                {
                    {"Contact",
                        @"Select
                            Id,IsDeleted,MasterRecordId,AccountId,
                            LastName,FirstName,Salutation,MiddleName,Suffix,Name,
                            RecordTypeId,
                            MailingStreet,MailingCity,MailingState,MailingPostalCode,MailingCountry,MailingStateCode,MailingCountryCode,
                            MailingLatitude,MailingLongitude,MailingGeocodeAccuracy,
                            MailingAddress,
                            Phone,Fax,MobilePhone,
                            ReportsToId,
                            Email,
                            Title,Department,
                            OwnerId,
                            CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,LastActivityDate,LastCURequestDate,LastCUUpdateDate,LastViewedDate,LastReferencedDate,
                            EmailBouncedReason,EmailBouncedDate,IsEmailBounced,PhotoUrl,Jigsaw,JigsawContactId,
                            Confidential_Reason__c,Confidential__c,Contact_Type__c,
                            Current_City__c,Current_Postal_Code__c,Current_State_Code__c,Current_Street__c,Employment_Status__c,Other_Confidential_Reason__c,
                            Person_Id__c,
                            Race__c,Sexual_Orientation__c,Specify_Other_Primary_Language__c,Veteran_Status__c,
                            Social_Security_Number__c,Bed_Bugs__c,Date_of_Death__c
                        From
	                        Contact"},
                    {"Case_Notes__c",
                        @"SELECT
                            Id,
                            IsDeleted,
                            Name,
                            RecordTypeId,
                            CreatedDate,
                            CreatedById,
                            LastModifiedDate,
                            LastModifiedById,
                            SystemModstamp,
                            LastActivityDate,
                            LastViewedDate,
                            LastReferencedDate,
                            APS_Case_Number__c,
                            TemporaryAPSCase__c,
                            Case_Note_Created_in_Error__c,
                            Case_Note__c,
                            Status__c,
                            Supervisor_Email__c,
                            Created_in_Error_Formatted__c,
                            Parent__c
                        FROM
                            Case_Notes__C"},
                    { "User",
                        @"Select
                            Id,
                            Username,
                            LastName,
                            FirstName,
                            MiddleName,
                            Suffix,
                            Name,
                            CompanyName,
                            Division,
                            Department,
                            Title,
                            Street,
                            City,
                            State,
                            PostalCode,
                            Country,
                            StateCode,
                            CountryCode,
                            Latitude,
                            Longitude,
                            GeocodeAccuracy,
                            Address,
                            Email,
                            EmailPreferencesAutoBcc,
                            EmailPreferencesAutoBccStayInTouch,
                            EmailPreferencesStayInTouchReminder,
                            SenderEmail,
                            SenderName,
                            Signature,
                            StayInTouchSubject,
                            StayInTouchSignature,
                            StayInTouchNote,
                            Phone,
                            Fax,
                            MobilePhone,
                            Alias,
                            CommunityNickname,
                            BadgeText,
                            IsActive,
                            TimeZoneSidKey,
                            UserRoleId,
                            LocaleSidKey,
                            ReceivesInfoEmails,
                            ReceivesAdminInfoEmails,
                            EmailEncodingKey,
                            UserType,
                            LanguageLocaleKey,
                            EmployeeNumber,
                            DelegatedApproverId,
                            ManagerId,
                            LastLoginDate,
                            CreatedDate,
                            CreatedById,
                            LastModifiedDate,
                            LastModifiedById,
                            SystemModstamp,
                            OfflineTrialExpirationDate,
                            OfflinePdaTrialExpirationDate,
                            UserPermissionsMarketingUser,
                            UserPermissionsOfflineUser,
                            UserPermissionsAvantgoUser,
                            UserPermissionsCallCenterAutoLogin,
                            UserPermissionsMobileUser,
                            UserPermissionsSFContentUser,
                            UserPermissionsKnowledgeUser,
                            UserPermissionsInteractionUser,
                            UserPermissionsSupportUser,
                            UserPermissionsLiveAgentUser,
                            ForecastEnabled,
                            UserPreferencesActivityRemindersPopup,
                            UserPreferencesEventRemindersCheckboxDefault,
                            UserPreferencesTaskRemindersCheckboxDefault,
                            UserPreferencesReminderSoundOff,
                            UserPreferencesDisableAllFeedsEmail,
                            UserPreferencesDisableFollowersEmail,
                            UserPreferencesDisableProfilePostEmail,
                            UserPreferencesDisableChangeCommentEmail,
                            UserPreferencesDisableLaterCommentEmail,
                            UserPreferencesDisProfPostCommentEmail,
                            UserPreferencesContentNoEmail,
                            UserPreferencesContentEmailAsAndWhen,
                            UserPreferencesApexPagesDeveloperMode,
                            UserPreferencesHideCSNGetChatterMobileTask,
                            UserPreferencesDisableMentionsPostEmail,
                            UserPreferencesDisMentionsCommentEmail,
                            UserPreferencesHideCSNDesktopTask,
                            UserPreferencesHideChatterOnboardingSplash,
                            UserPreferencesHideSecondChatterOnboardingSplash,
                            UserPreferencesDisCommentAfterLikeEmail,
                            UserPreferencesDisableLikeEmail,
                            UserPreferencesSortFeedByComment,
                            UserPreferencesDisableMessageEmail,
                            UserPreferencesDisableBookmarkEmail,
                            UserPreferencesDisableSharePostEmail,
                            UserPreferencesEnableAutoSubForFeeds,
                            UserPreferencesDisableFileShareNotificationsForApi,
                            UserPreferencesShowTitleToExternalUsers,
                            UserPreferencesShowManagerToExternalUsers,
                            UserPreferencesShowEmailToExternalUsers,
                            UserPreferencesShowWorkPhoneToExternalUsers,
                            UserPreferencesShowMobilePhoneToExternalUsers,
                            UserPreferencesShowFaxToExternalUsers,
                            UserPreferencesShowStreetAddressToExternalUsers,
                            UserPreferencesShowCityToExternalUsers,
                            UserPreferencesShowStateToExternalUsers,
                            UserPreferencesShowPostalCodeToExternalUsers,
                            UserPreferencesShowCountryToExternalUsers,
                            UserPreferencesShowProfilePicToGuestUsers,
                            UserPreferencesShowTitleToGuestUsers,
                            UserPreferencesShowCityToGuestUsers,
                            UserPreferencesShowStateToGuestUsers,
                            UserPreferencesShowPostalCodeToGuestUsers,
                            UserPreferencesShowCountryToGuestUsers,
                            UserPreferencesPipelineViewHideHelpPopover,
                            UserPreferencesHideS1BrowserUI,
                            UserPreferencesDisableEndorsementEmail,
                            UserPreferencesPathAssistantCollapsed,
                            UserPreferencesCacheDiagnostics,
                            UserPreferencesShowEmailToGuestUsers,
                            UserPreferencesShowManagerToGuestUsers,
                            UserPreferencesShowWorkPhoneToGuestUsers,
                            UserPreferencesShowMobilePhoneToGuestUsers,
                            UserPreferencesShowFaxToGuestUsers,
                            UserPreferencesShowStreetAddressToGuestUsers,
                            UserPreferencesLightningExperiencePreferred,
                            UserPreferencesHideEndUserOnboardingAssistantModal,
                            UserPreferencesHideLightningMigrationModal,
                            UserPreferencesHideSfxWelcomeMat,
                            UserPreferencesHideBiggerPhotoCallout,
                            UserPreferencesGlobalNavBarWTShown,
                            UserPreferencesGlobalNavGridMenuWTShown,
                            UserPreferencesCreateLEXAppsWTShown,
                            UserPreferencesFavoritesWTShown,
                            UserPreferencesRecordHomeSectionCollapseWTShown,
                            UserPreferencesRecordHomeReservedWTShown,
                            UserPreferencesFavoritesShowTopFavorites,
                            UserPreferencesExcludeMailAppAttachments,
                            UserPreferencesSuppressTaskSFXReminders,
                            UserPreferencesSuppressEventSFXReminders,
                            UserPreferencesPreviewCustomTheme,
                            UserPreferencesHasCelebrationBadge,
                            UserPreferencesUserDebugModePref,
                            UserPreferencesNewLightningReportRunPageEnabled,
                            ContactId,
                            AccountId,
                            CallCenterId,
                            Extension,
                            PortalRole,
                            IsPortalEnabled,
                            FederationIdentifier,
                            AboutMe,
                            FullPhotoUrl,
                            SmallPhotoUrl,
                            IsExtIndicatorVisible,
                            OutOfOfficeMessage,
                            MediumPhotoUrl,
                            DigestFrequency,
                            DefaultGroupNotificationFrequency,
                            LastViewedDate,
                            LastReferencedDate,
                            BannerPhotoUrl,
                            SmallBannerPhotoUrl,
                            MediumBannerPhotoUrl,
                            IsProfilePhotoActive
                    From
	                        User" },
                    {"APS_Case__c",
                        @"Select
                            Id,
                            OwnerId,
                            IsDeleted,
                            Name,
                            RecordTypeId,
                            CreatedDate,
                            CreatedById,
                            LastModifiedDate,
                            LastModifiedById,
                            SystemModstamp,
                            LastActivityDate,
                            LastViewedDate,
                            LastReferencedDate,
                            of_No_Mistreatment_Allegations__c,
                            Case_Decision_Approval_Status__c,
                            Case_Decision_Date_Time__c,
                            Case_Decision_Due_Date__c,
                            Case_Decision_Reason__c,
                            Case_Decision__c,
                            Case_Plan_Date_Timely__c,
                            Case_Stage__c,
                            Case_Transfer_Required__c,
                            Client_Current_Address__c,
                            Companion_Case__c,
                            Confidential_Reason__c,
                            Date_Notice_of_Intent_Letter_Provided__c,
                            Demeaning_insults__c,
                            Emotional_Abuse_Were_there_any_witnesses__c,
                            Emotional_Verbal_Abuse_Additional_Detail__c,
                            Emotional_Verbal_Abuse__c,
                            Extension_Reason__c,
                            Extension_Request__c,
                            Harassment__c,
                            Humiliation__c,
                            INR_Additional_Details__c,
                            Ignoring__c,
                            Information_and_Referral__c,
                            Initial_Risk_Assessment_Status__c,
                            Initiation_Date_Time__c,
                            Initiation_Due_Date_Time__c,
                            Intimidation_Threats__c,
                            Isolation__c,
                            Location_of_Emotional_Abuse_Allegation__c,
                            Location_of_Exploitation_Allegation__c,
                            Location_of_Neglect_Allegation__c,
                            Location_of_Physical_Abuse_Allegation__c,
                            Location_of_Self_Neglect_Allegation__c,
                            Location_of_Sexual_Abuse_Allegation__c,
                            Other_Confidential_Reason__c,
                            ReAssessment_Due_Date__c,
                            Ready_for_Screening_Decision__c,
                            Reassessment_Complete_Date__c,
                            Referral_Source__c,
                            Referral_Submitted_Date_Time__c,
                            Report_Effective_Date_Time__c,
                            ResponseDueDateTime__c,
                            STD__c,
                            Sequencing_Number__c,
                            Sexual_Exploitation__c,
                            Transfer_Case_Reason__c,
                            Transferring_County_Decision__c,
                            Verbal_Assaults_Yelling__c,
                            Max_Reassessment_Date__c,
                            Bed_Bugs__c,
                            Screened_Out_Date_Time__c,
                            Owner_County__c,
                            of_Completed_Assessments_Formula__c
                          FROM
                            APS_Case__c"}
                };

            int exitStatus = -1;
            try
            {
                if (SF.Login(SF_USER_NAME, SF_PASS_WORD, out SoapClient EndpointClient))
                {
                    exitStatus = CommandLine.Parser.Default.ParseArguments<DocumentOptions, ExtractOptions, ListOptions, CountOptions>(args)
                        .MapResult(
                            (DocumentOptions o) => DocumentSFObjects(o, EndpointClient),
                            (ExtractOptions o) => ExtractSFObjects(o, sfObjectQueries, EndpointClient),
                            (ListOptions o) => ListSFObjects(o, EndpointClient),
                            (CountOptions o) => CountSFObjects(o, EndpointClient),
                            errs => 1);

                }

                SF.Logout(EndpointClient);
            }
            catch (Exception)
            {
                exitStatus = -1;
                throw;
            }

            return exitStatus;
        }
    }
}
