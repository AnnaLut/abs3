using System;
using System.Web;
using Bars.Configuration;
using Oracle.DataAccess.Client;
using System.Data;
using barsroot.core;
using Bars.Application;

//***********************
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using barsroot.Controllers;
using BarsWeb.Infrastructure;
//***********************

namespace barsroot
{
    /// <summary>
    /// Summary description for Global.
    /// </summary>
    public class Global : System.Web.HttpApplication
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        public Global()
        {
            InitializeComponent();
        }

        //*******************MVC********************
        protected void Application_Start(Object sender, EventArgs e)
        {
            Bars.Classes.OraConnector.Handler.InitOraClass();//????
            
            AreaRegistration.RegisterAllAreas();

            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }

        //обработка ненайденых страниц
        protected void Application_Error(object sender, EventArgs e)
        {
            HttpContext ctx = HttpContext.Current;
            Exception ex = ctx.Server.GetLastError();
            ctx.Response.Clear();

            RequestContext rc = ((MvcHandler)ctx.CurrentHandler).RequestContext;
            IController controller = new HomeController(); // Тут можно использовать любой контроллер, например тот что используется в качестве базового типа
            var context = new ControllerContext(rc, (ControllerBase)controller);

            var viewResult = new ViewResult();
            
            var httpException = ex as HttpException;
            if (httpException != null)
            {
                switch (httpException.GetHttpCode())
                {
                    case 404:
                        viewResult.ViewName = "Error";
                        break;

                    case 500:
                        viewResult.ViewName = "Error";
                        break;

                    default:
                        viewResult.ViewName = "Error";
                        break;
                }
            }
            else
            {
                viewResult.ViewName = "ErrorAll";
            }

            viewResult.ViewData.Model = new HandleErrorInfo(ex, context.RouteData.GetRequiredString("controller"), context.RouteData.GetRequiredString("action"));
            viewResult.ExecuteResult(context);
            ctx.Server.ClearError();
        }
        //***************************************

        protected void Session_Start(Object sender, EventArgs e)
        {

            bool formsAuthEnabled = (ConfigurationSettings.AppSettings.Get("CustomAuthentication") == "On") ? (true) : (false);
            bool adEnabled = true;
            bool useSSL = (ConfigurationSettings.AppSettings["CustomAuthentication.AuthSSL"] == "On") ? (true) : (false);
            if (useSSL && !Request.IsSecureConnection)
            {
                EnsureSsl();
                return;
            }
            if(useSSL)
                ConfigurationSettings.RefreshUserInfo(ConfigurationSettings.getUserNameFromCertificate(Request.ClientCertificate));
            if (!formsAuthEnabled|| adEnabled)
            {
                if (!Context.User.Identity.IsAuthenticated)
                {
                    return;
                }
                //throw new Exception("Неавторизований запит, ймовірно некоректно налаштований веб-сервер. Зверніться до адміністратора.");

                OracleConnection connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();

                // информация о текущем пользователе
                string userName = Context.User.Identity.Name.ToLower();
                UserMap userMap;                
//UserMap userMap = Bars.Configuration.ConfigurationSettings.GetUserInfo(userName);

                try
                {
                      

                   userMap = ConfigurationSettings.RefreshUserInfo(userName);
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
                    HttpContext.Current.Session["AD_Auth"] = true;
					//Bars.Logger.DBLogger.Info("Веб-користувач [" + userMap.user_id + "] розпочав");

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
                            throw  new Bars.Exception.BarsException("Банківський день закрито.<br>Спробуйте перезайти в систему через деякий час.");
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
               userMap = ConfigurationSettings.RefreshUserInfo(userName);
                // Если выполнили установку параметров
                Session["UserLoggedIn"] = true;
                Session[Constants.UserId] = userMap.user_id;
                CustomIdentity userIdentity = new CustomIdentity(userName, 1, true, false, userName, "", "");
                HttpContext.Current.Session["userIdentity"] = userIdentity;
                HttpContext.Current.Session["dbuser"] = userMap.dbuser;

                Bars.Logger.DBLogger.Info("Веб-користувач [" + userName + "] розпочав роботу в глобальній банківській даті - " + userMap.bank_date.ToString("dd.MM.yyyy"));

                // Проверка на возможность работы с несколькоми банковскими днями
                if (userMap.change_date == "Y")
                {
                    Response.Redirect("/barsroot/barsweb/loginpage.aspx?changedate=on");
                }

                /*try
                {
                    OracleCommand command = connect.CreateCommand();
                    command.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("basic_info");
                    command.ExecuteNonQuery();
                    
                    command.CommandText = "select web_utl.can_user_change_date from dual";
                    if ("1" == Convert.ToString(command.ExecuteScalar()))
                    {
                        Response.Redirect("/barsroot/barsweb/loginpage.aspx?changedate=on");
                    }
                    else
                    {
                        //Устновка локальной дати равной глобальной
                        command.CommandText = "begin web_utl.set_localdate_as_global; end;";
                        command.ExecuteNonQuery();
                    }
                }
                finally
                {
                    connect.Close();
                    connect.Dispose();
                }*/
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

