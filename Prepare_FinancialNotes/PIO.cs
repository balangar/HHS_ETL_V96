using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.IO;
using System.Data.SqlClient;
using System.Xml.Linq;



namespace Prepare_FinancialNotes
{
    internal class PIO
    {
        internal static XmlOutput GetRoot(string OrderNumber, string BlockDate)
        {

            //var dict = new Dictionary<string, Func<string, LogEntry>>();
            //dict.Add("RECIPT", s => new ReciptLogEntry(s));
            //var entry = dict["RECPT"]("ABC");
 

            return new XmlOutput()
            .XmlDeclaration()
            .Node("FinRecord").Within()
            .Attribute("OrderNumber", OrderNumber)
            .Attribute("Date", BlockDate);

        }

        internal static string GetXMLColumn(LogBlock Block)
        {
            XmlOutput xOut;

            //Root
            xOut = new XmlOutput()      
                .XmlDeclaration()
                .Node("FinRecord").Within()
                .Attribute("OrderNumber", Block.OrderNo)
                .Attribute("Date", Block.BlockDate);


            foreach (LogRecord r in Block.LogRecords)
            {

            }


            return xOut.GetOuterXml();
        }
        internal static void PutLogBlock(LogBlock ThisBlock, SqlConnection Conn)
        {
            string xColumn;

            xColumn = GetXMLColumn(ThisBlock);

        }
    }
}
