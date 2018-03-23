using System;
using System.Web;
using System.Web.SessionState;
using Bars.Configuration;
using BarsWeb.Infrastructure.Repository;
using BarsWeb.Infrastructure.Repository.DI.Implementation;
using Oracle.DataAccess.Client;
using System.Data;
using barsroot.core;

//***********************
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Http;
using Bars.Application;
using BarsWeb.Core.Logger;
using BarsWeb.Infrastructure;
using BarsWeb.Areas.MyCard.Helpers;

//***********************

namespace BarsWeb
{
    /// <summary>
    /// Summary description for Global.
    /// </summary>
    public class Global : System.Web.HttpApplication
    {
        private readonly IDbLogger _dbLogger;

        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        public Global()
        {
            InitializeComponent();
            _dbLogger = DbLoggerConstruct.NewDbLogger();
        }

        //*******************MVC********************
        protected void Application_Start(Object sender, EventArgs e)
        {
            Bars.Classes.OraConnector.Handler.InitOraClass();

            ControllerBuilder.Current.SetControllerFactory(new NinjectControllerFactory());
            AreaRegistration.RegisterAllAreas();

            WebApiConfig.Register(GlobalConfiguration.Configuration);

            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            // Add a reference here to the new MediaTypeFormatter that adds text/plain support
            GlobalConfiguration.Configuration.Formatters.Insert(0, new TextMediaTypeFormatter());

        }
        protected void Application_PostAuthorizeRequest()
        {
            if (IsWebApiRequest())
            {
                HttpContext.Current.SetSessionStateBehavior(SessionStateBehavior.Required);
            }
        }

        private bool IsWebApiRequest()
        {
            return HttpContext.Current.Request.AppRelativeCurrentExecutionFilePath != null
                && HttpContext.Current.Request.AppRelativeCurrentExecutionFilePath.StartsWith(RouteConfig.UrlPrefixRelative);
        }

        //обработка ненайденых страниц
        protected void Application_Error(object sender, EventArgs e)
        {

        }
        //***************************************

