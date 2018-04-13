<%@ WebHandler Language="C#" Class="StreetsOfKiev" %>

using System.Web;
using System.Web.SessionState;
using Oracle.DataAccess.Client;

public class StreetsOfKiev : IHttpHandler, IRequiresSessionState
{
    public void ProcessRequest(HttpContext context)
    {
        string dataType = context.Request["dataType"];
        context.Response.Write(GetStreetJsonData(dataType));
        context.Response.End();
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

    private string GetStreetJsonData(string typeData)
    {
        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmdSql = con.CreateCommand();
        string result = "";
        OracleDataReader rdr;
        try
        {
            switch (typeData)
            {
                case "streets":
                    cmdSql.CommandText = "select CITY_AREA_ID,  STREET_TYPE_ID,  STREET_NAME from CM_CITY_STREET";
                    rdr = cmdSql.ExecuteReader();
                    result = ReturnJSON(rdr);
                    break;
                case "strTypes":
                    cmdSql.CommandText = "select ID, NAME, VALUE  from ADDRESS_STREET_TYPE";
                    rdr = cmdSql.ExecuteReader();
                    result = ReturnJSON(rdr);
                    break;
                case "areas":
                    cmdSql.CommandText = "select ID, NAME  from CM_CITY_AREA";
                    rdr = cmdSql.ExecuteReader();
                    result = ReturnJSON(rdr);
                    break;
                default:
                    result = "";
                    break;
            }
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
        return result;
    }


    private string ReturnJSON(OracleDataReader reader)
    {

        string result = "[";
        int columnCount = reader.FieldCount;
        while (reader.Read())
        {
            result += "{";
            for (int x = 0; x < columnCount; x++)
            {
                result += "\"" + reader.GetName(x) + "\":\"";
                string stringValue = "";
                if (!reader.IsDBNull(x))
                {
                    stringValue = reader.GetValue(x).ToString();
                }
                else
                {
                    stringValue = "NULL";
                }
                result += stringValue + "\"";
                if (x < columnCount - 1) result += ",";
            }
            result += "},";
        }
        result = result.TrimEnd(result[result.Length - 1]) + "]";
        return result;
    }

}