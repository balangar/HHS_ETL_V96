using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.IO;
using System.Data.SqlClient;
using System.Xml.Linq;

namespace Prepare_FinancialNotes
{
    public struct FineRecordInfo
    {
        public int RecordCount { get; set; }
        public string CourtIdentifier { get; set; }
        public string OrderNo { get; set; }
        public string FirstSequenceNumber { get; set; }
        public string FirstDate { get; set; }
        public string LastSequenceNumber { get; set; }
        public string LastDate { get; set; }
        public string Order => CourtIdentifier.Trim() + OrderNo.Trim();
    }

    internal class PIO
    {

        internal static FineRecordInfo GetArchiveInfo(string FinFileSpec)
        {
            string l;

            FineRecordInfo f = new FineRecordInfo();

            f.RecordCount = File.ReadLines(FinFileSpec).Count();

            l = File.ReadLines(FinFileSpec).First();
            f.CourtIdentifier = l.Substring(0, 1).Trim();
            f.OrderNo = l.Substring(1, 15);
            f.FirstSequenceNumber = l.Substring(17, 5);
            f.FirstDate = l.Substring(23, 10);

            l = File.ReadLines(FinFileSpec).Last();
            f.LastSequenceNumber = l.Substring(17, 5);
            f.LastDate = l.Substring(23, 10);


            return f;
        }

        //internal static void PutLogBlock(LogBlock ThisBlock, SqlConnection Conn)
        //{

        //}
    }
}
