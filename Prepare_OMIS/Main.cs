using System.IO;
using System;
using System.Reflection;

using System.Data.SqlClient;

using log4net;


/*
 * There are lots of stumbling blocks for the unwary in this file and among them are:
 *      o The File has three (3) distinct record types
 *      o When there are multiple type 03 records (see "cpy") for a given case number grouping, all are duplicates of the first.  Example: A000685902.
 *      o Some case numbers have multiple groups of associated records ... and they don't always differ in the type 01 recorf.  Examples:  D025484703 and A000835801
 */

namespace Prepare_OMIS
{
    internal class Main
    {
        internal static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        internal static int Work()
        {
            const string sourceFileSpec = @"\\ms-hhs-psql2\c$\SqlDB\SIS\Source\Stage\Working\LoadOCSS-Archive\_ORDR\DATAOMIS_CleansedAndDelimited.csv";

            PIO.Open(sourceFileSpec);

            foreach (var r in PIO.GetNextRecord())
            {
                PIO.PutRecord(r);
            }

            PIO.Close();

            return 1;
        }
    }
}
