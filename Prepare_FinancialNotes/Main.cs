using System.IO;
using System;
using System.Reflection;

using System.Data.SqlClient;

using log4net;

namespace Prepare_FinancialNotes
{

    internal class Main
    {
        private static int FileCount { get; set; }

        private static readonly SqlConnection cn = Database.SqlConnection();

        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        private static string GetDestinationFileSpec(string SourceFileSpec)
        {
            const int NEW_SUBDIRECTORY_COUNT = 1000;
            const string DESTINATION_ROOT = @"\\ms-hhs-san\ITS\_Archive\OCSS\FinancialNotes";

            int destSubFolder = (FileCount / NEW_SUBDIRECTORY_COUNT) * NEW_SUBDIRECTORY_COUNT;
            string destFilePath = string.Format(@"{0}\{1}", DESTINATION_ROOT, destSubFolder.ToString().PadLeft(6, '0'));


            if (FileCount % NEW_SUBDIRECTORY_COUNT == 0)
            {
                Directory.CreateDirectory(destFilePath);

                Logger.InfoFormat("Financial File Count: {0}  Destination File Path: {1}", FileCount.ToString(), destFilePath);
            }

            return Path.Combine(destFilePath, Path.GetFileName(SourceFileSpec));

        }
        private static void CopyFinancialNoteFile(string SourceFileSpec, string DestinationFileSpec) => File.Copy(SourceFileSpec, DestinationFileSpec, true);


        internal static int Work()
        {
            int exitStatus = 0;

            foreach (string s in Directory.EnumerateFiles(@"\\ms-hhs-psql2\c$\SqlDB\SIS\Source\Stage\Working\LoadOCSS-Archive\OFIN", "*.txt", SearchOption.TopDirectoryOnly))
            {
                string destFileSpec = GetDestinationFileSpec(s);
                foreach (FinancialNote c in PIO.GetNextFinancialNote(s))
                {
                    Logger.InfoFormat(@"{0}", c);
                    //WriteFinancialNoteRecord(c, destFileSpec);
                    //Logger.InfoFormat(
                    //    "FileSpec: {0}\tCreated By: {6}" + "\n\r" + "Custodial Parent ID: {1}  Absent Parent ID: {2}  Event Date: {3}  Order Number: {4}" + "\n\r" + "Contents:\t {5} \n\r",
                    //    s, c.CustodialParentID, c.AbsentParentID, c.EventDate, c.OrderNo, c.SingleLine, c.CreatedBy);
                }

                CopyFinancialNoteFile(s, destFileSpec);
                FileCount++;

            }
            cn.Close();
            return exitStatus;
        }
    }
}
