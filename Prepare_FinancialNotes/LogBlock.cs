using System.Collections.Generic;
using System.IO;

namespace Prepare_FinancialNotes
{
    internal class LogRecord
    {
        //TODO: Log body offset may need to be adjusted.
        internal static int ORDER_NUMBER_OFFSET => 0; internal static int ORDER_NUMBER_LENGTH => 17;
        internal static int SEQUENCE_NUMBER_OFFSET => 17; internal static int SEQUENCE_NUMBER_LENGTH => 5;
        internal static int RECORD_DATE_OFFSET => 23; internal static int RECORD_DATE_LENGTH => 10;

        internal string OrderNo { get; }
        internal string SequenceNo { get; }
        internal string RecordDate { get; }
        internal LogRecord(string EntryLine)
        {
            OrderNo = EntryLine.Substring(ORDER_NUMBER_OFFSET, ORDER_NUMBER_LENGTH);
            SequenceNo = EntryLine.Substring(SEQUENCE_NUMBER_OFFSET, SEQUENCE_NUMBER_LENGTH);
            RecordDate = EntryLine.Substring(RECORD_DATE_OFFSET, RECORD_DATE_LENGTH);

        }
    }

    internal class LogBlock
    {
        internal string OrderNo { get; set; }
        internal string BlockDate { get; set; }
        internal List<LogRecord> LogRecords { get; set; }
        internal List<BaseLogEntry> LogEntries { get; set; }

        internal LogBlock(string OrderNumber, string NewBlockDate)
        {
            OrderNo = OrderNumber;
            BlockDate = NewBlockDate;
            LogRecords = new List<LogRecord>();
            LogEntries = new List<BaseLogEntry>();
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
                if (currentLogRecord.RecordDate.Trim() != currentBlockDate)    // Start of new LogBlock
                {
                    if (block != null)
                    {
                        yield return block;
                    }
                    block = new LogBlock(currentLogRecord.OrderNo, currentLogRecord.RecordDate);
                    block.LogEntries.Add(BaseLogEntry.CreateEntry(new LogRecord(currentLogRecord.OrderNo + "|00001|" + currentLogRecord.RecordDate + "|FinRecord|00")));   // Insert Block Header Log Entry
                    currentBlockDate = block.BlockDate;
                }
                block.LogRecords.Add(currentLogRecord);
                block.LogEntries.Add(BaseLogEntry.CreateEntry(currentLogRecord));
            }

            if (block != null)
            {
                yield return block;    //Return the last note
            }
            yield break;
        }

    }
}
