using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using log4net;

using CommandLine;

using System.IO;


using System.Text;

namespace Prepare_CaseNotes
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Reflection;
    using System.Text;
    using System.Threading.Tasks;
    using log4net;

    internal class Main
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        [Verb("Process", HelpText = "Processing options")]
        internal class DocumentOptions
        {
            [Option('v', "Verbose", Required = false, Default = false, HelpText = "Set output to verbose messages")]
            public bool Verbose { get; set; }

            [Option("SourcePath", Required = false, Default = @"C:\Temp", HelpText = "Source file path")]
            public string SourcePath { get; set; }

            [Option("DestinationPath", Required = false, Default = @"C:\Temp", HelpText = "Destination path")]
            public string DestinationPath { get; set; }

        }
        [Verb("Repl", HelpText = "Read Execute Print Loop")]
        internal class ReplOptions
        {

        }

        internal static int Work(string[] args)
        {
            int exitStatus = 0;

            foreach(CaseNote c in PIO.GetNextCaseNote(@"\\ms-hhs-psql2\c$\SqlDB\SIS\Source\Stage\Working\LoadOCSS-Archive\SBPT\000070235A00111460.txt"))
            {
                Logger.InfoFormat("Custodial Parent ID: {0}  AbsentParentID: {1}  EventDate: {2}  Contents: {3}  FileSpec: {4}", c.CustodialParentID, c.AbsentParentID, c.EventDate, c.SingleLine, "SomeSpec");
            }


            return exitStatus;
        }
    }
}
