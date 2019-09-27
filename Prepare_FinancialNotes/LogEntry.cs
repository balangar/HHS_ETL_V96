using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Prepare_FinancialNotes
{
    internal class LogEntry
    {
        internal static int ORDER_NUMBER_OFFSET => 0; internal static int ORDER_NUMBER_LENGTH => 16;
        internal static int BLOCK_DATE_OFFSET => 23; internal static int BLOCK_DATE_LENGTH => 10;
        internal static int LOG_BODY_OFFSET => 34;  // No "Length" specified since the length is variable ... in particular, "Comment" lines are variable length.

        internal string OrderNo { get; set; }
        internal string BlockDate { get; set; }
        internal string Entry { get; set; }

        internal LogEntry(string EntryLine)
        {
            OrderNo = EntryLine.Substring(ORDER_NUMBER_OFFSET, ORDER_NUMBER_LENGTH);
            BlockDate = EntryLine.Substring(BLOCK_DATE_OFFSET, BLOCK_DATE_LENGTH);
            Entry = EntryLine.Substring(LOG_BODY_OFFSET);

        }
    }
}
