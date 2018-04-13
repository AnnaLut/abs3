using System;
using System.Xml;
using System.Globalization;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using Bars;
using Bars.Classes;
using Bars.WebServices;
using FastReport.Utils;
using Oracle.DataAccess.Client;
using System.Data;
using barsroot.core;
using Bars.Application;
using XmlDocument = System.Xml.XmlDocument;

namespace barsroot.cim
{
    /// <summary>
    /// Веб-сервіс для модуля валютного контролю
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class SyncService : BarsWebService
    {
        public class Response<T>
        {
            public int Status { get; set; }
            public string ErrorMessage { get; set; }
            public XmlDocument Data { get; set; }
            public int RowsCount { get; set; }
        }
        public WsHeader WsHeaderValue;

        #region private методы
        private void LoginUser(String userName)
        {
            // Інформація про поточного користувача
            UserMap userMap = Bars.Configuration.ConfigurationSettings.GetUserInfo(userName);

            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            using (con)
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "bars.bars_login.login_user";

                cmd.Parameters.Add("p_session_id", OracleDbType.Varchar2, Session.SessionID, ParameterDirection.Input);
                cmd.Parameters.Add("p_user_id", OracleDbType.Varchar2, userMap.user_id, ParameterDirection.Input);
                cmd.Parameters.Add("p_hostname", OracleDbType.Varchar2, GetHostName(), ParameterDirection.Input);
                cmd.Parameters.Add("p_appname", OracleDbType.Varchar2, "barsroot", ParameterDirection.Input);

                cmd.ExecuteNonQuery();
            }
            Session["UserLoggedIn"] = true;
        }

        private string GetHostName()
        {
            string userHost = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

            if (String.IsNullOrEmpty(userHost) || String.Compare(userHost, "unknown", true) == 0)
                userHost = HttpContext.Current.Request.UserHostAddress;

            if (String.Compare(userHost, HttpContext.Current.Request.UserHostName) != 0)
                userHost += " (" + HttpContext.Current.Request.UserHostName + ")";

            return userHost;
        }
      
        #endregion

        [WebMethod(EnableSession = true)]
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
        public Response<string> SyncTable(string table_name, string start_date)
        {
            String barsUserName = Bars.Configuration.ConfigurationSettings.AppSettings["ZAY.Username"];
            String barsPassword = Bars.Configuration.ConfigurationSettings.AppSettings["ZAY.Password"];
            Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(barsUserName, barsPassword, true);
            if (isAuthenticated) LoginUser(barsUserName);

            OracleConnection con = OraConnector.Handler.UserConnection;
            DateTime startDate = DateTime.ParseExact(start_date, "dd.MM.yyyy HH:mm:ss", CultureInfo.InvariantCulture);
            try
            {
                OracleCommand cmd = con.CreateCommand();
                cmd.Parameters.Add("p_start_date", OracleDbType.Date, startDate, ParameterDirection.Input);
                cmd.CommandText = "select c.*, RAWTOHEX (c.line_hash) line_hash_hex from cim_f98 c where least(nvl(delete_date,modify_date), modify_date) > :p_start_date and rownum < 1000";
                var adapter = new OracleDataAdapter(cmd);
                var dt = new DataTable(table_name);
                adapter.Fill(dt);

                var writer = new System.IO.StringWriter();
                dt.WriteXml(writer, XmlWriteMode.IgnoreSchema, false);

                var doc = new XmlDocument();
                doc.LoadXml(writer.ToString());
                return new Response<string>
                {
                    Status = 0,
                    ErrorMessage = "",
                    Data = doc,
                    RowsCount = dt.Rows.Count
                };
            }
            catch (Exception e)
            {
                return new Response<string>
                {
                    Status = -10,
                    ErrorMessage = e.Message + (e.InnerException == null ? "" : ". " + e.InnerException.Message),
                    Data = null
                };
            }
            finally
            {
                con.Close();
            }
        }

    }
}
