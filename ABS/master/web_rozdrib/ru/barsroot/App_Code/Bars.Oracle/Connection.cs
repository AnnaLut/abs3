using System;
using System.Collections.Specialized;
using System.Data.Common;
using System.Web;
using System.Web.Configuration;
using Oracle.DataAccess.Client;

namespace Bars.Oracle
{

    public interface IOraConnection
    {
        OracleConnection GetAppConnection();
        OracleConnection GetUserConnection(HttpContext ctx);
        OracleConnection GetUserConnection();
        string GetAdminConnectionString();
        OracleConnection GetAdminConnection();
        string GetUserConnectionString(HttpContext ctx);
        string GetUserConnectionString();
        string GetSetRoleCommand(string role);
        void EnableEventsTrace(OracleCommand cmd);
        void DisableEventsTrace(OracleCommand cmd);
    }
    /// <summary>
    /// Класс соединения с Oracle 
    /// </summary>
    public class Connection : IOraConnection
    {
        static string DataSource;

        static string AppConnectParameters;
        static string AppConnectUser;
        static string AppConnectPassword;
        static string UserConnectParameters;
        static string RoleAuth;

        public Connection()
        {
            // read settings
            NameValueCollection global_set = Bars.Configuration.ConfigurationSettings.AppSettings;
            NameValueCollection local_set = System.Configuration.ConfigurationSettings.AppSettings;

            DataSource = (null == local_set["DBConnect.DataSource"]) ? (global_set["DBConnect.DataSource"]) : (local_set["DBConnect.DataSource"]);
            AppConnectParameters = (null == local_set["DBConnect.AppConnectParameters"]) ? (global_set["DBConnect.AppConnectParameters"]) : (local_set["DBConnect.AppConnectParameters"]);
            AppConnectUser = (null == local_set["DBConnect.AppConnectUser"]) ? (global_set["DBConnect.AppConnectUser"]) : (local_set["DBConnect.AppConnectUser"]);
            AppConnectPassword = (null == local_set["DBConnect.AppConnectPassword"]) ? (global_set["DBConnect.AppConnectPassword"]) : (local_set["DBConnect.AppConnectPassword"]);
            UserConnectParameters = (null == local_set["DBConnect.UserConnectParameters"]) ? (global_set["DBConnect.UserConnectParameters"]) : (local_set["DBConnect.UserConnectParameters"]);
            RoleAuth = (null == local_set["DBConnect.RoleAuth"]) ? (global_set["DBConnect.RoleAuth"]) : (local_set["DBConnect.RoleAuth"]);
            if (RoleAuth != null)
                RoleAuth = RoleAuth.Trim().ToUpper();
        }

        /// <summary>
        /// Возвращает строку соединения для приложения
        /// </summary>
        string GetAppConnectString()
        {
            return "Data Source=" + DataSource + ";"
                   + "User ID=" + AppConnectUser + ";"
                   + "Password=" + AppConnectPassword + ";"
                   + AppConnectParameters;
        }

        /// <summary>
        /// Создает соединение для приложения
        /// </summary>
        /// <returns></returns>
        public OracleConnection GetAppConnection()
        {
            OracleConnection conn = new OracleConnection(GetAppConnectString());
            conn.Open();

            return conn;
        }

        /// <summary>
        /// Возвращает строку соединения с использованием proxy user
        /// </summary>
        /// <param name="UserName"> Имя пользователя </param>
        /// <returns></returns>
        string GetUserConnectString(/*string UserName*/)
        {
           /* return "Data Source=" + DataSource + ";"
                    + "User ID=" + UserName + ";"
                    + "Proxy User ID=" + AppConnectUser + ";"
                    + "Proxy Password=" + AppConnectPassword + ";"
                    + UserConnectParameters;*/
            return WebConfigurationManager.ConnectionStrings[BarsWeb.Infrastructure.Constants.AppConnectionStringName].ConnectionString;
        }

        /// <summary>
        /// Возвращает строку соединения               
        /// </summary>
        /// <param name="UserName"></param>
        /// <param name="Password"></param>
        /// <returns></returns>

