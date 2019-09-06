using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.IO;

namespace Prepare_CaseNotes
{
    public class CaseNote
    {
        internal static int CUSTODIAL_PARENT_ID_OFFSET => 0; internal static int CUSTODIAL_PARENT_ID_LENGTH => 9;
        internal static int ABSENT_PARENT_ID_OFFSET => 9; internal static int ABSENT_PARENT_ID_LENGTH => 9;
        internal static int EVENT_DATE_OFFSET => 25; internal static int EVENT_DATE_LENGTH => 10;
        internal static int NEW_NOTE_MARKER_OFFSET => 36; internal static int NEW_NOTE_MARKER_LENGTH => 3;
        internal static int ORDER_NUMBER_OFFSET => 71; internal static int ORDER_NUMBER_LENGTH => 19;
        internal static int NOTE_OFFSET => 39;

        public string CustodialParentID { get; set; }
        public string AbsentParentID { get; set; }
        public string EventDate { get; set; }
        public string OrderNo { get; set; }
        internal List<string> Lines = new List<string>(); // Used to consume lines of actual case note
        public string SingleLine { get; set; }
    }
}

namespace Prepare_CaseNotes
{
    class PIO
    {
        public static IEnumerable<CaseNote> GetNextCaseNote(string SourceFileSpec)
        {
            CaseNote note = null;
            var lines = File.ReadAllLines(SourceFileSpec);
            foreach(string l in lines)
            {
                if (l.Substring(CaseNote.NEW_NOTE_MARKER_OFFSET, CaseNote.NEW_NOTE_MARKER_LENGTH).Trim() == string.Empty)    // Start of new Case Note.
                {
                    if (note != null)
                    {
                        note.SingleLine = string.Join(" ", note.Lines);
                        yield return note;
                    }

                    note = new CaseNote
                    {
                        CustodialParentID = l.Substring(CaseNote.CUSTODIAL_PARENT_ID_OFFSET, CaseNote.CUSTODIAL_PARENT_ID_LENGTH),
                        AbsentParentID = l.Substring(CaseNote.ABSENT_PARENT_ID_OFFSET, CaseNote.ABSENT_PARENT_ID_LENGTH),
                        EventDate = l.Substring(CaseNote.EVENT_DATE_OFFSET, CaseNote.EVENT_DATE_LENGTH),
                        OrderNo = l.Substring(CaseNote.ORDER_NUMBER_OFFSET, CaseNote.ORDER_NUMBER_LENGTH).Trim() != string.Empty ? l.Substring(CaseNote.ORDER_NUMBER_OFFSET, CaseNote.ORDER_NUMBER_LENGTH) : string.Empty
                    };
                }
                else
                {
                    note.Lines.Add(l.Substring(39));
                }
            }
            if (note != null)
            {
                note.SingleLine = string.Join(string.Empty, note.Lines);
                yield return note;    //Return the last note
            }
            yield break;
        }
    }
}
