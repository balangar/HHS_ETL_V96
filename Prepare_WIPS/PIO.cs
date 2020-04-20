using System.Linq;

using System.IO;
using System;

namespace Prepare_WIPS
{
    public struct WIPSRecordInfo
    {
        public string SocSecNo { get; set; }
        public string LastName { get; set; }
        public string FirstName { get; set; }
    }

    internal class PIO
    {

        internal static WIPSRecordInfo GetArchiveInfo(string WipsFileSpec)
        {
            string l;

            WIPSRecordInfo f = new WIPSRecordInfo();

            l = File.ReadLines(WipsFileSpec).First();
            f.SocSecNo = l.Substring(0, 9);
            f.LastName = l.Substring(19, 19).Trim();
            f.FirstName = l.Substring(42, 16).Trim();

            return f;
        }
    }
}
