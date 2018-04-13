using System;
using System.Collections;
using System.Collections.Specialized;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.Threading;
using System.Web;
using System.Web.Mvc;
using System.Web.SessionState;
using System.Web.UI;
using Bars.Classes;
using Bars.Configuration;

namespace Bars.Application
{
    /// <summary>
    /// Базовый клас приложения 
    /// </summary>
    public sealed class BarsModule : IHttpModule, IRequiresSessionState
    {
        HttpApplication app = null;
        const string AUTHENTICATION = "CustomAuthentication";
        const string AUTHENTICATION_USESESSION = "CustomAuthentication.UseSession";
        const string AUTHENTICATION_COOKIE_KEY = "CustomAuthentication.Cookie.Name";
        const string AUTHENTICATION_COOKIE_EXPIRATION_KEY = "CustomAuthentication.Cookie.Expiration";
        const string AUTHENTICATION_SESSION_EXPIRATION_KEY = "CustomAuthentication.Session.Expiration";
        const string ERRORPAGE = "Error.ErrorPage";
        const string TRACEASP = "ASP.Trace.Mode";
        //-----------------------------------------------
        const string DEFAULT_LANGUAGE = "ru";
        const string COOKIES_NAME = "LanguagePref";
        private string CURRENT_LANGUAGE = String.Empty;

        //-----------------------------------------------

        /// <summary>
        /// Первичная инициализация приложения 
        /// </summary>
        /// <param name="httpapp">The HttpApplication module</param>
        public void Init(HttpApplication httpapp)
        {
            this.app = httpapp;

            // работа через формсовую аутентификацию (логин),
            //  перехватываем загрузку каждой страницы
            if (ConfigurationSettings.AppSettings[AUTHENTICATION] == "On")
                app.AcquireRequestState += new EventHandler(this.OnAuthenticate);
            else
                app.AcquireRequestState += new EventHandler(this.SelectLanguage);

            // Глобальный перехват загрузки всех страниц приложения с проверкой на доступ
            app.PreRequestHandlerExecute += new EventHandler(this.GlobalHandler);

            // Наш обработчик ошибок
            if (ConfigurationSettings.AppSettings[ERRORPAGE] == "On")
                app.Error += new EventHandler(this.OnError);

            // Инициализация библиотеки доступа к ORACLE
            OraConnector.Handler.InitOraClass();

            try
            {
                // Очистка темповой директории
                Thread thread = new Thread(new ThreadStart(clearTempFolder));
                thread.Priority = ThreadPriority.Lowest;
                thread.IsBackground = true;
                thread.Start();
            }
            catch { }
        }

        private void clearTempFolder()
        {
            string logFile = Path.Combine(Path.GetTempPath(), "barsweb.log");
            if (File.Exists(logFile))
            {
                FileInfo fi = new FileInfo(logFile);
                if (fi.LastAccessTime >= DateTime.Now.AddHours(-1)) return;
            }

            try
            {
                using (StreamWriter sw = new StreamWriter(logFile, false))
                {
                    sw.WriteLine("Start clean: " + DateTime.Now.ToShortDateString() + " " + DateTime.Now.ToShortTimeString());
                    try
                    {
                        foreach (string dirPath in Directory.GetDirectories(Path.GetTempPath()))
                        {
                            DirectoryInfo di = new DirectoryInfo(dirPath);
                            if (di.Name.Contains("Scans"))
                                continue;
                            if (di.LastAccessTime < DateTime.Now.AddDays(-1))
                            {
                                foreach (string file in Directory.GetFiles(dirPath))
                                {
                                    try { File.Delete(file); sw.WriteLine("File deleted :" + file); }
                                    catch { sw.WriteLine("File locked : " + file); }
                                }
                                try { Directory.Delete(dirPath, true); }
                                catch { }
                            }
                        }
                        foreach (string file in Directory.GetFiles(Path.GetTempPath()))
                        {
                            if (file.EndsWith("barsweb.log")) continue;
                            FileInfo fi = new FileInfo(file);
                            if (fi.LastAccessTime < DateTime.Now.AddDays(-1))
                            {
                                try { File.Delete(file); sw.WriteLine("File deleted: " + file); }
                                catch { sw.WriteLine("File locked : " + file); }
                            }
                        }
                    }
                    catch { }
                    sw.Close();
                }
            }
            catch { }
        }


