using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;


using System.IO;


using CsvHelper;
using CsvHelper.Configuration;
using System.Globalization;

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
                DetectColumnCountChanges = true
            };

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
        public static IEnumerable<string> GetNextRecord()
        {
            string currentCaseNumber = string.Empty;
            string previousCaseNumber = null;

            List<string> currentRecords = new List<string>();

            while (CsReader.Read())
            {
                currentCaseNumber = CsReader.GetField(1);
                if(currentCaseNumber != previousCaseNumber)
                {
                    previousCaseNumber = currentCaseNumber;
                    currentRecords = List<>
                }

            }

        }
    }
}
