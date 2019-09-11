using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.IO;

namespace Prepare_CaseNotes
{
    public class CaseNote
    {
        internal static int NEW_NOTE_MARKER_OFFSET => 36; internal static int NEW_NOTE_MARKER_LENGTH => 3;
        internal static int CREATED_BY_OFFSET => 36; internal static int CREATED_BY_LENGTH = 20;
        internal static int CUSTODIAL_PARENT_ID_OFFSET => 0; internal static int CUSTODIAL_PARENT_ID_LENGTH => 9;
        internal static int ABSENT_PARENT_ID_OFFSET => 9; internal static int ABSENT_PARENT_ID_LENGTH => 9;
        internal static int EVENT_DATE_OFFSET => 25; internal static int EVENT_DATE_LENGTH => 10;
        internal static int ORDER_NUMBER_OFFSET => 70; internal static int ORDER_NUMBER_LENGTH => 19;
        internal static int NOTE_OFFSET => 39;

        public string CreatedBy { get; set; }
        public string CustodialParentID { get; set; }
        public string AbsentParentID { get; set; }
        public string EventDate { get; set; }
        public string OrderNo { get; set; }
        internal List<string> Lines = new List<string>(); // Used to consume lines of actual case note
        public string SingleLine { get; set; }

        public CaseNote()
        {

        }
        public CaseNote(string NewCaseNoteHeader)
        {
            CreatedBy = NewCaseNoteHeader.Substring(CREATED_BY_OFFSET, CREATED_BY_LENGTH).Trim();
            CustodialParentID = NewCaseNoteHeader.Substring(CUSTODIAL_PARENT_ID_OFFSET, CUSTODIAL_PARENT_ID_LENGTH);
            AbsentParentID = NewCaseNoteHeader.Substring(ABSENT_PARENT_ID_OFFSET, ABSENT_PARENT_ID_LENGTH);
            EventDate = NewCaseNoteHeader.Substring(EVENT_DATE_OFFSET, EVENT_DATE_LENGTH);
            OrderNo = NewCaseNoteHeader.Substring(ORDER_NUMBER_OFFSET, ORDER_NUMBER_LENGTH).Trim() != string.Empty ? NewCaseNoteHeader.Substring(ORDER_NUMBER_OFFSET, ORDER_NUMBER_LENGTH) : null;
        }
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
                if (l.Substring(CaseNote.NEW_NOTE_MARKER_OFFSET, CaseNote.NEW_NOTE_MARKER_LENGTH).Trim() != string.Empty)    // Start of new Case Note.
                {
                    if (note != null)
                    {
                        note.SingleLine = string.Join(" ", note.Lines);
                        yield return note;
                    }

                    note = new CaseNote(l);
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
