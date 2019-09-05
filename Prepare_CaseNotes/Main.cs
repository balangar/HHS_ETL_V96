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


            return exitStatus;
        }
    }
}
