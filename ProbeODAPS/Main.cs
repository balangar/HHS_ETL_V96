using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using log4net;

using CommandLine;

using System.IO;

using ProbeODAPS.sforce;
using System.Text;

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
        [Verb("Repl", HelpText = "Read Execute Print Loop")]
        internal class ReplOptions
        {

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
                returnStatus = -1;
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
            int exitStatus = 0;

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
                exitStatus = -1;
                throw;
            }
            return exitStatus;
        }
        private static int RunRepl(ReplOptions o, SoapClient endPointClient)
        {
            while (true)
            {
                bool needHeader;
                string query = string.Empty;

                for (needHeader = true, Console.Write("Enter Query : "), query = Console.ReadLine(); query != ""; needHeader = true, Console.Write("Enter Query : "), query = Console.ReadLine())
                {
                    try
                    {
                        foreach (sObject item in SF.GetNextSFRecord(query, endPointClient, ""))
                        {
                            if (needHeader)
                            {
                                foreach (var field in item.Any)
                                {
                                    Console.Write(field.LocalName + "|");
                                }
                                Console.WriteLine();
                                needHeader = false;
                            }

                            foreach (var field in item.Any)
                            {
                                Console.Write(field.InnerText + "|");
                            }
                            Console.WriteLine();
                        }
                    }
                    catch (Exception ex)
                    {
                        Program.Logger.Error(ex.Message);
                    }
                }
                return 0;
            }
        }
        internal static int Work(string[] args)
        {
            Dictionary<string, string> sfObjectQueries = new Dictionary<string, string>()
                {
                    {"Contact",
                        @"Select
                            ID, OwnerId, AccountId, MasterRecordId,
                            IsDeleted,
                            CreatedById,CreatedDate,
                            LastModifiedById, LastModifiedDate, SystemModstamp,
                            Salutation,
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
                            Approx_age__C,
                            Gender_Code__C,
                            Gender__C,
                            Hoarding_or_animal_hoarding__c,
                            Income_Source__C,
                            Marital_status__C,
                            Medicaid__C,
                            Medicare__C,
                            Race__C,
                            SSN__C,
                            Person_ID__C,
                            Veteran_Status__C,
                            Bed_Bugs__c
                        From
	                        Contact
                        Where
                            Account.Name = 'Cuyahoga'"},
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
	                        APSClientName__c,
	                        Case_Note_Create_Date_Only__c,
	                        Case_Note_Interview_Date__c,
	                        Characters_in_Note_Text__c,
	                        Client_Interview_Outside_Perp_Presence__c,
	                        Client_Interview__c,
	                        Client_Name__c,
	                        Contact_is_Timely__c,
	                        Copy_of_first_255_char_in_note__c,
	                        Days_Between_Contact_and_Today__c,
	                        Days_Since_Note_Created__c,
	                        Days_since_last_assessment__c,
	                        Explain_Why_Perp_Attended_Interview__c,
	                        Interview_Conducted_With__c,
	                        Non_Participating_Contact__c,
	                        Note_Created_Contact_Date__c,
	                        Note_Type__c,
	                        Note__c,
	                        TemporaryAPSCase__c,
	                        Case_Note_Created_in_Error__c,
	                        Case_Note__c,
	                        Status__c,
	                        Supervisor_Email__c,
	                        Created_in_Error_Formatted__c,
	                        Parent__c
                        FROM
                            Case_Notes__C
                        WHERE
                            CreatedDate >= 2019-04-01T00:00:01Z"},
                    { "User",
                        @"Select
                            ID, AccountID, ContactID,
                            CreatedById,CreatedDate,
                            LastModifiedById, LastModifiedDate, SystemModstamp,
                            Username,
                            FirstName,
                            LastName,
                            Name,
                            Email,
                            Phone,
                            Managerid,
                            Supervisor__c
                        From
	                        User" },
                    {"APS_Case__c",
                        @"Select
                            Id,
                            OwnerId,Owner_County__c,RecordTypeID,
                            IsDeleted,
                            CreatedById,CreatedDate,
                            LastModifiedById, LastModifiedDate, SystemModstamp,
                            Name,
                            Approximate_Age__c,
                            Caretaker_Neglect__c,
                            Case_Closed_Reason__c,
                            Client_Address__c,
                            Client_Name__c,
                            Client_s_Age__c	,
                            Client_s_Home_Phone_Number__c,
                            Date_of_Birth__c,
                            Exploitation__c,
                            Gender_Code__c,
                            Marital_Status_Code__c,
                            Physical_Abuse__c,
                            Reporting_Party_Agency_Name__c,
                            Reporting_Party_Name__c,
                            Self_Neglect__c,
                            Sexual_Abuse__c,
                            Supervisor_E_mail__c,
                            Supervisor_Name__c,
                            Supervisor__c,
                            Hoarding_or_animal_hoarding__c,
                            Emotional_Verbal_Abuse__c,
                            Referral_Submitted_Date_Time__c,
                            Bed_Bugs__c,
                            Substance_abuse__c,
                            Diagnosed_Mental_Illness_Info__c,	 
                            Diagnosed_Mental_Illness__c,
                            Case_Decision_Date_Time__c
                        FROM
                            APS_Case__c
                        Where
                            Case_County__c = 'Cuyahoga'"},
                    {"Account",
                        @"Select
                                Id,
                                IsDeleted,
                                CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,
                                MasterRecordId,
                                OwnerId,
                                ParentId,
                                RecordTypeId,
                                Type,
                                Name,
                                Description,
                                LastActivityDate,LastViewedDate,LastReferencedDate
                         From
                            Account"}
                };

            int exitStatus = 0;
            try
            {
                if (SF.Login(out SoapClient EndpointClient))    // Use "default" SF connection info
                {
                    exitStatus = CommandLine.Parser.Default.ParseArguments<DocumentOptions, ExtractOptions, ListOptions, CountOptions, ReplOptions>(args)
                        .MapResult(
                            (DocumentOptions o) => DocumentSFObjects(o, EndpointClient),
                            (ExtractOptions o) => ExtractSFObjects(o, sfObjectQueries, EndpointClient),
                            (ListOptions o) => ListSFObjects(o, EndpointClient),
                            (CountOptions o) => CountSFObjects(o, EndpointClient),
                            (ReplOptions o) => RunRepl(o, EndpointClient),
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
