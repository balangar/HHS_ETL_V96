using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;


using System.IO;
using System.Data.SqlClient;


using CsvHelper;
using CsvHelper.Configuration;
using System.Globalization;
using System.Security.Cryptography;
using log4net.Repository.Hierarchy;
using CsvHelper.Expressions;

namespace Prepare_OMIS
{

    class PIO
    {
        internal static readonly SqlConnection cn = Database.SqlConnection();

        internal static StreamReader StrReader { get; private set; }
        internal static CsvReader CsReader { get; private set; }

        internal static Dictionary<int, OT01> dr1 = new Dictionary<int, OT01>();
        internal static Dictionary<int, OT02> dr2 = new Dictionary<int, OT02>();
        internal static Dictionary<int, OT03> dr3 = new Dictionary<int, OT03>();

        public static void Open(string InputFileSpec = null)
        {
            var config = new CsvConfiguration(new System.Globalization.CultureInfo("en-US"))
            {
                AllowComments = true,
                Delimiter = "|",
                Comment = '#',
                BadDataFound = null,
                SanitizeForInjection = false,
                IgnoreQuotes = true,
                DetectColumnCountChanges = false,
                MissingFieldFound = null
            };

            config.RegisterClassMap<OT01Map>();
            config.RegisterClassMap<OT02Map>();
            config.RegisterClassMap<OT03Map>();


            StrReader = new StreamReader(InputFileSpec);
            CsReader = new CsvReader(StrReader, config, false);
        }
        public static void Close()
        {
            CsReader.Dispose();
            StrReader.Dispose();

            CsReader = null;
            StrReader = null;

            cn.Close();
            cn.Dispose();
        }
        internal static void GetSeparatedRecordTypes()
        {

            string previousCaseNumber = string.Empty;
            bool addType3Entry = true;
            bool addType2Entry = true;
            try
            {
                for (int currentGroupNumber = 0; CsReader.Read();)
                {
                    if (previousCaseNumber != CsReader.GetField(1))
                    {
                        previousCaseNumber = CsReader.GetField(1);
                        addType3Entry = true;
                        addType2Entry = true;
                        currentGroupNumber++;
                    }

                    switch (CsReader.GetField(3))
                    {
                        /* Possible to have distinct groups for the same consecutive case number.  Example:  A000835801. 
                         * 
                         */
                        case "01":
                            if (dr1.ContainsKey(currentGroupNumber))
                            {
                                currentGroupNumber++;
                                addType2Entry = true;
                                addType3Entry = true;
                            }
                            dr1.Add(currentGroupNumber, CsReader.GetRecord<OT01>());
                            break;

                        /*
                         * For reasons I don't understand, we miss the first (and only the first) type 02 record.  [geg] 2020-06-18
                         * It's possible to have multiple 02 records in the same record group. I spot checked a (very) few.  They appear to be duplicates.  Example:  D008935503.    [geg] 2020-06-19.
                         */
                        case "02":
                            if (addType2Entry)
                            {
                                dr2.Add(currentGroupNumber, CsReader.GetRecord<OT02>());
                                addType2Entry = false;
                            }
                            break;

                        case "03":  // Don't add  what will be, as far as I can tell, any duplicate type 3 records for the same group. [geg]
                            if (addType3Entry)
                            {
                                dr3.Add(currentGroupNumber, CsReader.GetRecord<OT03>());
                                addType3Entry = false;
                            }
                            break;

                        default:
                            throw new InvalidOperationException("Unknown record type: " + CsReader.GetField(3));
                    }
                }

            }
#pragma warning disable CS0168 // Variable is declared but never used
            catch (Exception ex)
#pragma warning restore CS0168 // Variable is declared but never used
            {
                throw;  // Gives me a chance to bug hunt before all of the context is lost. [geg]
            }
        }
        internal static List<OMIS> GetOMISRecords()
        {
            List<OMIS> orecs = new List<OMIS>();

            GetSeparatedRecordTypes();

            // I realize the following is clunky.  I expect, though, that once this code works, it will only ever be executed once.  [geg]  2020-06-25

            OMIS nr; 
            //foreach(var e1 in dr1)      // Consolidate all record groups s.t. group begins with a type 01 record. This is not always the case. Example:  A000781701 [geg]
            //{
            //    nr = new OMIS();
            //    int e1Key = e1.Key;

            //    nr.GroupNumber = e1Key;
            //    nr.CaseNumber = e1.Value.CaseNumber;

            //    nr.OrderFilingDate = e1.Value.OrderFilingDate;
            //    nr.LastModifyDate = e1.Value.LastModifyDate;
            //    nr.WageAttStartDate = e1.Value.WageAttStartDate;
            //    nr.WageAttEndDate = e1.Value.WageAttEndDate;
            //    nr.OrderReviewDate = e1.Value.OrderReviewDate;
            //    nr.AbeyanceIndicator = e1.Value.AbeyanceIndicator;
            //    nr.OutOfStateSONum = e1.Value.OutOfStateSONum;


            //    if (dr2.ContainsKey(e1Key))
            //    {
            //        nr.AmountOrderHold = dr2[e1Key].AmountOrderHold.Substring(0,7) + "." + dr2[e1Key].AmountOrderHold.Substring(7, 2);    // I believe these fields are always exactly of length 9.  [geg]
            //        nr.AmountODTHold = dr2[e1Key].AmountODTHold.Substring(0, 7) + "." + dr2[e1Key].AmountODTHold.Substring(7, 2);
            //        nr.AmountIRSHold = dr2[e1Key].AmountIRSHold.Substring(0,7) + "." + dr2[e1Key].AmountIRSHold.Substring(7, 2);
            //        nr.AmountIRSJointHold = dr2[e1Key].AmountIRSJointHold.Substring(0, 7) + "." + dr2[e1Key].AmountIRSJointHold.Substring(7, 2);
            //        nr.AmountLumpHold = dr2[e1Key].AmountLumpHold.Substring(0, 7) + "." + dr2[e1Key].AmountLumpHold.Substring(0, 2);

            //        nr.LastCalcDate = dr2[e1Key].LastCalcDate;
            //    }

            //    if (dr3.ContainsKey(e1Key))
            //    {
            //        nr.Comments = dr3[e1Key].Comment;
            //    }

            //    orecs.Add(nr);
            //}

            foreach (var e2 in dr2)
            {
                nr = new OMIS();
                int e2Key = e2.Key;
                if (!dr1.ContainsKey(e2Key))
                {


                    nr.GroupNumber = e2Key;
                    nr.CaseNumber = dr2[e2Key].CaseNumber;

                    nr.CaseNumber = string.Empty;
                    nr.OrderFilingDate = string.Empty;
                    nr.LastModifyDate = string.Empty;
                    nr.WageAttStartDate = string.Empty;
                    nr.WageAttEndDate = string.Empty;
                    nr.OrderReviewDate = string.Empty;
                    nr.AbeyanceIndicator = string.Empty;
                    nr.OutOfStateSONum = string.Empty;

                    nr.AmountOrderHold = dr2[e2Key].AmountOrderHold.Substring(0, 7) + "." + dr2[e2Key].AmountOrderHold.Substring(7, 2);    // I believe these fields are always exactly of length 9.  [geg]
                    nr.AmountODTHold = dr2[e2Key].AmountODTHold.Substring(0, 7) + "." + dr2[e2Key].AmountODTHold.Substring(7, 2);
                    nr.AmountIRSHold = dr2[e2Key].AmountIRSHold.Substring(0, 7) + "." + dr2[e2Key].AmountIRSHold.Substring(7, 2);
                    nr.AmountIRSJointHold = dr2[e2Key].AmountIRSJointHold.Substring(0, 7) + "." + dr2[e2Key].AmountIRSJointHold.Substring(7, 2);
                    nr.AmountLumpHold = dr2[e2Key].AmountLumpHold.Substring(0, 7) + "." + dr2[e2Key].AmountLumpHold.Substring(0, 2);

                    nr.LastCalcDate = dr2[e2Key].LastCalcDate;
                }

                //if (dr3.ContainsKey(e2Key))
                //{
                //    nr.Comments = dr3[e2Key].Comment;
                //}

                orecs.Add(nr);
            }

            //foreach (var e3 in dr3)
            //{
            //    nr = new OMIS();
            //    int e3Key = e3.Key;
            //    if (!dr1.ContainsKey(e3Key) && !dr2.ContainsKey(e3Key))
            //    {
            //        nr.GroupNumber = e3Key;
            //        nr.CaseNumber = dr3[e3Key].CaseNumber;

            //        nr.CaseNumber = string.Empty;
            //        nr.OrderFilingDate = string.Empty;
            //        nr.LastModifyDate = string.Empty;
            //        nr.WageAttStartDate = string.Empty;
            //        nr.WageAttEndDate = string.Empty;
            //        nr.OrderReviewDate = string.Empty;
            //        nr.AbeyanceIndicator = string.Empty;
            //        nr.OutOfStateSONum = string.Empty;

            //        nr.AmountOrderHold = string.Empty;
            //        nr.AmountODTHold = string.Empty;
            //        nr.AmountIRSHold = string.Empty;
            //        nr.AmountIRSJointHold = string.Empty;
            //        nr.AmountLumpHold = string.Empty;
            //        nr.LastCalcDate = string.Empty;

            //        nr.Comments = dr3[e3Key].Comment;

            //        orecs.Add(nr);
            //    }
            //}

            return orecs;
        }
        public static IEnumerable<OMIS> GetNextRecord()
        {
            /*
             * Separate the file into three "piles" -- one for each type of record in the file.
             * Somehow combine these three "piles' into just one "pile" -- of OMIS (staging) records
             * Return these (one at a time) to Main
             */
            foreach( var e in GetOMISRecords())
            {
                yield return e;
            }

            //public static IEnumerable<string> GetNextRecord()
            //{
            //    string currentCaseNumber = string.Empty;
            //    string previousCaseNumber = null;


            //}
        }