        protected void Session_Start(Object sender, EventArgs e)
        {
            bool formsAuthEnabled = (ConfigurationSettings.AppSettings.Get("CustomAuthentication") == "On") ? (true) : (false);
            bool useSSL = (ConfigurationSettings.AppSettings["CustomAuthentication.AuthSSL"] == "On") ? (true) : (false);
            if (useSSL && !Request.IsSecureConnection)
            {
                EnsureSsl();
                return;
            }
            if (useSSL)
                ConfigurationSettings.RefreshUserInfo(ConfigurationSettings.getUserNameFromCertificate(Request.ClientCertificate));
            if (!formsAuthEnabled)
            {
                OracleConnection connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();

                // информация о текущем пользователе
                string userName = Context.User.Identity.Name.ToLower();
                UserMap userMap = Bars.Configuration.ConfigurationSettings.RefreshUserInfo(userName);
                try
                {
                    if (System.Configuration.ConfigurationManager.AppSettings["CustomAuthentication.AD"] == "On")
                    {
                        // установка первичных параметров
                        OracleCommand command = connect.CreateCommand();
                        command.Parameters.Add("p_session_id", OracleDbType.Varchar2, Session.SessionID, ParameterDirection.Input);
                        command.Parameters.Add("p_login_name", OracleDbType.Varchar2, userName, ParameterDirection.Input);
                        command.Parameters.Add("p_authentication_mode", OracleDbType.Varchar2, "ACTIVE DIRECTORY", ParameterDirection.Input);
                        command.Parameters.Add("p_hostname", OracleDbType.Varchar2, HttpContext.Current.Request.UserHostAddress, ParameterDirection.Input);
                        command.Parameters.Add("p_application_name", OracleDbType.Varchar2, "barsroot", ParameterDirection.Input);
                        command.CommandText = "bars.bars_login.login_user";
                        command.CommandType = CommandType.StoredProcedure;
                        command.ExecuteNonQuery();
                    }
                    else {
                        
                        if (string.IsNullOrEmpty(userMap.webuser))
                            throw new System.Exception(string.Format("Користувача {0} не знайдено у базі даних.", userName));
                        // установка первичных параметров
                        OracleCommand command = connect.CreateCommand();
                        command.Parameters.Add("p_session_id", OracleDbType.Varchar2, Session.SessionID, ParameterDirection.Input);
                        command.Parameters.Add("p_user_id", OracleDbType.Varchar2, userMap.user_id, ParameterDirection.Input);
                        command.Parameters.Add("p_hostname", OracleDbType.Varchar2, HttpContext.Current.Request.UserHostAddress, ParameterDirection.Input);
                        command.Parameters.Add("p_appname", OracleDbType.Varchar2, "barsroot", ParameterDirection.Input);
                        command.CommandText = "bars.bars_login.login_user";
                        command.CommandType = CommandType.StoredProcedure;
                        command.ExecuteNonQuery();
                    }

                }
                catch (Oracle.DataAccess.Client.OracleException ex)
                {
                    if (ex.Message.StartsWith("ORA-20984") /*Банковский день закрыт*/ ||
                        ex.Message.StartsWith("ORA-20980") /*Повторная регистрация с одним и тем же SESSION_ID*/ ||
                        ex.Message.StartsWith("ORA-20981") /*Не передан идентификатор сессии или он пустой*/ ||
                        ex.Message.StartsWith("ORA-20983") /*Пользователь не найден по переданному USER_ID*/
                      )
                    {
                        Session.Abandon();
                        if (ex.Message.StartsWith("ORA-20984"))
                        {
                            throw new Bars.Exception.BarsException("Банківський день закрито.<br>Спробуйте перезайти в систему через деякий час.");
                        }
                    }
                    else
                        throw ex;
                }
                finally
                {
                    connect.Close();
                    connect.Dispose();
                }
                // Если выполнили установку параметров
                Session["UserLoggedIn"] = true;
                Session[Constants.UserId] = userMap.user_id;
                CustomIdentity userIdentity = new CustomIdentity(userName, 1, true, false, userName, "", "");
                HttpContext.Current.Session["userIdentity"] = userIdentity;
                HttpContext.Current.Session["dbuser"] = userMap.dbuser;


                _dbLogger.Info("Веб-користувач [" + userName + "] розпочав роботу в глобальній банківській даті - " + userMap.bank_date.ToString("dd.MM.yyyy"));

                //Response.Redirect("/barsroot");
                // Проверка на возможность работы с несколькоми банковскими днями
                if (userMap.change_date == "Y")
                {
                    Response.Redirect("/barsroot/account/Calendar");
                }
            }
            else
            {
                if (ConfigurationSettings.AppSettings.Get("CustomAuthentication.UseSession") == "On")
                {
                    Session["LastAccess"] = DateTime.Now;
                }
                else
                {
                    string port = (Request.ServerVariables["SERVER_PORT"] == "80") ? ("") : (Request.ServerVariables["SERVER_PORT"]);
                    string cookieName = Bars.Configuration.ConfigurationSettings.AppSettings["CustomAuthentication.Cookie.Name"] + port;
                    if (Request.Cookies[cookieName.ToUpper()] != null)
                    {
                        Request.Cookies.Remove(cookieName.ToUpper());
                    }
                }
            }
        }

        public void Session_OnEnd()
        {
            new AccountRepository(new AppModel(), null).ClearSessionTmpDir();
        }

        public static void EnsureSsl()
        {
            Uri currentUrl = HttpContext.Current.Request.Url;
            if (!currentUrl.Scheme.Equals("https", StringComparison.CurrentCultureIgnoreCase))
            {
                UriBuilder uriBuilder = new UriBuilder(currentUrl);
                uriBuilder.Scheme = "https";
                uriBuilder.Host = HttpContext.Current.Server.MachineName;
                uriBuilder.Port = -1;
                HttpContext.Current.Response.Redirect(uriBuilder.Uri.ToString(), true);
            }
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {
            if (Request.Url.ToString().ToLower().Contains("barsweb/loginpage.aspx"))
            {
                Context.Response.StatusCode = 301;
                Context.Response.Redirect("~/Account/Login");
            }
        }

        #region Web Form Designer generated code
        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
        }
        #endregion
    }
}

