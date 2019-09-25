using System.IO;
using System;
using System.Reflection;

using System.Data.SqlClient;

using log4net;

namespace Prepare_FinancialNotes
{

    internal class Main
    {
        private const int ENTRY_TYPE_OFFSET = 34;
        private const int ENTRY_TYPE_LENGTH = 7;

        private static int FileCount { get; set; }

        private static readonly SqlConnection cn = Database.SqlConnection();

        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        private static string GetDestinationFileSpec(string SourceFileSpec)
        {
            const int NEW_SUBDIRECTORY_COUNT = 1000;
            const string DESTINATION_ROOT = @"\\ms-hhs-san\ITS\_Archive\OCSS\FinancialNotes";

            int destSubFolder = (FileCount / NEW_SUBDIRECTORY_COUNT) * NEW_SUBDIRECTORY_COUNT;
            string destFilePath = string.Format(@"{0}\{1}", DESTINATION_ROOT, destSubFolder.ToString().PadLeft(6, '0'));


            if (FileCount % NEW_SUBDIRECTORY_COUNT == 0)
            {
                Directory.CreateDirectory(destFilePath);

                Logger.InfoFormat("Financial File Count: {0}  Destination File Path: {1}", FileCount.ToString(), destFilePath);
            }

            return Path.Combine(destFilePath, Path.GetFileName(SourceFileSpec));

        }
        private static void CopyFinancialNoteFile(string SourceFileSpec, string DestinationFileSpec) => File.Copy(SourceFileSpec, DestinationFileSpec, true);


        internal static int Work()
        {
            int exitStatus = 0;

            foreach (string s in Directory.EnumerateFiles(@"\\ms-hhs-psql2\c$\SqlDB\SIS\Source\Stage\Working\LoadOCSS-Archive\OFIN", "*.txt", SearchOption.TopDirectoryOnly))
            {
                string destFileSpec = GetDestinationFileSpec(s);
                string[] lines = File.ReadAllLines(s);

                foreach (string l in lines)
                {
                    string t = l.Substring(ENTRY_TYPE_OFFSET, ENTRY_TYPE_LENGTH).ToUpper();
                    switch (t)
                    {
                        case "RECEIPT":
                            break;

                        case "MANUAL ":
                            break;

                        case "APPLIED":
                            break;

                        case "DISBURS":
                            break;

                        case "DISTRIB":
                            break;

                        case "DELETED":
                            break;

                        case "ADJ-BKO":
                            break;

                        case "ADJ-CAN":
                            break;

                        case "ADJAPP ":
                            break;

                        case "ADJMAPP":
                            break;

                        case "ADJMAP ":
                            break;

                        case "ADJMNSF":
                            break;

                        case "ADJNAF ":
                            break;

                        case "ADJ-NSF":
                            break;

                        case "ADJ-RIS":
                            break;

                        case "ADJ-RSP":
                            break;

                        case "ADJ-RTN":
                            break;

                        case "ADJ-STP":
                            break;

                        case "BKO-APP":
                            break;

                        case "HELD RC":
                            break;

                        case "RCT-BND":
                            break;

                        case "RCT-RPL":
                            break;

                        case "RCT-RTN":
                            break;

                        case "RCT-URB":
                            break;

                        case "RETURN ":
                            break;

                        case "TRANSFE":
                            break;

                        case "COMMENT":
                            break;

                        case "       ":      //A comment.
                            break;


                        default:
                            throw new InvalidDataException(string.Format("{0} contains unknown log-entry type {1}", s, t));
                    }

                }

                //CopyFinancialNoteFile(s, destFileSpec);
                //Logger.InfoFormat(@"{0}", s);
                FileCount++;

            }
            cn.Close();
            return exitStatus;
        }
    }
}