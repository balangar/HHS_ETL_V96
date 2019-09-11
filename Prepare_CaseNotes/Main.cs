
using System.IO;
using System;
using System.Reflection;

using System.Data.SqlClient;

using log4net;

namespace Prepare_CaseNotes
{
    internal class Main
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        private static SqlConnection cn = Database.SqlConnection();
        private static void WriteCaseNoteRecord(CaseNote Note, string DestFileSpec)
        {
            using (var command = new SqlCommand(
                    @"INSERT INTO dbo.CaseNotes(CreatedBy, EventDate, CustodialParentID, AbsentParentID, OrderNo, Contents, FilePath, FileName)" + " " +
                    @"VALUES(@CreatedBy, @EventDate, @CustodialParentID, @AbsentParentID, @OrderNo, @Contents, @FilePath, @FileName)",
                    cn))
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
        internal static int Work()
        {
            string sourcePath = @"\\ms-hhs-psql2\c$\SqlDB\SIS\Source\Stage\Working\LoadOCSS-Archive\SBPT";
            string destPath = @"\\ms-hhs-san\ITS\_Archive\OCSS\CaseNotes";

            int exitStatus = 0;

            foreach (string s in Directory.EnumerateFiles(sourcePath, "*.txt", SearchOption.TopDirectoryOnly))
            //string s = @"S:\IS\Databases\Marc\Scrape\SBPT\054441151377444127.txt";
            {
#if DEBUG
                Logger.InfoFormat("Processing : {0}", Path.GetFileName(s));
#endif
                string destFileSpec = Path.Combine(destPath, Path.GetFileName(s));

                foreach (CaseNote c in PIO.GetNextCaseNote(s))
                {

                    WriteCaseNoteRecord(c, destFileSpec);
                    //Logger.InfoFormat(
                    //    "FileSpec: {0}\tCreated By: {6}" + "\n\r" + "Custodial Parent ID: {1}  Absent Parent ID: {2}  Event Date: {3}  Order Number: {4}" + "\n\r" + "Contents:\t {5} \n\r",
                    //    s, c.CustodialParentID, c.AbsentParentID, c.EventDate, c.OrderNo, c.SingleLine, c.CreatedBy);
                }

                File.Copy(s, destFileSpec, true);
#if DEBUG
                Logger.Info("Complete\n\r");
#endif

            }
            cn.Close();
            return exitStatus;
        }
    }
}
