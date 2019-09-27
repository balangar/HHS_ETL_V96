using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.IO;

namespace Prepare_FinancialNotes
{
    public class LogEntry
    {
        internal static int ORDER_NUMBER_OFFSET => 0; internal static int ORDER_NUMBER_LENGTH => 16;
        internal static int BLOCK_DATE_OFFSET => 23; internal static int BLOCK_DATE_LENGTH => 10;
        internal static int LOG_BODY_OFFSET => 34;  // No "Length" specified since the length is variable ... in particular, "Comment" lines are variable length.

    }
    public class LogBlock
    {
        internal string OrderNo { get; set; }
        internal string BlockDate { get; set; }
        internal List<string> Entries { get; set; }

        public LogBlock()
        {
            OrderNo = string.Empty;
            BlockDate = string.Empty;
            Entries = new List<string>();
        }
        public LogBlock(string LogRecord)
        {
            OrderNo = LogRecord.Substring(LogEntry.ORDER_NUMBER_OFFSET, LogEntry.ORDER_NUMBER_LENGTH);
            BlockDate = LogRecord.Substring(LogEntry.BLOCK_DATE_OFFSET, LogEntry.BLOCK_DATE_LENGTH);
            Entries = new List<string>();
        }
        public LogBlock(string OrderNumber, string NewBlockDate, List<string>NewBlockEntries)
        {
            OrderNo = OrderNumber;
            BlockDate = NewBlockDate;
            Entries = NewBlockEntries;
        }
    }
    class PIO
    {
        public static IEnumerable<LogBlock> GetNextLogBlock(string SourceFileSpec)
        {
            string currentBlockDate = string.Empty;
            LogBlock block = null;

            var lines = File.ReadAllLines(SourceFileSpec);  //NB:  All of the lines in a given OFIN file will have the same Order Number. [geg]
            foreach (string l in lines)
            {
                if (l.Substring(LogEntry.BLOCK_DATE_OFFSET, LogEntry.BLOCK_DATE_LENGTH).Trim() != currentBlockDate)    // Start of new LogBlock
                {
                    if (block != null)
                    {
                        yield return block;
                    }

                    block = new LogBlock(
                        l.Substring(LogEntry.ORDER_NUMBER_OFFSET, LogEntry.ORDER_NUMBER_LENGTH),
                        l.Substring(LogEntry.BLOCK_DATE_OFFSET, LogEntry.BLOCK_DATE_LENGTH),
                        new List<string>()
                        );

                    currentBlockDate = block.BlockDate;
                }
                block.Entries.Add(l.Substring(LogEntry.LOG_BODY_OFFSET));
            }

            if (block != null)
            {
                yield return block;    //Return the last note
            }
            yield break;
        }
    }
}