        string GetUserConnectString(string UserName, string Password)
        {
            return "Data Source=" + DataSource + ";"
                    + "User ID=" + UserName + ";"
                    + "Password=" + Password + ";"
                    + UserConnectParameters;
        }

        /// <summary>
        /// Функция устанавливает трассу на текущую сессию
        /// </summary>
        /// <param name="cmd">OracleCommand с открытым коннектом</param>
        public void EnableEventsTrace(OracleCommand cmd)
        {
            NameValueCollection global_set = Bars.Configuration.ConfigurationSettings.CustomSettings("traceSettings");
            if (global_set == null || global_set.Count == 0 || global_set["Oracle.Trace.Mode"] == null || global_set["Oracle.Trace.Mode"].ToUpper() != "ON")
                return;
            string cur_user = cmd.Connection.ConnectionString.Split(';')[1].Split('=')[1].Trim().ToUpper();
            if ((global_set["Oracle.Trace.Users"] == null || global_set["Oracle.Trace.Users"].IndexOf(cur_user) == 0) && global_set["Oracle.Trace.Users"] != "*")
                return;

            cmd.CommandText = "ALTER SESSION SET sql_trace = TRUE";
            cmd.ExecuteNonQuery();

            if (global_set["Oracle.Trace.Timed_statistics"] != null)
            {
                if (global_set["Oracle.Trace.Timed_statistics"].ToUpper() == "TRUE")
                {
                    cmd.CommandText = "ALTER SESSION SET timed_statistics = TRUE";
                    cmd.ExecuteNonQuery();
                }
            }
            if (global_set["Oracle.Trace.Tracefile"] != null && global_set["Oracle.Trace.Tracefile"] == "true")
            {
                cmd.CommandText = "ALTER SESSION SET tracefile_identifier='" + Convert.ToString(HttpContext.Current.Request.Url.Segments[1]).Replace("/", "").ToUpper() + "' max_dump_file_size=unlimited";
                cmd.ExecuteNonQuery();
            }

            string evnt = string.Empty, level = string.Empty;
            int index = 0;
            while (global_set["Oracle.Trace.Event_" + index] != null)
            {
                evnt = global_set["Oracle.Trace.Event_" + index].Split(';')[0];
                level = global_set["Oracle.Trace.Event_" + index].Split(';')[1];
                cmd.CommandText = "ALTER SESSION SET EVENTS '" + evnt + " trace name context forever, level " + level + "'";
                cmd.ExecuteNonQuery();
                index++;
            }
        }

        /// <summary>
        /// Функция отключает установленную трассу на текущую сессию
        /// </summary>
        /// <param name="cmd">OracleCommand с открытым коннектом</param>
        public void DisableEventsTrace(OracleCommand cmd)
        {
            NameValueCollection global_set = Bars.Configuration.ConfigurationSettings.CustomSettings("traceSettings");
            if (global_set == null || global_set.Count == 0 || global_set["Oracle.Trace.Mode"] == null || global_set["Oracle.Trace.Mode"].ToUpper() != "ON")
                return;
            string cur_user = cmd.Connection.ConnectionString.Split(';')[1].Split('=')[1].Trim().ToUpper();
            if ((global_set["Oracle.Trace.Users"] == null || global_set["Oracle.Trace.Users"].IndexOf(cur_user) == 0) && global_set["Oracle.Trace.Users"] != "*")
                return;

            if (global_set["Oracle.Trace.Timed_statistics"] != null)
            {
                if (global_set["Oracle.Trace.Timed_statistics"].ToUpper() == "TRUE")
                {
                    cmd.CommandText = "ALTER SESSION SET timed_statistics = FALSE";
                    cmd.ExecuteNonQuery();
                }
            }

            int count = global_set.Count - 3;
            string evnt = string.Empty;
            for (int index = 0; index < count; index++)
            {
                evnt = global_set["Oracle.Trace.Event_" + index].Split(';')[0];
                cmd.CommandText = "ALTER SESSION SET EVENTS '" + evnt + " trace name context off";
                cmd.ExecuteNonQuery();
            }
        }

