using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using log4net;
using Vanilla;

using CommandLine;

using System.IO;
using System.ServiceModel;

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
        private static void PutSFRecord(sObject SFObject, String OutputPath)
        {

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
            try
            {
                foreach (sObject o in SF.GetNextSFRecord(SFObjectName, Query, EndPoint))
                {
                    PutSFRecord(o, OutFilePath);
                }

            }
            catch (Exception ex)
            {
                Logger.Error(ex.Message);
                exitStatus =-1;
            }

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
                            Id,IsDeleted,MasterRecordId,AccountId,                            LastName,FirstName,Salutation,MiddleName,Suffix,Name,                            RecordTypeId,                            MailingStreet,MailingCity,MailingState,MailingPostalCode,MailingCountry,MailingStateCode,MailingCountryCode,                            MailingLatitude,MailingLongitude,MailingGeocodeAccuracy,                            MailingAddress,                            Phone,Fax,MobilePhone,                            ReportsToId,                            Email,                            Title,Department,                            OwnerId,                            CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,LastActivityDate,LastCURequestDate,LastCUUpdateDate,LastViewedDate,LastReferencedDate,                            EmailBouncedReason,EmailBouncedDate,IsEmailBounced,PhotoUrl,Jigsaw,JigsawContactId,                            Confidential_Reason__c,Confidential__c,Contact_Type__c,                            Current_City__c,Current_Postal_Code__c,Current_State_Code__c,Current_Street__c,Employment_Status__c,Other_Confidential_Reason__c,                            Person_Id__c,                            Race__c,Sexual_Orientation__c,Specify_Other_Primary_Language__c,Veteran_Status__c,                            Social_Security_Number__c,Bed_Bugs__c,Date_of_Death__c
                        From
	                        Contact"},
                    {"Case_Notes__C",
                        @"SELECT
                            Id,
                            IsDeleted,
                            Name,RecordTypeId,
                            CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,
                            LastActivityDate,LastViewedDate,LastReferencedDate,APS_Case_Number__c,APSClientName__c,Case_Note_Create_Date_Only__c,
                            Case_Note_Interview_Date__c,Characters_in_Note_Text__c,Client_Interview_Outside_Perp_Presence__c,Client_Interview__c,
                            Client_Name__c,Contact_is_Timely__c,Copy_of_first_255_char_in_note__c,Days_Between_Contact_and_Today__c,Days_Since_Note_Created__c,
                            Days_since_last_assessment__c,Explain_Why_Perp_Attended_Interview__c,Interview_Conducted_With__c,Non_Participating_Contact__c,
                            Note_Created_Contact_Date__c,Note_Type__c,Note__c,TemporaryAPSCase__c,Case_Note_Created_in_Error__c,Case_Note__c,
                            Status__c,Supervisor_Email__c,Created_in_Error_Formatted__c,Parent__c
	                      FROM
                            Case_Notes__C"},
                    { "User",
                        @"Select
	                        Id,
                            Username,LastName,FirstName,MiddleName,Suffix,Name,CompanyName,Division,Department,Title,Street,City,State,PostalCode,Country,StateCode,CountryCode,
	                        Latitude,Longitude,GeocodeAccuracy,
	                        Address,Email,EmailPreferencesAutoBcc,EmailPreferencesAutoBccStayInTouch,EmailPreferencesStayInTouchReminder,SenderEmail,SenderName,Signature,
	                        StayInTouchSubject,StayInTouchSignature,StayInTouchNote,
                            Phone,Fax,MobilePhone,
                            Alias,CommunityNickname,BadgeText,IsActive,TimeZoneSidKey,UserRoleId,LocaleSidKey,ReceivesInfoEmails,ReceivesAdminInfoEmails,EmailEncodingKey,ProfileId,
	                        UserType,LanguageLocaleKey,EmployeeNumber,DelegatedApproverId,ManagerId,LastLoginDate,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,
	                        OfflineTrialExpirationDate,OfflinePdaTrialExpirationDate,
                            ForecastEnabled,
	                        ContactId,AccountId,CallCenterId,Extension,PortalRole,IsPortalEnabled,FederationIdentifier,AboutMe,FullPhotoUrl,SmallPhotoUrl,IsExtIndicatorVisible,
	                        OutOfOfficeMessage,MediumPhotoUrl,DigestFrequency,DefaultGroupNotificationFrequency,LastViewedDate,LastReferencedDate,BannerPhotoUrl,SmallBannerPhotoUrl,
	                        MediumBannerPhotoUrl,IsProfilePhotoActive,
	                        supervisor__c
                    From
	                        User" },
                    {"APS_Case__c",
                        @"Select
                            Id,OwnerId,IsDeleted,Name,RecordTypeId,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,
                            LastActivityDate,LastViewedDate,LastReferencedDate,ADLs_toileting_bathing_hygiene_toileting__c,
                            AP_Team_Review_Date__c,Able_to_Care_for_Themselves_Information__c,Able_to_Care_for_Themselves__c,Actions_Taken_Prior_to_this_Call__c,
                            Additional_Notes__c,Adequate_nutrition_hydration__c,Adequate_supervision__c,Agencies_Assisting_in_Investigation__c,
                            Allow_someone_to_live_with_them__c,Appropriate_medical_treatment__c,Approval_Kick_off__c,Approval_Status__c,Approximate_Age__c,
                            Approximate_Loss_of_Assets__c,Are_there_existing_conditions__c,Are_there_safety_issues_for_co__c,Assessment_Scoring_Info__c,Auxiliary_Date__c,
                            Bathing_and_hygiene__c,Best_Time_to_Reach_Client__c,Bills_finances__c,Biohazard__c,Bug_or_vermin_infestation__c,CBMS_Case_Number__c,
                            CaretakerNeglectWereThereAnyWitness__c,Caretaker_Additional_Details__c,Caretaker_Neglect__c,Case_Closed_Additional_Information__c,
                            Case_Closed_Reason__c,Case_Closure_Approval_Status__c,Case_Closure_Corrections_Completed__c,Case_Closure_Reason__c,Case_County__c,
                            Case_Duration__c,Case_Plan_Completed_Date__c,Cause_Harm_or_Loss_Information__c,Cause_Harm_or_Loss__c,Client_Address__c,Client_Alleged_Perpetrator_History__c,
                            Client_At_Risk_Info__c,Client_Name__c,Client_s_Age__c,Client_s_Age_at_Time_of_Report__c,Client_s_Current_Location__c,Client_s_Home_Phone_Number__c,
                            Community_User_Account__c,Complicating_Risks_Vulnerabilities__c,ConditionNone__c,ConditionUnabletoManageNone__c,ConditionUnabletoManageUnknown__c,
                            ConditionUnknown__c,Condition_Requiring_Total_Physical_Care__c,Confidential__c,Contagious_disease__c,Corrections_Completed__c,County_Calendar__c,
                            County_Held_Legal_Authority__c,County_Held__c,County_Type_of_Authority__c,County_Web2Case_Email_field__c,Court_Report_Completed_Date__c,Court_Report_Due_Date__c,
                            Criminal_Investigation_Status__c,Cultural_Considerations__c,CurrentStrengthsorSupportinPlace__c,Current_Strengths_Supports__c,Danger_Harm__c,Dangerous_Aggressive_Person_in_Home_c__c,
                            Dangerous_aggressive_animals__c,Dangerous_home_structure__c,Date_Case_Closed__c,Date_Closed_Date_of_Death__c,Date_Time_Created__c,Date_of_Birth__c,
                            Date_of_Death__c,Days_Between_Assessments__c,Days_Between_Client_Contact__c,Days_Open__c,Days_of_In_Activity__c,Decision_making_understanding_deficits__c,
                            Decline_in_abilities__c,Decline_in_abilities_information__c,Dementia_Alzheimer_s__c,Developmental_Intellectual_Disability__c,Diagnosed_Mental_Illness_Info__c,
                            Diagnosed_Mental_Illness__c,Difference_of_days__c,Disposition_Next_Steps__c,Documents_for_Legal_Authority__c,Does_Perp_Hold_Legal_Authority__c,Does_Perp_Live_with_Client__c,
                            Does_adult_have_support_help_in_place__c,Does_alleged_perp_have_access_to_adult__c,Does_party_receive_funds_from_adult__c,Emergency_Email_field__c,Emergency_Immediate_Harm_Information__c,
                            Emergency_Immediate_Harm__c,Evidence_of_Neglect_Exploitation_and_A__c,Explain_Why_Adult_is_Being_Mistreated__c,Exploitation_Additional_Details__c,Exploitation__c,
                            Fear_as_a_result_of_a_person_s_action__c,Firearms_or_other_weapons__c,First_Assessment_Risk_Score__c,First_Assessment_Safety_Score__c,For_another_person_s_personal_needs__c,
                            For_illegal_activity__c,For_things_adult_would_not_use_purchase__c,Frail_Elderly__c,Gated_locked_community_building__c,Gender_Code__c,Give_away_money_or_property__c,
                            Gray_Areas__c,Guardian_or_conservator_in_place__c,Harasses_the_adult_in_a_sexual_manner__c,Has_the_condition_been_diagnosed__c,Has_there_been_a_recent_change__c,
                            Have_aggressive_behavior__c,Have_self_injurious_behavior__c,Healthcare_medical_needs__c,Help_from_family_friends_others__c,Hoarding_including_animals__c,Hoarding_or_animal_hoarding__c,
                            IADLs_cleaning_laundry_cooking__c,Illegal_activity_in_the_home__c,Illegal_drug_manufacturing__c,Illegal_drug_use__c,Imminent_foreclosures_or_eviction__c,Impact_ability_to_communicate__c,
                            In_what_capacity_does_perp_have_access__c,Inappropriate_Sexual_Behaviors__c,Inappropriate_confinement__c,Inappropriate_restraint__c,Initial_Assessment_Complete_Date__c,
                            Initial_Assessment_Due_Date__c,Initial_Case_Plan_Complete_Date__c,Initial_Case_Plan_Due_Date__c,Initial_Response_Date__c,Initial_Response_Due_Date__c,Initial_Response_Type__c,
                            Interviews__c,Investigation_Approval_Status__c,Investigation_Completed_Date__c,Investigation_Due_Date__c,Is_there_a_Will_or_Power_of_Attorney__c,Is_this_a_recent_change_in_behavior__c,
                            Istheclientatrisk__c,Known_criminal_activity_history__c,Known_gang_activity__c,Lack_of_access_pathways__c,Last_Activity_Child_Objects__c,Last_Assessment_Risk_Score__c,
                            Last_Assessment_Safety_Score__c,Last_Monthly_Contact_Date__c,Late_Initial_Response__c,Law_Enforcement_Requested_by_APS__c,Major_Mental_Illness_Emotional_Disorder__c,
                            Make_changes_to_a_bank_account__c,Makes_sexual_innuendos_toward_the_adult__c,Makes_the_adult_perform_sexual_acts__c,Makes_the_adult_watch_pornography__c,Malnutrition_sudden_weight_loss_gain__c,
                            Managing_Home_Cleanliness__c,Mandated_Report__c,Marital_Status_Code__c,Medical_conditions__c,Medically_Fragile__c,Medication_management__c,Memory_Decision_Making_Problems_Info__c,
                            Memory_Decision_Making_Problems__c,Memory_deficits__c,Memory_problems__c,Mental_illness__c,Minor_Impacts__c,Mismanagement_of_medications__c,Mistreatment_Category__c,
                            Month_After_Date_Report_Received__c,Monthly_Contact_Due_Date__c,Monthly_Contact_Target_Date__c,NAMRS_Client_Age__c,NeurologicalImpairmentStrokeTBIMS__c,Neurological_Impairment_Stroke_TBI_MS__c,
                            NewScreeninOutRecommendation__c,Next_Case_Plan_Due_Date__c,No_At_Risk_Issues__c,No_Mistreatment__c,No_Physical_Medical_Condition__c,Non_working_appliances__c,
                            Non_working_utilities__c,Old_Monthly_Contact_Due_Date__c,On_going_Client_Needs__c,On_going_Perpetrator_Involvement__c,Ongoing_Alleged_Perpetrator_Involvement__c,
                            Other_Involved_Parties__c,Owner_Profile__c,POA_in_place__c,Pain_as_a_result_of_a_person_s_action__c,Perp_Legal_Authority_Type__c,Physical_Abuse_Additional_Details__c,
                            Physical_Abuse_Broken_Bones__c,Physical_Abuse_Bruises__c,Physical_Abuse_Cuts__c,Physical_Abuse_Scratches__c,Physical_Abuse_Visible_Marks__c,Physical_Abuse_Were_there_any_witnesses__c,
                            Physical_Abuse__c,Physical_Impairment__c,Physical_Medical_Additional_Details__c,Physical_Medical_Conditions_Information__c,Physical_Medical_Conditions__c,Physical_conditions__c,
                            Police_frequently_called_to_the_home__c,Poor_hygiene_not_bathing__c,Previous_Assessment_Completed_Date__c,Previous_Monthly_Contact__c,Primary_Language_Code__c,Professional_services_in_place__c,
                            Questionable_transfer_of_money_property__c,Re_Assessment_Completed_Date__c,Re_Assessment_Due_Date__c,Ready_to_Close_Case__c,Refuses_recommended_services__c,Rep_payee_in_place__c,
                            Report_came_from_Law_Enforcement__c,ReportingPartyActionsAlreadyTaken__c,ReportingPartyActions__c,Reporting_Party_Agency_Name__c,Reporting_Party_Name__c,Reporting_Party_Relationship_Notes__c,
                            Reporting_Party_Relationship_Role__c,Reporting_Party_Relationship_to_Client__c,ResponseDueDate__c,Response_Explanation__c,Reviewed_by_AP_Team__c,Risk_Score_Difference__c,
                            Risk_Score_Outcome__c,Safety_Improvement_Percentage__c,Safety_Notes__c,Safety_Perception__c,Safety_Score_Difference__c,Safety_Score_Outcome__c,Safety_Warning__c,Scorecard_Review__c,
                            Screen_In_Out_Summary__c,Screen_In_Screen_Out_Recommendation__c,Screen_Out_Reason__c,Security_system_cameras__c,Self_Neglect_Additional_Details__c,Self_Neglect_Substance_Abuse__c,
                            Self_Neglect__c,Sexual_Abuse_Additional_Details__c,Sexual_Abuse_Broken_Bones__c,Sexual_Abuse_Bruises__c,Sexual_Abuse_Cuts__c,Sexual_Abuse_Scratches__c,Sexual_Abuse_Visible_Marks__c,
                            Sexual_Abuse_Were_there_any_witnesses__c,Sexual_Abuse__c,Sign_a_quit_claim_deed__c,Significant_Impacts__c,Social_interaction_family_friends_visit__c,Specify_Other_Relationship__c,
                            Specify_Other_Screen_Out_Reason__c,Specify_Other_current_location__c,Specify_if_No__c,Specify_why_no_assistance_was_received__c,Status__c,Substance_Abuse_including_RX_meds__c,
                            Substance_abuse__c,Supervisor_E_mail__c,Supervisor_Name__c,Supervisor__c,Support_Network_Lives_with_Client__c,Support_Network_Narrative__c,Team_Members__c,TemporaryContact__c,
                            Test_support_number_of_county_held_auth__c,Timely_Initial_Assessment__c,Timely_Initial_Case_Plan__c,Timely_Investigation__c,Timely_Monthly_Contact_2__c,Timely_Monthly_Contact__c,
                            To_do_anything_they_wouldn_t_do_normally__c,Transportation__c,Unable_to_Care_for_Themselves_Info__c,Unable_to_Care_for_Themselves__c,Unable_to_Protect_Themselves_Information__c,
                            Unable_to_Protect_Themselves__c,Unable_to_protect_themselves_checkbox__c,Unexplained_loss_of_money_property__c,Unknown_At_Risk_Population__c,Unpaid_utilities__c,Unsafe_neighborhood__c,
                            Unsafe_structure__c,Untreated_medical_condition__c,Untreated_mental_health_need__c,Untreated_mental_illness__c,Vermin_pest_infestation__c,Wander__c,Was_Assistance_Received__c,
                            What_are_the_details_of_the_conditions__c,What_is_the_Concern_You_Want_to_Report__c,What_would_be_helpful_improve_situation__c,Who_is_responsible_for_adult_s_care__c,
                            Why_Did_Reporting_Party_Call__c,Without_adult_s_knowledge_permission__c,Worker_Safety_Concerns__c,Worker_Safety_Issues_Desc__c,Worker_Safety_Issues__c,X3rd_Most_Recent_Monthly_Contact__c,
                            X4th_Most_Recent_Monthly_Contact__c,Xof_Cases__c,Xof_Intakes__c,Assessment_Count__c,Case_Plan_Count__c,Count_of_Allegations__c,In_progress_case_plans__c,Substantiated_Exploitation__c,
                            Sum_of_County_Funds_Used__c,Xof_Monthly_Contacts__c,of_Case_Plans__c,of_Completed_Assessments__c,of_In_Progress_Assessments__c,of_No_Mistreatment_Allegations__c,of_Not_Yet_Implemented_Client_Services__c,
                            of_Open_Allegations__c,of_Open_Perp_Findings__c,of_Substantiated_Allegations__c,Case_Decision_Approval_Status__c,Case_Decision_Date_Time__c,Case_Decision_Due_Date__c,
                            Case_Decision_Reason__c,Case_Decision__c,Case_Plan_Date_Timely__c,Case_Stage__c,Case_Transfer_Required__c,Client_Current_Address__c,Companion_Case__c,Confidential_Reason__c,
                            Date_Notice_of_Intent_Letter_Provided__c,Demeaning_insults__c,Emotional_Abuse_Were_there_any_witnesses__c,Emotional_Verbal_Abuse_Additional_Detail__c,Emotional_Verbal_Abuse__c,
                            Extension_Reason__c,Extension_Request__c,Harassment__c,Humiliation__c,INR_Additional_Details__c,Ignoring__c,Information_and_Referral__c,Initial_Risk_Assessment_Status__c,
                            Initiation_Date_Time__c,Initiation_Due_Date_Time__c,Intimidation_Threats__c,Isolation__c,Location_of_Emotional_Abuse_Allegation__c,Location_of_Exploitation_Allegation__c,
                            Location_of_Neglect_Allegation__c,Location_of_Physical_Abuse_Allegation__c,Location_of_Self_Neglect_Allegation__c,Location_of_Sexual_Abuse_Allegation__c,Other_Confidential_Reason__c,
                            ReAssessment_Due_Date__c,Ready_for_Screening_Decision__c,Reassessment_Complete_Date__c,Referral_Source__c,Referral_Submitted_Date_Time__c,Report_Effective_Date_Time__c,
                            ResponseDueDateTime__c,STD__c,Sequencing_Number__c,Sexual_Exploitation__c,Transfer_Case_Reason__c,Transferring_County_Decision__c,Verbal_Assaults_Yelling__c,Max_Reassessment_Date__c,
                            Does_Reporting_Party_Live_with_Client__c,No_Maltreatment_Additional_Details__c,Primary_Maltreatment__c,Re_Assessment_Close__c,Bed_Bugs__c,Screened_Out_Date_Time__c,Owner_County__c,
                            of_Completed_Assessments_Formula__c,Safety_Notes2__c
                          FROM
                            APS_Case__c"}

                };

            int exitStatus = -1;
            try
            {
                if (SF.Login(SF_USER_NAME, SF_PASS_WORD, out SoapClient EndpointClient))
                {
                    exitStatus = CommandLine.Parser.Default.ParseArguments<DocumentOptions, ExtractOptions, ListOptions>(args)
                        .MapResult(
                            (DocumentOptions o) => DocumentSFObjects(o, EndpointClient),
                            (ExtractOptions o) => ExtractSFObjects(o, sfObjectQueries, EndpointClient),
                            (ListOptions o) => ListSFObjects(o, EndpointClient),
                            errs => 1);

                }

                SF.Logout(EndpointClient);
            }
            catch (Exception ex)
            {
                exitStatus = -1;
                throw;
            }

            return exitStatus;
        }
    }
}

