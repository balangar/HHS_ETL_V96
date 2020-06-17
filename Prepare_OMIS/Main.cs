using System.IO;
using System;
using System.Reflection;

using System.Data.SqlClient;

using log4net;


namespace Prepare_OMIS
{
    internal class Main
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        internal static int Work()
        {
            const string sourceFileSpec = @"\\ms-hhs-psql2\c$\SqlDB\SIS\Source\Stage\Working\LoadOCSS-Archive\_ORDR\DATAOMIS_CleansedAndDelimited.csv";

            PIO.Open(sourceFileSpec);

            PIO.GetNextRecord();

            PIO.Close();

            return 1;
        }
    }
}
