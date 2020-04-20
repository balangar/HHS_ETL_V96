using System.IO;
using System;
using System.Reflection;

using System.Data.SqlClient;

using log4net;
using System.Collections.Generic;
using System.Linq;

namespace Prepare_WIPS
{
    internal class Main
    {
        private static int FileCount { get; set; }

        private static readonly SqlConnection cn = Database.SqlConnection();

        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        internal static int Work()
        {
            const string sourcePath = @"\\ms-hhs-psql2\c$\SqlDB\SIS\Source\Stage\Working\LoadOCSS-Archive\OFIN";

            int exitStatus = 0;

            foreach (string s in Directory.EnumerateFiles(sourcePath, "*.txt", SearchOption.TopDirectoryOnly))
            {


                //string destFileSpec = GetDestinationFileSpec(s);
                //WriteFinancialNoteRecord(PIO.GetArchiveInfo(s), destFileSpec);
                //CopyFinancialNoteFile(s, destFileSpec);

                //Logger.InfoFormat(@"{0}", s);
                if (FileCount++ > 1001) break;

            }
            cn.Close();
            return exitStatus;
        }
    }
}
