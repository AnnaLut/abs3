using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.RequestsProcessing.Infrastructure.DI.Implementation
{
    /// <summary>
    /// Summary description for DynamicCreator
    /// </summary>
    public class DynamicCreator
    {
        public static List<Dictionary<string, object>> GetObject(string sqlStr)
        {
            List<Dictionary<string, object>> data = new List<Dictionary<string, object>>();

            Oracle.DataAccess.Client.OracleConnection connection = Bars.Classes.OraConnector.Handler.UserConnection;
            Oracle.DataAccess.Client.OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = sqlStr;
                Oracle.DataAccess.Client.OracleDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    Dictionary<string, object> row = new Dictionary<string, object>();
                    for (int i = 0; i < reader.FieldCount; i++)
                    {
                        string key = reader.GetName(i);
                        var value = reader[i];
                        row[key] = value;
                    }
                    data.Add(row);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }

            return data;
        }
    }
}
