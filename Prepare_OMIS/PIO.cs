using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;


using System.IO;


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
        public static StreamReader StrReader { get; private set; }
        public static CsvReader CsReader { get; private set; }

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
        }

        internal static void GetRecordLists(out List<OT01> Type1Records)
        {
            var r1 = new List<OT01>();
            var r2 = new List<OT02>();
            var r3 = new List<OT03>();

            while (CsReader.Read())
            {
                {
                    switch (CsReader.GetField(3))
                    {
                        case "01":
                            r1.Add(CsReader.GetRecord<OT01>());
                            break;

                        case "02":
                            r2.Add(CsReader.GetRecord<OT02>());
                            break;

                        case "03":
                            r3.Add(CsReader.GetRecord<OT03>());
                            break;

                        default:
                            break;
                    }
                }
            }
            Type1Records = r1;

        }

        internal static void CreateRecordsDictionary()
        {
            var r1 = new List<OT01>();

            var r = new Dictionary<string, Tuple<OT01>>();

            GetRecordLists(out r1);


        }

        public static void GetNextRecord()
        {
            CreateRecordsDictionary();
        }
        //public static IEnumerable<string> GetNextRecord()
        //{
        //    string currentCaseNumber = string.Empty;
        //    string previousCaseNumber = null;


        //}
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

}
