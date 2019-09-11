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
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        private static void WriteCaseNoteRecord(CaseNote Note, string DestFileSpec)
        {
            using(var cn = Database.SqlConnection())
            {
                var command = new SqlCommand(
                    @"INSERT INTO dbo.CaseNotes(CreatedBy, EventDate, CustodialParentID, AbsentParentID, OrderNo, Contents, FilePath, FileName)" + " " +
                    @"VALUES(@CreatedBy, @EventDate, @CustodialParentID, @AbsentParentID, @OrderNo, @Contents, @FilePath, @FileName)",
                    cn);
                command.Parameters.AddWithValue("@CreatedBy", Note.CreatedBy);
                command.Parameters.AddWithValue("@EventDate", Note.EventDate);
                command.Parameters.AddWithValue("@CustodialParentID", Note.CustodialParentID == null ? "UnknownCP" : Note.CustodialParentID);
                command.Parameters.AddWithValue("@AbsentParentID", Note.AbsentParentID == null ? "UnknownAP" : Note.AbsentParentID);
                command.Parameters.AddWithValue("@OrderNo", Note.OrderNo == null ? (object)DBNull.Value : Note.OrderNo);
                command.Parameters.AddWithValue("@Contents", Note.SingleLine);
                command.Parameters.AddWithValue("@FilePath", Path.GetDirectoryName(DestFileSpec));
                command.Parameters.AddWithValue("@FileName", Path.GetFileName(DestFileSpec));

                command.ExecuteNonQuery();
            }

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

            return exitStatus;
        }
    }
}
