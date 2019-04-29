using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using log4net;

using CommandLine;

using System.IO;

using ProbeODAPS.sforce;

namespace ProbeODAPS
{
    internal class Main
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

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
                returnStatus += DocumentSFObject(EndPoint, objName, Options.Verbose, Path.Combine(Options.OutPath, "Doc_" + objName + ".txt"));
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
        private static int ExtractSFObjectRecords(string SFObjectName, string Query, string OutFilePath, SoapClient EndPoint)
        {
            int exitStatus = 0;
            int recordCount = 0;
            try
            {
                foreach (sObject o in SF.GetNextSFRecord(Query, EndPoint, SFObjectName))
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
                            Id,
                            Lastname,
                            FirstName,
                            Name,
                            MailingStreet,
                            MailingCity,
                            MailingStatecode,
                            MailingPostalCode,
                            MailingAddress,
                            Phone,
                            HomePhone,
                            Email,
                            Birthdate,
                            Approx_age__c,
                            Gender_Code__c,
                            Gender__c,
                            Hoarding_or_animal_hoarding__c,
                            Income_Source__c,
                            Marital_status__c,
                            Medicaid__c,
                            Medicare__c,
                            Race__c,
                            SSN__c,
                            Person_ID__c,
                            Veteran_Status__c,
                            Bed_Bugs__c
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
                            CreatedDate,
                            CreatedById,
                            LastModifiedDate,
                            LastModifiedById,
                            SystemModstamp,
                            ADLs_toileting_bathing_hygiene_toileting__c,
                            Actions_Taken_Prior_to_this_Call__c,
                            Adequate_nutrition_hydration__c,
                            Adequate_supervision__c,
                            Allow_someone_to_live_with_them__c,
                            Appropriate_medical_treatment__c,
                            Approval_Kick_off__c,
                            Bathing_and_hygiene__c,
                            Bills_finances__c,
                            Biohazard__c,
                            Bug_or_vermin_infestation__c,
                            Caretaker_Neglect__c,
                            Case_Closure_Corrections_Completed__c,
                            ConditionNone__c,
                            ConditionUnabletoManageNone__c,
                            ConditionUnabletoManageUnknown__c,
                            ConditionUnknown__c,
                            Condition_Requiring_Total_Physical_Care__c,
                            Confidential__c,
                            Contagious_disease__c,
                            Corrections_Completed__c,
                            Dangerous_Aggressive_Person_in_Home_c__c,
                            Dangerous_aggressive_animals__c,
                            Dangerous_home_structure__c,
                            Decision_making_understanding_deficits__c,
                            Dementia_Alzheimer_s__c,
                            Developmental_Intellectual_Disability__c,
                            Emergency_Immediate_Harm__c,
                            Exploitation__c,
                            Fear_as_a_result_of_a_person_s_action__c,
                            Firearms_or_other_weapons__c,
                            For_another_person_s_personal_needs__c,
                            For_illegal_activity__c,
                            For_things_adult_would_not_use_purchase__c,
                            Frail_Elderly__c,
                            Gated_locked_community_building__c,
                            Give_away_money_or_property__c,
                            Guardian_or_conservator_in_place__c,
                            Harasses_the_adult_in_a_sexual_manner__c,
                            Have_aggressive_behavior__c,
                            Have_self_injurious_behavior__c,
                            Healthcare_medical_needs__c,
                            Help_from_family_friends_others__c,
                            Hoarding_including_animals__c,
                            Hoarding_or_animal_hoarding__c,
                            IADLs_cleaning_laundry_cooking__c,
                            Illegal_activity_in_the_home__c,
                            Illegal_drug_manufacturing__c,
                            Illegal_drug_use__c,
                            Imminent_foreclosures_or_eviction__c,
                            Impact_ability_to_communicate__c,
                            Inappropriate_Sexual_Behaviors__c,
                            Inappropriate_confinement__c,
                            Inappropriate_restraint__c,
                            Known_criminal_activity_history__c,
                            Known_gang_activity__c,
                            Lack_of_access_pathways__c,
                            Major_Mental_Illness_Emotional_Disorder__c,
                            Make_changes_to_a_bank_account__c,
                            Makes_sexual_innuendos_toward_the_adult__c,
                            Makes_the_adult_perform_sexual_acts__c,
                            Makes_the_adult_watch_pornography__c,
                            Malnutrition_sudden_weight_loss_gain__c,
                            Managing_Home_Cleanliness__c,
                            Medical_conditions__c,
                            Medically_Fragile__c,
                            Medication_management__c,
                            Memory_deficits__c,
                            Memory_problems__c,
                            Mental_illness__c,
                            Mismanagement_of_medications__c,
                            NeurologicalImpairmentStrokeTBIMS__c,
                            Neurological_Impairment_Stroke_TBI_MS__c,
                            No_At_Risk_Issues__c,
                            No_Mistreatment__c,
                            No_Physical_Medical_Condition__c,
                            Non_working_appliances__c,
                            Non_working_utilities__c,
                            POA_in_place__c,
                            Pain_as_a_result_of_a_person_s_action__c,
                            Physical_Abuse_Broken_Bones__c,
                            Physical_Abuse_Bruises__c,
                            Physical_Abuse_Cuts__c,
                            Physical_Abuse_Scratches__c,
                            Physical_Abuse_Visible_Marks__c,
                            Physical_Abuse__c,
                            Physical_Impairment__c,
                            Physical_conditions__c,
                            Police_frequently_called_to_the_home__c,
                            Poor_hygiene_not_bathing__c,
                            Professional_services_in_place__c,
                            Questionable_transfer_of_money_property__c,
                            Ready_to_Close_Case__c,
                            Refuses_recommended_services__c,
                            Rep_payee_in_place__c,
                            Scorecard_Review__c,
                            Security_system_cameras__c,
                            Self_Neglect_Substance_Abuse__c,
                            Self_Neglect__c,
                            Sexual_Abuse_Broken_Bones__c,
                            Sexual_Abuse_Bruises__c,
                            Sexual_Abuse_Cuts__c,
                            Sexual_Abuse_Scratches__c,
                            Sexual_Abuse_Visible_Marks__c,
                            Sexual_Abuse__c,
                            Sign_a_quit_claim_deed__c,
                            Social_interaction_family_friends_visit__c,
                            Substance_Abuse_including_RX_meds__c,
                            Substance_abuse__c,
                            To_do_anything_they_wouldn_t_do_normally__c,
                            Transportation__c,
                            Unable_to_protect_themselves_checkbox__c,
                            Unexplained_loss_of_money_property__c,
                            Unknown_At_Risk_Population__c,
                            Unpaid_utilities__c,
                            Unsafe_neighborhood__c,
                            Unsafe_structure__c,
                            Untreated_medical_condition__c,
                            Untreated_mental_health_need__c,
                            Untreated_mental_illness__c,
                            Vermin_pest_infestation__c,
                            Wander__c,
                            Without_adult_s_knowledge_permission__c,
                            Worker_Safety_Issues__c,
                            Case_Transfer_Required__c,
                            Demeaning_insults__c,
                            Emotional_Verbal_Abuse__c,
                            Harassment__c,
                            Humiliation__c,
                            Ignoring__c,
                            Information_and_Referral__c,
                            Intimidation_Threats__c,
                            Isolation__c,
                            Ready_for_Screening_Decision__c,
                            STD__c,
                            Sexual_Exploitation__c,
                            Verbal_Assaults_Yelling__c,
                            Re_Assessment_Close__c,
                            Bed_Bugs__c
                          FROM
                            APS_Case__c
                          WHERE
                           OwnerID = '001t0000009WiXVAA0'"},
                {"Account",
                    @"Select
                            Id,
                            IsDeleted,
                            MasterRecordId,
                            Name,
                            Type,
                            RecordTypeId,
                            ParentId,
                            BillingStreet,
                            BillingCity,
                            BillingState,
                            BillingPostalCode,
                            BillingCountry,
                            BillingStateCode,
                            BillingCountryCode,
                            BillingLatitude,
                            BillingLongitude,
                            BillingGeocodeAccuracy,
                            BillingAddress,
                            ShippingStreet,
                            ShippingCity,
                            ShippingState,
                            ShippingPostalCode,
                            ShippingCountry,
                            ShippingStateCode,
                            ShippingCountryCode,
                            ShippingLatitude,
                            ShippingLongitude,
                            ShippingGeocodeAccuracy,
                            ShippingAddress,
                            Phone,
                            Website,
                            PhotoUrl,
                            Industry,
                            NumberOfEmployees,
                            Description,
                            OwnerId,
                            CreatedDate,
                            CreatedById,
                            LastModifiedDate,
                            LastModifiedById,
                            SystemModstamp,
                            LastActivityDate,
                            LastViewedDate,
                            LastReferencedDate,
                            IsCustomerPortal,
                            Jigsaw,
                            JigsawCompanyId,
                            AccountSource,
                            SicDesc
                      From
                        Account"}
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