        public static void PutRecord(OMIS R)
        {
            //ToDo:  Maybe I need a merge statement here
            const string cmdText = "INSERT INTO Staging.OMIS(GroupNumber,CaseNumber,OrderFilingDate,LastModifyDate,WageAttStartDate,WageAttEndDate,OrderReviewDate,AbeyanceIndicator,OutOfStateSONum,AmountOrderHold,AmountODTHold,AmountIRSHold,AmountIRSJointHold,AmountLumpHold,LastCalcDate,Comments) VALUES(@GroupNumber,@CaseNumber,@OrderFilingDate,@LastModifyDate,@WageAttStartDate,@WageAttEndDate,@OrderReviewDate,@AbeyanceIndicator,@OutOfStateSONum,@AmountOrderHold,@AmountODTHold,@AmountIRSHold,@AmountIRSJointHold,@AmountLumpHold,@LastCalcDate,@Comments)";
            using (var command = new SqlCommand(cmdText, cn))
            {
                command.Parameters.AddWithValue("@GroupNumber", R.GroupNumber);
                command.Parameters.AddWithValue("@CaseNumber", R.CaseNumber);

                command.Parameters.AddWithValue("@OrderFilingDate", R.OrderFilingDate);
                command.Parameters.AddWithValue("@LastModifyDate", R.LastModifyDate);
                command.Parameters.AddWithValue("@WageAttStartDate", R.WageAttStartDate);
                command.Parameters.AddWithValue("@WageAttEndDate", R.WageAttEndDate);
                command.Parameters.AddWithValue("@OrderReviewDate", R.OrderReviewDate);
                command.Parameters.AddWithValue("@AbeyanceIndicator", R.AbeyanceIndicator);
                command.Parameters.AddWithValue("@OutOfStateSONum", R.OutOfStateSONum);

                command.Parameters.AddWithValue("@AmountOrderHold", R.AmountOrderHold.IsNull() ? string.Empty : R.AmountOrderHold);
                command.Parameters.AddWithValue("@AmountODTHold", R.AmountODTHold.IsNull() ? string.Empty : R.AmountODTHold);
                command.Parameters.AddWithValue("@AmountIRSHold", R.AmountIRSHold.IsNull() ? string.Empty : R.AmountIRSHold);
                command.Parameters.AddWithValue("@AmountIRSJointHold", R.AmountIRSJointHold.IsNull() ? string.Empty : R.AmountIRSJointHold);
                command.Parameters.AddWithValue("@AmountLumpHold", R.AmountLumpHold.IsNull() ? string.Empty : R.AmountLumpHold);
                command.Parameters.AddWithValue("@LastCalcDate", R.LastCalcDate.IsNull() ? string.Empty : R.LastCalcDate);

                command.Parameters.AddWithValue("@Comments", R.Comments.IsNull() ? string.Empty : R.Comments);


                command.ExecuteNonQuery();
            }

        }
        public class OT01
        {
            public string CaseNumber { get; set; }
            public string OrderFilingDate { get; set; }
            public string LastModifyDate { get; set; }
            public string WageAttStartDate { get; set; }
            public string WageAttEndDate { get; set; }
            public string OrderReviewDate { get; set; }
            public string AbeyanceIndicator { get; set; }
            public string OutOfStateSONum { get; set; }

        }
        public sealed class OT01Map : ClassMap<OT01>
        {
            OT01Map()
            {
                Map(m => m.CaseNumber).Index(1);
                Map(m => m.OrderFilingDate).Index(4);
                Map(m => m.LastModifyDate).Index(5);
                Map(m => m.WageAttStartDate).Index(6);
                Map(m => m.WageAttEndDate).Index(7);
                Map(m => m.OrderReviewDate).Index(8);
                Map(m => m.AbeyanceIndicator).Index(9);
                Map(m => m.OutOfStateSONum).Index(10);

            }
        }
        public class OT02
        {
            public string CaseNumber { get; set; }
            public string AmountOrderHold { get; set; }
            public string AmountODTHold { get; set; }
            public string AmountIRSHold { get; set; }
            public string AmountIRSJointHold { get; set; }
            public string AmountLumpHold { get; set; }
            public string LastCalcDate { get; set; }
        }
        public sealed class OT02Map : ClassMap<OT02>
        {
            OT02Map()
            {
                Map(m => m.CaseNumber).Index(1);
                Map(m => m.AmountOrderHold).Index(4);
                Map(m => m.AmountODTHold).Index(5);
                Map(m => m.AmountIRSHold).Index(6);
                Map(m => m.AmountIRSJointHold).Index(7);
                Map(m => m.AmountLumpHold).Index(8);
                Map(m => m.LastCalcDate).Index(9);

            }
        }
        public class OT03
        {
            public string CaseNumber { get; set; }
            public string Comment { get; set; }
        }
        public sealed class OT03Map : ClassMap<OT03>
        {
            OT03Map()
            {
                Map(m => m.CaseNumber).Index(1);
                Map(m => m.Comment).Index(4);
            }
        }
        public class OMIS
        {
            public int GroupNumber { get; set; }
            public string CaseNumber { get; set; }

            public string OrderFilingDate { get; set; }
            public string LastModifyDate { get; set; }
            public string WageAttStartDate { get; set; }
            public string WageAttEndDate { get; set; }
            public string OrderReviewDate { get; set; }
            public string AbeyanceIndicator { get; set; }
            public string OutOfStateSONum { get; set; }

            public string AmountOrderHold { get; set; }
            public string AmountODTHold { get; set; }
            public string AmountIRSHold { get; set; }
            public string AmountIRSJointHold { get; set; }
            public string AmountLumpHold { get; set; }
            public string LastCalcDate { get; set; }

            public string Comments { get; set; }
        }

    }
}
