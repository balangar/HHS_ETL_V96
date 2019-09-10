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

    using System.Data.SqlClient;

    using log4net;

    internal class Main
    {
        private static bool firstCall = true;
        private static SqlConnection conn = Database.SqlConnection();
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        private static void WriteCaseNoteRecord(CaseNote Note, string DestFileSpec)
        {


        }
        internal static int Work(string[] args)
        {
            string sourcePath = @"\\ms-hhs-psql2\c$\SqlDB\SIS\Source\Stage\Working\LoadOCSS-Archive\SBPT";
            string destPath = @"\\ms-hhs-san\ITS\_Archive\OCSS\CaseNotes";

            int exitStatus = 0;
            int tempCount = 0;

            foreach(string s in Directory.EnumerateFiles(sourcePath, "*.txt", SearchOption.TopDirectoryOnly))
            {
                if (tempCount > 1)
                {
                    break;
                }
                else
                {
                    string destFileSpec = Path.Combine(destPath, Path.GetFileName(s));

                    foreach (CaseNote c in PIO.GetNextCaseNote(s))
                    {

                        WriteCaseNoteRecord(c, destFileSpec);
                        Logger.InfoFormat(
                            "FileSpec: {0}\tCreated By: {6}" + "\n\r" + "Custodial Parent ID: {1}  Absent Parent ID: {2}  Event Date: {3}  Order Number: {4}" + "\n\r" + "Contents:\t {5} \n\r",
                            s, c.CustodialParentID, c.AbsentParentID, c.EventDate, c.OrderNo, c.SingleLine, c.CreatedBy);
                    }
                    tempCount++;

                    File.Copy(s, destFileSpec, true);
                }

            }

            conn.Close();
            return exitStatus;
        }
    }
}
