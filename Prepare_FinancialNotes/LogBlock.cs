using System.Collections.Generic;
using System.IO;

namespace Prepare_FinancialNotes
{
    internal class LogBlock
    {
        internal string OrderNo { get; set; }
        internal string BlockDate { get; set; }
        internal List<string> Entries { get; set; }

        internal LogBlock(string OrderNumber, string NewBlockDate, List<string> NewBlockEntries)
        {
            OrderNo = OrderNumber;
            BlockDate = NewBlockDate;
            Entries = NewBlockEntries;
        }
        internal static IEnumerable<LogBlock> GetNextLogBlock(string SourceFileSpec)
        {
            string currentBlockDate = string.Empty;
            LogBlock block = null;
            LogEntry currentEntry = null;

            var lines = File.ReadAllLines(SourceFileSpec);  //NB:  All of the lines in a given OFIN file will have the same Order Number. [geg]
            foreach (string l in lines)
            {
                if (l.Substring(LogEntry.BLOCK_DATE_OFFSET, LogEntry.BLOCK_DATE_LENGTH).Trim() != currentBlockDate)    // Start of new LogBlock
                {
                    if (block != null)
                    {
                        yield return block;
                    }
                    currentEntry = new LogEntry(l);

                    block = new LogBlock(currentEntry.OrderNo, currentEntry.BlockDate, new List<string>());
                    currentBlockDate = block.BlockDate;
                }
                block.Entries.Add(currentEntry.Entry);
            }

            if (block != null)
            {
                yield return block;    //Return the last note
            }
            yield break;
        }

    }
}
