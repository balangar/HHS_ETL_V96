using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.IO;

namespace Prepare_FinancialNotes
{
    public class FinancialNote
    {
        internal static int NEW_NOTE_MARKER_OFFSET => 36; internal static int NEW_NOTE_MARKER_LENGTH => 3;


        internal List<string> Lines = new List<string>(); // Used to consume lines of actual case note
        public string SingleLine { get; set; }


        public FinancialNote()
        {

        }
        public FinancialNote(string NewFinancialNoteHeader)
        {

        }
    }

    class PIO
    {
        public static IEnumerable<FinancialNote> GetNextFinancialNote(string SourceFileSpec)
        {
            FinancialNote note = null;
            var lines = File.ReadAllLines(SourceFileSpec);
            foreach (string l in lines)
            {
                if (l.Substring(FinancialNote.NEW_NOTE_MARKER_OFFSET, FinancialNote.NEW_NOTE_MARKER_LENGTH).Trim() != string.Empty)    // Start of new Financial Note.
                {
                    if (note != null)
                    {
                        note.SingleLine = string.Join(" ", note.Lines);
                        yield return note;
                    }

                    note = new FinancialNote(l);
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
