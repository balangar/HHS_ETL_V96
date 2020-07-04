using System.IO;
using System.Reflection;

using System.Data.SqlClient;

using log4net;

namespace Prepare_WIPS
{
    internal class Main
    {
        private static int FileCount { get; set; }

        private static readonly SqlConnection cn = Database.SqlConnection();

        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        private static string GetDestinationFileSpec(string SourceFileSpec)
        {
            const int NEW_SUBDIRECTORY_COUNT = 1000;
            const string DESTINATION_ROOT = @"\\ms-hhs-san\ITS\_Archive\OCSS\WIPS";

            int destSubFolder = (FileCount / NEW_SUBDIRECTORY_COUNT) * NEW_SUBDIRECTORY_COUNT;
            string destFilePath = string.Format(@"{0}\{1}", DESTINATION_ROOT, destSubFolder.ToString().PadLeft(6, '0'));


            if (FileCount % NEW_SUBDIRECTORY_COUNT == 0)
            {
                Directory.CreateDirectory(destFilePath);

                Logger.InfoFormat("WIPS File Count: {0}  Destination File Path: {1}", FileCount.ToString(), destFilePath);
            }

            return Path.Combine(destFilePath, Path.GetFileName(SourceFileSpec));

        }
        private static void CopyFile(string SourceFileSpec, string DestinationFileSpec) => File.Copy(SourceFileSpec, DestinationFileSpec, true);
        private static void MoveFile(string SourceFileSpec, string DestinationFileSpec) => File.Move(SourceFileSpec, DestinationFileSpec);


        private static void WriteWIPRecord(WIPSRecordInfo WipsInfo, string DestFileSpec)
        {
            const string cmdText = @"INSERT INTO dbo.WIPS(IndividualID, FirstName, LastName, FilePath, FileName)" + " " +
                                   @"VALUES(@IndividualID, @FirstName, @LastName, @FilePath, @FileName)";
            using (var command = new SqlCommand(cmdText, cn))
            {
                command.Parameters.AddWithValue("@IndividualID", WipsInfo.SocSecNo);
                command.Parameters.AddWithValue("@FirstName", WipsInfo.FirstName);
                command.Parameters.AddWithValue("@LastName", WipsInfo.LastName);

                command.Parameters.AddWithValue("@FilePath", Path.GetDirectoryName(DestFileSpec));
                command.Parameters.AddWithValue("@FileName", Path.GetFileName(DestFileSpec));

                command.ExecuteNonQuery();
            }

        }
        internal static int Work()
        {
            const string sourcePath = @"\\ms-hhs-psql2\c$\SqlDB\SIS\Source\Stage\Working\LoadOCSS-Archive\WIPS";

            int exitStatus = 0;
            FileCount = 0;

            foreach (string s in Directory.EnumerateFiles(sourcePath, "*.txt", SearchOption.TopDirectoryOnly))
            {


                string destFileSpec = GetDestinationFileSpec(s);
                //Logger.InfoFormat(@"{0}", s);

                WriteWIPRecord(PIO.GetArchiveInfo(s), destFileSpec);
                MoveFile(s, destFileSpec);

                //if (FileCount++ > 1001) break;
                FileCount++;
            }
            cn.Close();
            return exitStatus;
        }
    }
}