        /// <summary>
        /// Глобальный перехват ошибок
        /// </summary>
        void OnError(object sender, EventArgs e)
        {
            app = (HttpApplication)sender;

            // Если не авторизирован, то выходим
            if (HttpContext.Current == null || !HttpContext.Current.User.Identity.IsAuthenticated)
                return;

            if (app.Server.GetLastError() == null)
                return;
            System.Exception ex = app.Server.GetLastError().InnerException;
            if (ex == null)
                ex = app.Server.GetLastError();
            if (ex == null) return;
            // Попытка почистить память при OutOfMemory исключении
            if (ex.Message.Contains("OutOfMemoryException"))
            {
                GC.Collect(); 
                GC.WaitForPendingFinalizers();
                GC.Collect();
            }

            if (HttpContext.Current.Session != null)
            {
                // Сохраняем в сесии ошибку
                HttpContext.Current.Session["AppError"] = ex;
                // Сохраняем первичный адрес страницы
                string currUrl = HttpContext.Current.Request.Url.AbsoluteUri;
                if (!currUrl.Contains("dialog.aspx?type=err") && !currUrl.ToLower().Contains("errors/index"))
                {
                    HttpContext.Current.Session["UrlPageError"] = currUrl;
                    //якщо MVC
                    if (HttpContext.Current.CurrentHandler as MvcHandler != null)
                    {
                        HttpContext.Current.Response.Redirect("~/errors/index/?type=AppError&_=" + DateTime.Now.Ticks);
                    }
                    else
                    {
                        HttpContext.Current.Response.Redirect("dialog.aspx?type=err&s=" + DateTime.Now.Ticks);
                    }

                }
            }
        }

        /// <summary>
        /// Аутентификация страницы
        /// </summary>
        void OnAuthenticate(object sender, EventArgs e)
        {
            app = (HttpApplication)sender;
            HttpRequest req = app.Request;
            HttpResponse res = app.Response;

            // имя файла страницы
            string pageFileName = Path.GetFileName(req.Path).ToLower();
            // разширение страницы
            string pageFileExt = Path.GetExtension(req.Path).ToLower();
            // страница логина
            string loginPage = "loginpage.aspx";

            // Исключения аутентификации специфических страниц
            if (/*string.IsNullOrEmpty(pageFileName) ||*/
                 pageFileName == loginPage ||
                 (pageFileName == "dialog.aspx" && (req.QueryString["type"] == "promptpsw" || req.QueryString["type"] == "BarsPayments")) ||
                 pageFileName == "changepsw.aspx" ||
                 pageFileName == "crystalimagehandler.aspx" ||
                 pageFileName == "webresource.axd" ||
                 app.Context.Session == null
               )
                return;

            bool isUserLoggedIn = (app.Context.Session["userIdentity"] != null);

            // Пользователь авторизирован
            if (isUserLoggedIn)
            {
                //Отслеживаем время бездействия
                if (app.Context.Session["LastAccess"] != null)
                {
                    // Время жизни сесии
                    string timeExpr = ConfigurationSettings.AppSettings[AUTHENTICATION_SESSION_EXPIRATION_KEY];
                    DateTime dLastAcces = (DateTime)app.Context.Session["LastAccess"];
                    DateTime dMax = dLastAcces.AddMinutes(Convert.ToDouble(timeExpr));
                    //время истекло 
                    if (DateTime.Now > dMax)
                    {
                        // убиваем сесию
                        app.Context.Session.Abandon();
                        if (pageFileExt != ".asmx")
                        {
                            app.Context.Session["ReturnUrl"] = "/barsroot/barsweb/default.aspx";
                            res.Redirect("~/account/login/", true);
                            return;
                        }
                    }
                    else if (pageFileName != "synchead.asmx" && req.Path != "/barsroot/messagesctrl/count/")
                        app.Context.Session["LastAccess"] = DateTime.Now;
                }
                // Достаем из сесии идентификацию пользователя, сохраненную на логине
                CustomIdentity userIdentity = (CustomIdentity)app.Context.Session["userIdentity"];

                // Роли, пока пустые 
                string[] roles = userIdentity.UserRoles.Split(new char[] { '|' });
                ArrayList arrRoles = new ArrayList();
                arrRoles.InsertRange(0, roles);
                // Создание объекта мдетификации по пользователю
                CustomPrincipal principal = new CustomPrincipal(userIdentity, arrRoles);
                app.Context.User = principal;
                Thread.CurrentPrincipal = principal;

                // Установка UI культуры
                SelectLanguage(sender, e);
            }
            else
            {
                // если страница не aspx, то выходим 
                if (pageFileExt != ".aspx")
                    return;
                else
                {
                    string originUrl = req.Url.PathAndQuery;
                    string originPath = req.Url.AbsolutePath;
                    string originQuery = req.Url.Query;
                    if (req["login"] != null && req["hp"] != null)
                    {
                        originQuery = string.Empty;
                        string login = req["login"];
                        string hp = req["hp"];
                        app.Context.Session["AutoLogin.Login"] = login;
                        app.Context.Session["AutoLogin.PasswordHash"] = hp;

                        NameValueCollection pars = HttpUtility.ParseQueryString(req.Url.Query);
                        pars.Remove("login");
                        pars.Remove("hp");
                        foreach (string key in pars.Keys)
                            originQuery += string.Format("{0}={1}&", key, pars[key]);

                        if (originQuery.EndsWith("&")) originQuery = "?" + originQuery.Substring(0, originQuery.Length - 1);

                        app.Context.Session["AutoLogin.PageUrl"] = originPath + originQuery;

                        originUrl = "/barsroot/barsweb/default.aspx";
                    }

                    app.Context.Session["ReturnUrl"] = originUrl;

                    //res.Redirect("/barsroot/barsweb/" + loginPage, true);



                    res.Redirect("~/account/login/", true);
                    return;
                }
            }

        }

