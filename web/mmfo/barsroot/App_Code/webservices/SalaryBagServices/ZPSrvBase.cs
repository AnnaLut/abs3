using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Net;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Xml;
using Bars.Classes;
using Bars.Configuration;
using BarsWeb.Core.Logger;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.SalaryBagSrv.Models;
using barsroot.core;
using Bars.Application;
using Dapper;
using System.Linq;

namespace Bars.SalaryBagSrv
{
    public class ZPSrvBase : BarsWebService
    {
        public void LoginUser(String userName, String session = "")
        {
            // информация о текущем пользователе
            UserMap userMap = ConfigurationSettings.GetUserInfo(userName);

            using (OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                using (OracleCommand cmd = con.CreateCommand())
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "bars.bars_login.login_user";

                    cmd.Parameters.Add("p_session_id", OracleDbType.Varchar2, string.IsNullOrWhiteSpace(session) ? Session.SessionID : session, ParameterDirection.Input);
                    //cmd.Parameters.Add("p_session_id", OracleDbType.Varchar2, Session.SessionID, ParameterDirection.Input);
                    cmd.Parameters.Add("p_user_id", OracleDbType.Varchar2, userMap.user_id, ParameterDirection.Input);
                    cmd.Parameters.Add("p_hostname", OracleDbType.Varchar2, GetHostName(), ParameterDirection.Input);
                    cmd.Parameters.Add("p_appname", OracleDbType.Varchar2, "barsroot", ParameterDirection.Input);

                    cmd.ExecuteNonQuery();
                }
            }

            // Если выполнили установку параметров
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
    }
}