using System;
using System.Collections.Generic;
using System.Text;
using System.ServiceModel;

using System.Configuration;
using System.Linq;

using ProbeODAPS.sforce;

namespace ProbeODAPS
{
    internal class SF
    {
        #region Class level. Private
        private static SessionHeader Header;
        private static EndpointAddress EndpointAddress;

        private static bool Login(string UserName, string Password, string Token, out SoapClient EndPointClient)
        {
            EndPointClient = null;
            bool returnStatus = false;


            SoapClient loginClient = new SoapClient();

            LoginResult lr;
            try
            {
                lr = loginClient.login(null, null, UserName, Password + Token);
                if (lr.passwordExpired)
                {
                    Program.Logger.Warn("Password has expired");
                    Program.Logger.Debug(string.Format("User Name: {0}  Password: {1}  Token: {2}", UserName, Password, Token));

                    returnStatus = false;
                }
                else
                {
                    EndpointAddress = new EndpointAddress(lr.serverUrl);
                    Header = new SessionHeader { sessionId = lr.sessionId };
                    EndPointClient = new SoapClient("Soap", EndpointAddress);

                    Program.Logger.Info("Logged in.");

                    returnStatus = true;
                }

            }
            catch (Exception e)
            {
                Program.Logger.Error(e.Message);
                Program.Logger.Debug(e.StackTrace);

                returnStatus = false;
            }

            return returnStatus;
        }
        #endregion
        public static bool Login(out SoapClient EndpointClient, string Configuration = "Default")
        {
            string configurationName = "SFConnection_" + Configuration;
            string connectionString =  ConfigurationManager.ConnectionStrings[configurationName].ConnectionString;

            Dictionary<string, string> t =
                connectionString
                .Split(';')
                .Select(pair => pair.Split('='))
                .ToDictionary(valuePair => valuePair[0].Trim(), valuePair => valuePair[1].Trim());

            return Login(t["UserName"], t["Password"], t["Token"], out EndpointClient);
        }
        public static void Logout(SoapClient EndpointClient)
        {
            try
            {
                EndpointClient.logout(Header, null);

                Program.Logger.Info("Logged out.");

            }
            catch (Exception e)
            {
                Program.Logger.Error(e.Message);
                Program.Logger.Debug(e.StackTrace);
            }
        }
        public static IEnumerable<sObject> GetNextSFRecord(string SoqlQuery, SoapClient EndPoint, string SFObjectName)
        {
            bool foundRecords = false;
            QueryResult qr;

            /* I assume that for the last batch of records available, qr.size > 0 and qr.done is true.  [geg] */
            for(EndPoint.query(Header, null, null, null, null, SoqlQuery, out qr); qr.size > 0; EndPoint.queryMore(Header, null, null, qr.queryLocator, out qr))
            {
                if (!foundRecords) // First batch?  
                {
                    foundRecords = true; 
                }

                foreach (sObject item in qr.records)
                {
                    yield return item;
                }

                if (qr.done) break;
            }

            if (!foundRecords)
            {
                Program.Logger.Warn("No records found: " + SFObjectName + ".");
            }
        }
        public static int GetRecordCount(string SFObjectName, SoapClient EndPoint)
        {
            int recordCount;

            try
            {
                string SoqlQuery = "Select Count(Id) From " + SFObjectName;
                EndPoint.query(Header, null, null, null, null, SoqlQuery, out QueryResult qr);
                recordCount = qr.records.Length;
            }
            catch (Exception ex)
            {
                Program.Logger.Error(ex.Message);
                throw;
            }

            return recordCount;
        }
        public static string GetObjectDocumentation(SoapClient EndPoint, string SFObjectName, bool Verbose)
        {
            StringBuilder builder = new StringBuilder();
            string sfObjectDescription = builder.ToString();

            try
            {
                EndPoint.describeSObjects(Header, null, null, null, new string[] { SFObjectName }, out DescribeSObjectResult[] dsrArray);

                DescribeSObjectResult dsr = dsrArray[0];    //dsrArray contains exactly one element, viz. "SFObjectName".  [geg]

                // Get basic object properties.
                builder.Append(dsr.name + ": ");
                builder.Append("\t" + dsr.fields.Length + " fields");
                if (dsr.custom) builder.Append("\tIS_Custom  ");
                builder.Append("\t" + DateTime.Now.ToString("MM/dd/yyyy hh:mm:ss"));

                builder.AppendLine();

                foreach(var field in dsr.fields)
                {
                    // Get basic field properties
                    builder.Append(field.name + "\t: ");
                    builder.Append("\tType: " + field.type);
                    builder.Append(field.length > 0 ? "\tLength :" + field.length : "\t");
                    builder.Append((field.label != null) ? "\tLabel :" + field.label : "\t");
                    if (Verbose)
                    {
                        builder.Append(field.nameField ? "\tIS_NameField" : " ");
                        builder.Append(field.restrictedPicklist ? "\tIS_Restricted_Picklist" : " ");
                        builder.Append(field.custom ? "\tIS_Custom" : " ");
                    }
                    builder.Append(field.nillable ? "\tIS_Nullable" : " ");
                    if(field.type == fieldType.reference)
                    {
                        builder.Append("\t\tReferences : ");
                        foreach(var reference in field.referenceTo)
                        {
                            builder.Append(" " + reference);
                        }
                    }

                    builder.AppendLine();
                }

                sfObjectDescription = builder.ToString();
            }

            catch (Exception ex)
            {
                sfObjectDescription = null;
                Program.Logger.Error(ex.Message);
                Program.Logger.Debug(ex.StackTrace);

                throw;
            }

            return sfObjectDescription;

        }
        public static string GetObjectList(SoapClient EndPoint, bool Verbose)
        {
            StringBuilder builder = new StringBuilder();
            string sfObjectList = builder.ToString();

            try
            {
                // describeGlobal() returns an array of object results that  
                // includes the object names that are available to the logged-in user. 
                var into = EndPoint.describeGlobal(Header, null, null, out DescribeGlobalResult dgr);

                // Loop through the array echoing the object names to the console             
                for (int i = 0; i < dgr.sobjects.Length; i++)
                {
                    builder.AppendLine(dgr.sobjects[i].name);
                }
                sfObjectList = builder.ToString();
            }
            catch (Exception e)
            {
                Program.Logger.Error(e.Message);
                Program.Logger.Debug(e.StackTrace);
            }

            return sfObjectList;

        }
    }

}