        void GlobalHandler(object sender, EventArgs e)
        {
            app = (HttpApplication)sender;
            HttpRequest req = app.Request;
            IHttpHandler handler = app.Context.Handler;
            //перехват загрузки страницы
            if (handler is Page)
            {
                string pageFileName = Path.GetFileName(req.Path);
                if (pageFileName != "loginpage.aspx" && pageFileName != "changepsw.aspx")
                    ((Page)handler).Load += new EventHandler(this.onCheckPage);
            }
            /*if (handler is System.Web.Mvc.MvcHandler)
            {
                string pageFileName = Path.GetFileName(req.Path);
                if (pageFileName != "loginpage.aspx" && pageFileName != "changepsw.aspx")
                    ((System.Web.Mvc.MvcHandler)handler).Load += new EventHandler(this.onCheckPage); 
            }*/
        }

        void onCheckPage(object sender, EventArgs e)
        {
            if (ConfigurationSettings.CustomSettings("traceSettings")[TRACEASP] == "On")
            {
                Debug.Listeners.Clear();
                Debug.Listeners.Add(new TraceListener());
                Debug.Write("On");
            }

            OraConnector.Handler.CheckAccessForPage();
        }

        /// <summary>
        /// Создание культуры 
        /// </summary>
        private CultureInfo createCulture(String Language)
        {
            CultureInfo _ci;
            // Если культура допустимая
            if ("uk" == Language.ToLower() ||
                "ru" == Language.ToLower() ||
                "en" == Language.ToLower()
                )
                _ci = CultureInfo.CreateSpecificCulture(Language.ToLower());
            else
                _ci = CultureInfo.CreateSpecificCulture(DEFAULT_LANGUAGE);
            return _ci;
        }

        /// <summary>
        /// Установка UI культуры нити 
        /// </summary>
        public void SelectLanguage(object sender, EventArgs e)
        {
            // Текущая культура
            CultureInfo currentCulture;
            HttpCookie _cookie;
            app = (HttpApplication)sender;
            HttpRequest Request = app.Request;
            HttpResponse Response = app.Response;
            if (ConfigurationSettings.AppSettings.Get("Localization.Mode") == "Off")
            {
                // Берем культуру из Bars.config
                currentCulture = createCulture(ConfigurationSettings.AppSettings.Get("Localization.UICulture"));
            }
            else
            {
                // Если пользователя нет в БД
                if (ConfigurationSettings.AppSettings.Get("allowAnonymousAuthentication") == "On")
                {
                    // Пытаемся прочитать язык с Cookies
                    _cookie = Request.Cookies[COOKIES_NAME];
                    CURRENT_LANGUAGE = _cookie.Value;
                    // Если нет - читаем настройки пользователя
                    if (String.Empty == CURRENT_LANGUAGE || null == CURRENT_LANGUAGE)
                    {
                        CURRENT_LANGUAGE = Request.UserLanguages[0].Substring(0, 2);
                    }
                }
                else
                {
                    // читаем из профиля
                    CURRENT_LANGUAGE = WebUserProfiles.GetParam("UI_CULTURE");
                }
                // создаем культуру
                currentCulture = createCulture(CURRENT_LANGUAGE);
            }
            // устанавливаем культуру нити
            Thread.CurrentThread.CurrentUICulture = currentCulture;
        }

        public void Dispose()
        {
        }
    }
}
