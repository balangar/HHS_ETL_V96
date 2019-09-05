using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.IO;

namespace Prepare_CaseNotes
{
    public class CaseNote
    {
        public string CustodialParentID;
        public string AbsentParentID;
        public string EventDate;
        public List<string> Contents = new List<string>();
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
                if (l.Substring(36, 6).Equals("SYSTEM", StringComparison.Ordinal))    // Start of new Case Note.  NB: Case-sensitive comparison
                {
                    if (note != null) yield return note;
                    note = new CaseNote
                    {
                        CustodialParentID = l.Substring(0, 9),
                        AbsentParentID = l.Substring(9, 9),
                        EventDate = l.Substring(25, 10)
                    };
                }
                else
                {
                    note.Contents.Add(l.Substring(39));
                }
            }
            if (note != null) yield return note;    //Return the last note
            yield break;
        }
    }
}
