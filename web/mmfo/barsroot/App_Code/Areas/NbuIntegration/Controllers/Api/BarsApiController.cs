using System.Web.Http;
using System.Data;
using Oracle.DataAccess.Client;
using System.Web;
using barsroot.core;

namespace BarsWeb.Areas.NbuIntegration.Controllers.Api
{
    public class BarsApiController : ApiController
    {
        protected void LoginADUserIntSingleCon(OracleConnection con, string userName, string mfo = "", bool bcGo = true)
        {
            string ipAddress = RequestHelpers.GetClientIpAddress(HttpContext.Current.Request);

            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.Connection = con;
                cmd.CommandText = "bars.bars_login.login_user";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new OracleParameter("p_session_id", OracleDbType.Varchar2, HttpContext.Current.Session.SessionID, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_login_name", OracleDbType.Varchar2, userName, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_authentication_mode", OracleDbType.Varchar2, "ACTIVE DIRECTORY", ParameterDirection.Input));

                cmd.Parameters.Add(new OracleParameter("p_hostname", OracleDbType.Varchar2, ipAddress, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_appname", OracleDbType.Varchar2, "barsroot", ParameterDirection.Input));
                cmd.ExecuteNonQuery();

                if (bcGo && !string.IsNullOrWhiteSpace(mfo))
                    ExecBcGo(con, mfo);

                WriteMsgToAudit(con, string.Format("SAGO Integration: авторизація. хост {0}, користувач {1} ", ipAddress, userName));
            }
        }

        protected void LoginUserIntSingleCon(OracleConnection con, string userName, string mfo = "", bool bcGo = true)
        {
            UserMap userMap = Bars.Configuration.ConfigurationSettings.GetUserInfo(userName);
            string ipAddress = RequestHelpers.GetClientIpAddress(HttpContext.Current.Request);

            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.Connection = con;
                cmd.CommandText = "bars.bars_login.login_user";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new OracleParameter("p_session_id", OracleDbType.Varchar2, HttpContext.Current.Session.SessionID, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_user_id", OracleDbType.Varchar2, userMap.user_id, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_hostname", OracleDbType.Varchar2, ipAddress, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_appname", OracleDbType.Varchar2, "barsroot", ParameterDirection.Input));
                cmd.ExecuteNonQuery();

                if (bcGo && !string.IsNullOrWhiteSpace(mfo))
                    ExecBcGo(con, mfo);

                WriteMsgToAudit(con, string.Format("SAGO integration: авторизація. хост {0}, користувач {1} ", ipAddress, userName));
            }
        }

        protected void ExecBcGo(OracleConnection con, string branch)
        {
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = "bc.go";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new OracleParameter("p_branch", OracleDbType.Varchar2, branch, ParameterDirection.Input));
                cmd.ExecuteNonQuery();
            }
        }

        protected void WriteMsgToAudit(OracleConnection con, string msg)
        {
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = "bars_audit.info";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new OracleParameter("p_info", OracleDbType.Varchar2, msg, ParameterDirection.Input));
                cmd.ExecuteNonQuery();
            }
        }
    }
}
