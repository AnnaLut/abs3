using System.Web.Script.Services;
using System.Web.Services;
using Oracle.DataAccess.Client;
using System.Data;
using Bars.Classes;

[ScriptService]
public class CryptoService : System.Web.Services.WebService
{
    public CryptoService()
    {
    }

    [WebMethod(EnableSession = true)]
    public string TraceUserSign(string keyId, string bcVersion, string userAddress, string browserInfo, int checkStatus, string checkError)
    {
        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        try
        {
            OracleCommand cmd = con.CreateCommand();

            cmd.Parameters.Add("p_key_id", OracleDbType.Varchar2, keyId, ParameterDirection.Input);
            cmd.Parameters.Add("p_bc_version", OracleDbType.Varchar2, bcVersion, ParameterDirection.Input);
            cmd.Parameters.Add("p_user_address", OracleDbType.Varchar2, userAddress, ParameterDirection.Input);
            cmd.Parameters.Add("p_browser_info", OracleDbType.Varchar2, browserInfo, ParameterDirection.Input);
            cmd.Parameters.Add("p_check_status", OracleDbType.Decimal, checkStatus, ParameterDirection.Input);
            cmd.Parameters.Add("p_check_error", OracleDbType.Varchar2, checkError, ParameterDirection.Input);

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "sgn_mgr.trace_user";
            cmd.ExecuteNonQuery();
        }
        finally
        {
            con.Close();
            con.Dispose();
        }

        return keyId;
    }

}
