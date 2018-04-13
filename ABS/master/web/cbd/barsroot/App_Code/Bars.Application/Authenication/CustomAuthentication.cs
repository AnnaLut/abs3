using System;
using System.Reflection;
using System.Collections;
using System.Text;
using System.Web;
using System.IO;
using barsroot.core;
using System.Globalization;
using Bars.Configuration;

namespace Bars.Application
{
    /// <summary>
    /// Provides static methods that supply helper utilities for authenticating identites. 
    /// This class cannot be inherited.
    /// </summary>
    public sealed class CustomAuthentication
    {
        const string LOGINURL_KEY = "CustomAuthentication.LoginUrl";
        const string AUTHENTICATION_COOKIE_KEY = "CustomAuthentication.Cookie.Name";
        const string AUTHENTICATION_COOKIE_EXPIRATION_KEY = "CustomAuthentication.Cookie.Expiration";
        const string AUTHENTICATION_USESESSION = "CustomAuthentication.UseSession";

        #region static methods
        /// <summary>
        /// Аутентифицировать пользователя (в случае ошибки ловить Bars.Exception.AutenticationException)
        /// </summary>
        /// <param name="userName">логин пользователя</param>
        /// <param name="password">пароль</param>
        /// <param name="clearPassword">true - пароль в чистом виде, false - SHA1 хеш</param>
        /// <returns></returns>
        public static bool AuthenticateUser(string userName, string password, bool clearPassword)
        {
            bool isAuthenticated = false;
            string errMessage = string.Empty;
            // Обновляем информацию об пользователе
            UserMap currentUser = ConfigurationSettings.RefreshUserInfo(userName);

            if (string.IsNullOrEmpty(currentUser.webuser))
                throw new Bars.Exception.AutenticationException("Вхід неможливий: користувач " + userName + " не існує");

            // если пароль в чистом виде, то получаем хеш пароля
            if (clearPassword)
                password = CustomEncryption.GetSHA1Hash(password);

            // включена дополнительная проверка 
            bool secEnabled = (ConfigurationSettings.AppSettings.Get("CustomAuthentication.SecureValidation") == "On")
                                  ? (true)
                                  : (false);

            if ("1" == currentUser.blocked)
            {
                errMessage = "Користувач заблокований. Зверніться до адміністратора.";
                throw new Bars.Exception.AutenticationException(errMessage);
            }

            if (string.IsNullOrEmpty(currentUser.webpass))
            {
                if (string.IsNullOrEmpty(currentUser.adminpass))
                {
                    errMessage = "Користувачу не задано пароль. Зверніться до адміністратора.";
                    throw new Bars.Exception.AutenticationException(errMessage);
                }
                if (currentUser.adminpass == password)
                    isAuthenticated = true;
            }
            else
            {
                if (currentUser.webpass == password)
                    isAuthenticated = true;
            }
            if (isAuthenticated)
            {
                CustomIdentity userIdentity = new CustomIdentity(userName, 1, true, false, userName, "", "");
                CustomPrincipal principal = new CustomPrincipal(userIdentity, new ArrayList());
                HttpContext.Current.User = principal;

                bool isOk = true;
                string message = string.Empty;
                string chgDateStr = currentUser.chgdate;
                string termExpiration = ConfigurationSettings.AppSettings["CustomAuthentication.Password.Expiration"];
                string pageFileName = Path.GetFileName(HttpContext.Current.Request.Path).ToLower();
                if (secEnabled && pageFileName != "changepsw.aspx")
                {
                    if (string.IsNullOrEmpty(termExpiration))
                        termExpiration = "60";

                    if (!string.IsNullOrEmpty(chgDateStr))
                    {
                        CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
                        cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
                        cinfo.DateTimeFormat.DateSeparator = "/";
                        DateTime date = Convert.ToDateTime(chgDateStr, cinfo);
                        date = date.AddDays(Convert.ToDouble(termExpiration));
                        if (DateTime.Now.Date > date)
                        {
                            errMessage = "Закінчився термін дії пароля. Задайте новий пароль!";
                            throw new Bars.Exception.AutenticationPasswordExpireException(errMessage);
                        }
                    }
                    else
                        ConfigurationSettings.ChangeDataLastChangePsw(userName);
                    string initHash = ConfigurationSettings.AppSettings.Get("CustomAuthentication.InitPassword.Hash");
                    if ((password == initHash) || (password == currentUser.adminpass))
                    {
                        errMessage = "Ви використовуєте технічний пароль! Задайте новий пароль.";
                        throw new Bars.Exception.AutenticationPasswordExpireException(errMessage);
                    }
                }
                if(currentUser.attemps != "0")
                    ConfigurationSettings.ClearAtempt(userName);
                HttpContext.Current.Session["userIdentity"] = userIdentity;
                HttpContext.Current.Session["dbuser"] = currentUser.dbuser;
            }
            else
            {
                if (secEnabled)
                {
                    byte attemps = Convert.ToByte(currentUser.attemps);
                    byte maxAttemps =
                        Convert.ToByte(ConfigurationSettings.AppSettings.Get("CustomAuthentication.Password.Attempts"));
                    if (attemps >= maxAttemps)
                    {
                        ConfigurationSettings.BlockUser(userName);
                        ConfigurationSettings.ClearAtempt(userName);
                        errMessage = "Користувач перевищив максимально допустиму кількість спроб вводу невірного паролю і був заблокований. Зверніться до адміністратора.";
                        throw new Bars.Exception.AutenticationException(errMessage);
                    }
                    ConfigurationSettings.AddAtempt(userName);
                    errMessage = "Вхід неможливий: невірний пароль (залишилось " + (maxAttemps - attemps) + " спроб)";
                    throw new Bars.Exception.AutenticationException(errMessage);
                }
                else 
                {
                    errMessage = "Вхід неможливий: невірний пароль";
                    throw new Bars.Exception.AutenticationException(errMessage);
                }
            }
            return isAuthenticated;
        }

        /// <summary>
        /// Переход на запрашиваемую страницу со страницы логина
        /// </summary>
        /// <param name="identity">CustomIdentity of an authenticated user</param>
        public static void RedirectFromLoginPage(CustomIdentity identity)
        {
            HttpRequest request = HttpContext.Current.Request;
            HttpResponse response = HttpContext.Current.Response;

            string returnUrl = Convert.ToString(HttpContext.Current.Session["ReturnUrl"]);
            if (string.IsNullOrEmpty(returnUrl))
                returnUrl = "/barsroot/barsweb/default.aspx";

            response.Redirect(returnUrl, true);
        }

        #endregion

    }
}
