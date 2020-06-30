using System.Configuration;
using System.Data.SqlClient;

namespace Prepare_OMIS
{
    public class Database
    {
        public enum RuntimeOptions { Default, Production, Training, Test, Development, Invalid }

        public static SqlConnection SqlConnection(string Configuration)
        {
            string connectionString = ConfigurationManager.ConnectionStrings[Configuration].ConnectionString;
            SqlConnection connection = new SqlConnection(connectionString);
            connection.Open();
            return connection;
        }
        public static SqlConnection SqlConnection()
        {
            return SqlConnection("AppConnection_" + RuntimeOptions.Default.ToString());
        }

    }
}