        /// <summary>
        /// По текущему контексту получаем пользовательскую строку соединения
        /// </summary>
        /// <param name="ctx"></param>
        /// <returns></returns>
        string GetUserConnectString(HttpContext ctx)
        {
            //if (!ctx.User.Identity.IsAuthenticated)
                //throw new BarsCoreException("Користувач не авторизований.");

            // логин пользователя
            /*string userLogin = ctx.User.Identity.Name.ToLower();

            // если работа через сертификат, то вместо логина подставляем серийный номер сертификата
            bool useSsl = (Configuration.ConfigurationSettings.AppSettings["CustomAuthentication.AuthSSL"] == "On");
            if (useSsl)
                userLogin = Configuration.ConfigurationSettings.getUserNameFromCertificate(ctx.Request.ClientCertificate);
            
            // имя пользователя Oracle
            string databaseUser = Configuration.ConfigurationSettings.GetUserInfo(userLogin).shared_user;
            if (string.IsNullOrWhiteSpace(databaseUser)) databaseUser = "BARS_ACCESS_USER";

            if (null == databaseUser)
                throw new BarsCoreException("Інформація про веб-користувача [" + userLogin + "] не знайдена.");

            if (null != ctx.Session)
                ctx.Session["DatabaseUser"] = databaseUser;*/

            return GetUserConnectString(/*databaseUser*/);
        }


        /// <summary>
        ///  Создает пользовательское соединение
        /// </summary>
        /// <param name="ctx"></param>
        /// <returns></returns>
        public OracleConnection GetUserConnection(HttpContext ctx)
        {
            // Получаем ссылку на своего провайдера
            string providerName = WebConfigurationManager.ConnectionStrings[BarsWeb.Infrastructure.Constants.AppConnectionStringName].ProviderName;
            DbProviderFactory factory = DbProviderFactories.GetFactory(providerName);

            OracleConnection conn = (OracleConnection)factory.CreateConnection();
            conn.ConnectionString = GetUserConnectString(ctx);
            try
            {
                conn.Open();
            }
            catch (OracleException ex)
            {
                if (ex.Message.StartsWith("Connection request timed out"))
                {
                    GC.Collect();
                    GC.WaitForPendingFinalizers();
                    GC.Collect();
                    conn.Open();
                }
                else if (ex.Message.StartsWith("ORA-604"))
                {
                    conn.Dispose();
                    throw ex;
                }
                else
                    throw ex;
            }
            return conn;
        }

        /// <summary>
        /// Создает пользовательское соединение
        /// </summary>
        /// <returns></returns>
        public OracleConnection GetUserConnection()
        {
            return GetUserConnection(HttpContext.Current);
        }

        /// <summary>
        /// Возвращает строку соединения для администратора/proxy_user'a
        /// </summary>
        /// <returns></returns>
        public string GetAdminConnectionString()
        {
            return GetAppConnectString();
        }

        /// <summary>
        /// Возвращает объект Connection для администратора/proxy_user'a
        /// </summary>
        /// <returns></returns>
        public OracleConnection GetAdminConnection()
        {
            return GetAppConnection();
        }



        /// <summary>
        /// Возвращает строку соединения для пользователя
        /// </summary>
        /// <returns></returns>
        public string GetUserConnectionString(HttpContext ctx)
        {
            return GetUserConnectString(ctx);
        }

        /// <summary>
        /// Возвращает строку соединения для пользователя
        /// </summary>
        /// <returns></returns>
        public string GetUserConnectionString()
        {
            return GetUserConnectString(HttpContext.Current);
        }

        /// <summary>
        /// Возвращает строку для установки роли в зависимости от настройки в Bars.config(параметр DBConnect.RoleAuth)
        /// </summary>
        /// <returns></returns>
        public string GetSetRoleCommand(string role)
        {
            string commandText = "set role " + role;

            if (RoleAuth == "ON")
            {
                commandText = "begin bars_role_auth.set_role('" + role.ToUpper() + "'); end;";
            }
            // Временное решение из за проблем с установкой ролей
            commandText = "begin null;end;";

            return commandText;
        }

    }
}
