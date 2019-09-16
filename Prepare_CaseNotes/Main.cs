
using System.IO;
using System;
using System.Reflection;

using System.Data.SqlClient;

using log4net;

namespace Prepare_CaseNotes
{
    internal class Main
    {
        private static int CaseFileCount { get; set; }
       

        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        private static readonly SqlConnection cn = Database.SqlConnection();


        private static string GetDestinationFileSpec(string SourceFileSpec)
        {
            const int NEW_SUBDIRECTORY_COUNT = 1000;

            string destParent = @"\\ms-hhs-san\ITS\_Archive\OCSS\CaseNotes";
            string destFilePath = string.Empty;


            if (CaseFileCount % NEW_SUBDIRECTORY_COUNT == 0)
            {
                destFilePath = string.Format(@"{0}\{1}", destParent, CaseFileCount.ToString().PadLeft(6, '0'));
                Directory.CreateDirectory(destFilePath);

                Logger.InfoFormat("Case File Count: {0}  Destination File Path: {1}", CaseFileCount.ToString(), destFilePath);

            }

            return Path.Combine(destFilePath, Path.GetFileName(SourceFileSpec));

        }
        private static void WriteCaseNoteRecord(CaseNote Note, string DestFileSpec)
        {
            const string cmdText = @"INSERT INTO dbo.CaseNotes(CreatedBy, EventDate, CustodialParentID, AbsentParentID, OrderNo, Contents, FilePath, FileName)" + " " +
                                   @"VALUES(@CreatedBy, @EventDate, @CustodialParentID, @AbsentParentID, @OrderNo, @Contents, @FilePath, @FileName)";
            using (var command = new SqlCommand(cmdText, cn))
            {
                command.Parameters.AddWithValue("@CreatedBy", Note.CreatedBy);
                command.Parameters.AddWithValue("@EventDate", Note.EventDate);
                command.Parameters.AddWithValue("@CustodialParentID", Note.CustodialParentID ?? "UnknownCP");
                command.Parameters.AddWithValue("@AbsentParentID", Note.AbsentParentID ?? "UnknownAP");
                command.Parameters.AddWithValue("@OrderNo", Note.OrderNo ?? (object)DBNull.Value);
                command.Parameters.AddWithValue("@Contents", Note.SingleLine);
                command.Parameters.AddWithValue("@FilePath", Path.GetDirectoryName(DestFileSpec));
                command.Parameters.AddWithValue("@FileName", Path.GetFileName(DestFileSpec));

                command.ExecuteNonQuery();
            }

        }
        private static void MoveCaseNoteFile(string SourceFileSpec, string DestinationFileSpec)
        {

            File.Move(SourceFileSpec, DestinationFileSpec);
        }

        internal static int Work()
        {
            int exitStatus = 0;
            string destFileSpec;

            foreach (string s in Directory.EnumerateFiles(@"\\ms-hhs-psql2\c$\SqlDB\SIS\Source\Stage\Working\LoadOCSS-Archive\SBPT", "*.txt", SearchOption.TopDirectoryOnly))
            {
                destFileSpec = GetDestinationFileSpec(s);

                foreach (CaseNote c in PIO.GetNextCaseNote(s))
                {

                    WriteCaseNoteRecord(c, destFileSpec);
                    //Logger.InfoFormat(
                    //    "FileSpec: {0}\tCreated By: {6}" + "\n\r" + "Custodial Parent ID: {1}  Absent Parent ID: {2}  Event Date: {3}  Order Number: {4}" + "\n\r" + "Contents:\t {5} \n\r",
                    //    s, c.CustodialParentID, c.AbsentParentID, c.EventDate, c.OrderNo, c.SingleLine, c.CreatedBy);
                }

                MoveCaseNoteFile(s, destFileSpec);
                CaseFileCount++;

            }
            cn.Close();
            return exitStatus;
        }
    }
}
