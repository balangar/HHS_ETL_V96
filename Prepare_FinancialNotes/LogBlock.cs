using System.Collections.Generic;
using System.IO;

namespace Prepare_FinancialNotes
{
    internal class LogRecord
    {
        internal static int ORDER_NUMBER_OFFSET => 0; internal static int ORDER_NUMBER_LENGTH => 16;
        internal static int SEQUENCE_NUMBER_OFFSET => 17; internal static int SEQUENCE_NUMBER_LENGTH => 5;
        internal static int BLOCK_DATE_OFFSET => 23; internal static int BLOCK_DATE_LENGTH => 10;
        internal static int RECORD_TYPE_OFFSET => 34; internal static int RECORD_TYPE_LENGTH => 7;
        internal static int RECORD_SUBTYPE_OFFSET => 42; internal static int RECORD_SUBTYPE_LENGTH => 2;
        internal static int LOG_BODY_OFFSET => 44;  // No "Length" specified since the length is variable ... in particular, "Comment" lines are variable length.

        internal string OrderNo { get; }
        internal string SequenceNo { get; }
        internal string BlockDate { get; }
        internal string RecordType { get; }
        internal string RecordSubtype { get; }
        internal string Entry { get; }

        internal LogRecord(string EntryLine)
        {
            OrderNo = EntryLine.Substring(ORDER_NUMBER_OFFSET, ORDER_NUMBER_LENGTH);
            SequenceNo = EntryLine.Substring(SEQUENCE_NUMBER_OFFSET, SEQUENCE_NUMBER_LENGTH);
            BlockDate = EntryLine.Substring(BLOCK_DATE_OFFSET, BLOCK_DATE_LENGTH);
            RecordType = EntryLine.Substring(RECORD_TYPE_OFFSET, RECORD_TYPE_LENGTH);
            RecordSubtype = EntryLine.Substring(RECORD_SUBTYPE_OFFSET, RECORD_SUBTYPE_LENGTH) == "00" ? "Master" : "Detail";
            Entry = EntryLine.Substring(LOG_BODY_OFFSET);

        }
    }

    internal class LogBlock
    {
        internal string OrderNo { get; set; }
        internal string BlockDate { get; set; }
        internal List<LogRecord> LogRecords { get; set; }

        internal LogBlock(string OrderNumber, string NewBlockDate, List<LogRecord> NewLogRecords)
        {
            OrderNo = OrderNumber;
            BlockDate = NewBlockDate;
            LogRecords = NewLogRecords;
        }
        internal static IEnumerable<LogBlock> GetNextLogBlock(string SourceFileSpec)
        {
            string currentBlockDate = string.Empty;
            LogBlock block = null;
            LogRecord currentLogRecord = null;

            var lines = File.ReadAllLines(SourceFileSpec);  //NB:  All of the lines in a given OFIN file will have the same Order Number. [geg]
            foreach (string l in lines)
            {
                currentLogRecord = new LogRecord(l);
                if (currentLogRecord.BlockDate.Trim() != currentBlockDate)    // Start of new LogBlock
                {
                    if (block != null)
                    {
                        yield return block;
                    }
                    block = new LogBlock(currentLogRecord.OrderNo, currentLogRecord.BlockDate, new List<LogRecord>());
                    currentBlockDate = block.BlockDate;
                }
                block.LogRecords.Add(currentLogRecord);
            }

            if (block != null)
            {
                yield return block;    //Return the last note
            }
            yield break;
        }

    }
}
