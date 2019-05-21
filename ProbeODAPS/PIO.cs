using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;


using System.IO;
using System.ServiceModel;


using CsvHelper;
using CsvHelper.Configuration;

using ProbeODAPS.sforce;

namespace ProbeODAPS
{
    internal class PIO
    {
        public static StreamWriter StrWriter { get; private set; }
        public static CsvWriter CSVWriter { get; private set; }

        public static void Open(string SFObjectType, string OutPath = null)
        {
            string outputFileSpec = OutPath + Path.DirectorySeparatorChar + SFObjectType + "." + "csv";
            var config = new Configuration(new System.Globalization.CultureInfo("en-US"))
            {
                AllowComments = true,
                Delimiter = ",",
                Comment = '#',
                BadDataFound = null,
                SanitizeForInjection = false,
                IgnoreQuotes = false,
                DetectColumnCountChanges = true
            };

            StrWriter = new StreamWriter(outputFileSpec, false, Encoding.UTF8);
            CSVWriter = new CsvWriter(StrWriter, config);
        }
        public static void WriterHeader(sObject SFObject)
        {
            int d = 0;
            do
            {
                CSVWriter.WriteField(SFObject.Any[d].LocalName);
                d++;
            } while (d < SFObject.Any.Length);

            CSVWriter.NextRecord();
        }
        public static void WriteRecord(sObject SFObject)
        {
            int i = 0;
            do
            {
                CSVWriter.WriteField(SFObject.Any[i].InnerText);
                i++;
            } while (i < SFObject.Any.Length);

            CSVWriter.NextRecord();
        }
        public static void Close()
        {
            CSVWriter.Flush();
            //StrWriter.Flush();

            CSVWriter.Dispose();
            //StrWriter.Dispose();

            CSVWriter = null;
            StrWriter = null;
        }
    }
}
