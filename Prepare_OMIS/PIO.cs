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

        internal static void GetSeparatedRecordTypes(out List<OT01> T1Records, out List<OT02> T2Records, out List<OT03> T3Records )
        {
            var r1 = new List<OT01>();
            var r2 = new List<OT02>();
            var r3 = new List<OT03>();

            var dr1 = new Dictionary<string, OT01>();
            var dup = new Dictionary<string, int>();

            string previousCaseNumber = string.Empty;
            string currentCaseNumber = string.Empty;

            //TODO:  Use Case Number + sequence number as key to avoid "duplicates".

            while (CsReader.Read())
            {
                currentCaseNumber = CsReader.GetField(1);
                switch (CsReader.GetField(3))
                {
                    case "01":
                        if(!dr1.TryGetValue(currentCaseNumber, out _))
                        {
                            dr1.Add(currentCaseNumber, CsReader.GetRecord<OT01>());
                        }
                        else
                        {
                            Console.WriteLine(currentCaseNumber);
                        }
                       r1.Add(CsReader.GetRecord<OT01>());
                       break;

                    //case "02":  // For reasons I don't understand, we miss the first (and only the first) type 02 record.  [geg] 2020-06-18
                    //    r2.Add(CsReader.GetRecord<OT02>());
                    //    break;

                    //case "03":  // spot checking file suggests that when there are multiple 03 records all are duplicates of the first. [geg] 2020-06-18
                    //    if(currentCaseNumber != previousCaseNumber)
                    //    {
                    //        previousCaseNumber = currentCaseNumber;
                    //        r3.Add(CsReader.GetRecord<OT03>());
                    //    }
                    //    break;

                    default:
                        break;
                        //throw new InvalidOperationException("Unknown record type: " + CsReader.GetField(3));
                }
                
            }
            T1Records = r1;
            T2Records = r2;
            T3Records = r3;
        }

        internal static void CreateRecordsDictionary()
        {
            var r1 = new List<OT01>();
            var r2 = new List<OT02>();
            var r3 = new List<OT03>();

            var r = new Dictionary<string, OMISRecord>();

            GetSeparatedRecordTypes(out r1, out r2, out r3 );

            var dr01 = r1
                .GroupBy(p => p.CaseNumber, StringComparer.OrdinalIgnoreCase)
                .ToDictionary(g => g.Key, g => g.First(), StringComparer.OrdinalIgnoreCase);

            List<string> c1List = new List<string>();
            foreach (var e in r1)
            {
                c1List.Add(e.CaseNumber);
            }

            var keyList = dr01.Keys.ToList();

            var list3 = c1List.Except(keyList);



            var dr02 = r2
                .GroupBy(p => p.CaseNumber, StringComparer.OrdinalIgnoreCase)
                .ToDictionary(g => g.Key, g => g.First(), StringComparer.OrdinalIgnoreCase);
       
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
    public class OMISRecord
    {
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
