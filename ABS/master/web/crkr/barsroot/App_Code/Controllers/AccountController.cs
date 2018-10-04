using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.Security.Cryptography;
using System.Web.Mvc;
using BarsWeb.Infrastructure;
using Bars.Application;
using Bars.Configuration;
using Bars.Encryption;
using Bars.Exception;
using BarsWeb.Areas.Security.Infrastructure.Repository.Abstract;
using BarsWeb.Areas.Security.Models.Enums;
using BarsWeb.Core.Logger;

namespace BarsWeb.Controllers
{
    public class AccountController : ApplicationController
    {
        private readonly IAccountRepository _repository;
        private readonly IDbLogger _dbLogger;

        public AccountController(IAccountRepository repository, IDbLogger dbLogger)
        {
            _repository = repository;
            _dbLogger = dbLogger;
        }
        /// <summary>
        /// переброс на страницу по умолчанию
        /// </summary>
        /// <returns></returns>
        [OutputCache(Location=System.Web.UI.OutputCacheLocation.Any, Duration=60)]
        public ActionResult Index()
        {
            return RedirectToAction("login","account");
        }
        public ActionResult Login()
        {
            HttpContext.Response.StatusDescription = "401";
            ViewBag.UserKey = GetUserKey();
            ViewBag.ConstKey = GetConstKey();
            ViewBag.Challenge = GetChallenge();

            var coocies = Request.Cookies["userLogin"];
            if(coocies != null)
                ViewBag.userLogin = coocies.Values[0] ;

            if (Request.Params["action"] == "monitor")
            {
                Response.Clear();
                try
                {
                    if (ConfigurationSettings.CheckDatabase() &&
                        ConfigurationSettings.AppSettings["DBConnect.DataSource"] != null)
                        Response.Write("1");
                    else
                        Response.Write("0");
                }
                catch
                {
                    Response.Write("0");
                }

                Response.End();
                
            }
            return View();
        }

        [HttpPost]
        public ActionResult Login(FormCollection collection,string returnUrl) 
        {
            ViewBag.UserKey = GetUserKey();
            ViewBag.ConstKey = GetConstKey();
            ViewBag.Challenge = GetChallenge();
            var coocies = Request.Cookies["userLogin"];
            if (coocies != null)
                ViewBag.userLogin = coocies.Values[0];

            string userName = "";
            string hashpsw = "";
            try
            {
                string key = StringHelper.StrToBase64(Request.ServerVariables["REMOTE_ADDR"]);
                string encdata = Request.Params["encdata"];
                //Если параметр из url-я, то заменяем пробелы на +
                encdata = encdata.Replace(" ", "+");
                var rc4 = new RC4Crypto(key);
                string tmp = rc4.Decrypt(encdata);

                string[] parts = tmp.Split('\\');

                if (parts.Length == 5)
                {
                    string constKey = parts[0];
                    if (GetConstKey() != constKey)
                        throw new BarsException("Порушена цілісність шифру.");
                    string challenge = parts[1];
                    string ipAddress = StringHelper.FromBase64ToStr(parts[2]);

                    if (Request.ServerVariables["REMOTE_ADDR"] != ipAddress.Trim())
                        throw new BarsException("Доступ заборонено (невідповідна ip-адреса).");
                    if (!string.IsNullOrEmpty(challenge))
                    {
                        userName = StringHelper.FromBase64ToStr(parts[3]);
                        hashpsw = StringHelper.FromBase64ToStr(parts[4]);
                    }
                }
            }
            catch (Exception ex)
            {
                ViewBag.ErrorSumary = "Помилка авторизації (" + ex.Message + ").";
                return View();
            }

            if (string.IsNullOrEmpty(userName))
            {
                ViewBag.ErrorSumary = "Не вдалося визначити логін користувача.<br>Спробуйте перевірити налаштування браузера згідно інструкції.";
                return View();
            }

            var authorize = _repository.AuthorizeByHash(userName, hashpsw);
            switch (authorize.Status)
            {
                case AuthorizedStatusCode.Error:
                    ViewBag.ErrorSumary = authorize.Message;
                    break;
                case AuthorizedStatusCode.PasswordExpire:
                    ViewBag.ErrorSumary = authorize.Message;
                    return RedirectToAction("changepassword", "Account", new { returnUrl });
                case AuthorizedStatusCode.SelectDate:
                    return RedirectToAction("Calendar"/*, new { username = userName, message = authorize.Message + "&" + Request.QueryString }*/);
                case AuthorizedStatusCode.Ok:
                    return Redirect(string.IsNullOrWhiteSpace(returnUrl) ? Url.Content("~/") : returnUrl);
            } 

            return View();
        }

        public ActionResult ChangePassword(string userName = "", string message="")
        {
            ViewBag.UserKey = GetUserKey();
            ViewBag.ConstKey = GetConstKey();
            ViewBag.Challenge = GetChallenge();

            ViewBag.pswMinLength = ConfigurationSettings.AppSettings["CustomAuthentication.Password.MinLength"];
            ViewBag.pswMaxSeq = ConfigurationSettings.AppSettings["CustomAuthentication.Password.MaxSeq"];
            ViewBag.initPassword = ConfigurationSettings.AppSettings["CustomAuthentication.InitPassword.Hash"];
            
            var coocies = Request.Cookies["userLogin"];
            string userLogin = "";
            if (coocies != null)
                userLogin = coocies.Values[0];

            ViewBag.UserName = userName != "" ? userName : userLogin;
            ViewBag.sysUser = "";
            if (HttpContext.User.Identity.Name != string.Empty)
            {
                ViewBag.UserName = HttpContext.User.Identity.Name;
                ViewBag.sysUser = (HttpContext.User.Identity.Name.IndexOf('\\') > 0) ? (HttpContext.User.Identity.Name.Substring(HttpContext.User.Identity.Name.IndexOf('\\') + 1)) : (HttpContext.User.Identity.Name);
            }
            if (message != "") ViewBag.ErrorSumary = message;
            return View();
        }
        [HttpPost]
        public ActionResult ChangePassword(FormCollection collection)
        {
            ViewBag.UserKey = GetUserKey();
            ViewBag.ConstKey = GetConstKey();
            ViewBag.Challenge = GetChallenge();

            string userName = "";
            string hashpswOld = "";
            string hashpswNew = "";
            string hashpswNewConf = "";
            try
            {
                string key = StringHelper.StrToBase64(Request.ServerVariables["REMOTE_ADDR"]);
                string encdata = Request.Params["encdata"];
                //Если параметр из url-я, то заменяем пробелы на +
                encdata = encdata.Replace(" ", "+");
                var rc4 = new RC4Crypto(key);
                string tmp = rc4.Decrypt(encdata);

                string[] parts = tmp.Split('\\');

                if (parts.Length == 7)
                {
                    string constKey = parts[0];
                    if (GetConstKey() != constKey)
                        throw new BarsException("Порушена цілісність шифру.");
                    string challenge = parts[1];
                    string ipAddress = StringHelper.FromBase64ToStr(parts[2]);

                    if (Request.ServerVariables["REMOTE_ADDR"] != ipAddress.Trim())
                        throw new BarsException("Доступ заборонено (невідповідна ip-адреса).");
                    if (!string.IsNullOrEmpty(challenge))
                    {
                        userName = StringHelper.FromBase64ToStr(parts[3]);
                        hashpswOld = StringHelper.FromBase64ToStr(parts[4]);
                        hashpswNew = StringHelper.FromBase64ToStr(parts[5]);
                        hashpswNewConf = StringHelper.FromBase64ToStr(parts[6]);
                    }
                }
            }
            catch (Exception ex)
            {
                ViewBag.ErrorSumary = "Помилка авторизації (" + ex.Message + ").";
                return View();
            }

            bool isAuthenticated = false;
            var coocies = Request.Cookies["userLogin"];
            string userLogin = "";
            if (coocies != null)
                userLogin = coocies.Values[0];
            ViewBag.UserName = userName != "" ? userName : userLogin;

            if (userName != string.Empty && hashpswOld != string.Empty)
            {
                var authorize = _repository.AuthorizeByHash(userName, hashpswOld);
                if (authorize.Status == AuthorizedStatusCode.Error)
                {
                    ViewBag.ErrorSumary = authorize.Message;
                    return View();
                }
                isAuthenticated = true;
                if (hashpswNew != hashpswNewConf)
                {
                    Session.Abandon();
                    ViewBag.ErrorSumary = "Виявлені помилки при зміні пароля.";
                    ViewBag.ErrorPasswordNewConf = "Підтвердження пароля не співпадає";
                    return View();
                }

                ConfigurationSettings.ChangePassword(userName, hashpswNew);

                switch (authorize.Status)
                {
                    case AuthorizedStatusCode.Error:
                        ViewBag.ErrorSumary = authorize.Message;
                        break;
                    case AuthorizedStatusCode.SelectDate:
                        return RedirectToAction("Calendar", new { username = userName, message = authorize.Message + "&" + Request.QueryString });
                    case AuthorizedStatusCode.PasswordExpire:
                        return Redirect(Url.Content(Constants.LoginPageUrl));
                    case AuthorizedStatusCode.Ok:
                        return Redirect(Url.Content("~/"));
                } 
            }
            return View();
        }
        /// <summary>
        /// сторінка вибору банківської дати
        /// </summary>
        /// <param name="year">Рік</param>
        /// <param name="month">Місяць</param>
        /// <param name="returnUrl">адреса на яку повернутися</param>
        /// <returns></returns>
        [AuthorizeUser]
        [HttpGet]
        public ActionResult Calendar(int? year, int? month, string returnUrl)
        {
            string userName = User.Identity.Name;
            var userMap = ConfigurationSettings.GetUserInfo(userName);
            if (userMap.change_date == "Y")
            {
                DateTime bDate = userMap.bank_date;
                ViewBag.bankDate = bDate;
                ViewBag.curentYear = year ?? bDate.Year;
                ViewBag.curentMonth = month ?? bDate.Month;

                DateTime currentMonth = new DateTime(year ?? bDate.Year, month ?? bDate.Month, 1);

                List<DateTime> openBankDates = _repository.GetOpenBankDates(currentMonth);
                
                return View(openBankDates);
            }
            return Redirect(string.IsNullOrWhiteSpace(returnUrl) ? Url.Content("~/") : returnUrl);
        }
        [AuthorizeUser]
        public ActionResult ChangeBankDate(string date, string returnUrl)
        {
            DateTimeFormatInfo dateFormat = new DateTimeFormatInfo();
            dateFormat.ShortDatePattern = "dd/MM/yyyy";
            DateTime dateChang = Convert.ToDateTime(date, dateFormat);

            if (Session["userIdentity"] != null)
            {
                CustomPrincipal principal = new CustomPrincipal((CustomIdentity)Session["userIdentity"], new ArrayList());
                HttpContext.User = principal;
            }
            // информация о текущем пользователе
            string userName = User.Identity.Name;
            var userMap = ConfigurationSettings.GetUserInfo(userName);
            if (userMap.change_date == "Y")
            {
                _repository.ChangeUserBankDate(dateChang);

                if (dateChang != userMap.bank_date)
                {
                    Session["LocalBDate"] = "1";
                }
                _dbLogger.Info(
                    string.Format("Веб-користувач [{0}] розпочав роботу в локальній банківській даті - {1}",
                                    userName,
                                    date.ToString(dateFormat)));
                if (Session["userIdentity"] != null && Request.Params.Get("changedate") != "on")
                {
                    return Redirect(string.IsNullOrWhiteSpace(returnUrl) ? Url.Content("~/") : returnUrl);
                }
                return Redirect(string.IsNullOrWhiteSpace(returnUrl) ? Url.Content("~/") : returnUrl);
            }
            return Redirect(string.IsNullOrWhiteSpace(returnUrl) ? Url.Content("~/") : returnUrl);
        }
      
        [HttpPost]
        public void RegistryError(string stack="")
        {
            _dbLogger.Error(string.Format("ClientJsError: {0}", stack));
        }
        public void TryLogin(string login, string passwordHash)
        {
            bool isAuthenticated;

            try
            {
                isAuthenticated = CustomAuthentication.AuthenticateUser(login, passwordHash, false);
            }
            catch (AutenticationException ex)
            {
                if (ex is AutenticationPasswordExpireException)
                {
                    Response.Write(@"<script>
                                       alert('" + ex.Message + @"');
                                       location.replace('/account/changepassword/?username=" + login + "&" + Request.QueryString +@"');	
                                     </script>");
                    return;
                }
                ViewBag.ErrorSumary = ex.Message;
                return;
            }
            if (isAuthenticated)
            {
                _repository.LoginUser(login);
            }
        }
        
        public ActionResult LogOut()
        {
            if (System.Configuration.ConfigurationManager.AppSettings["CustomAuthentication.AD"] == "On")
            {
                _repository.LogOutUser();
                return Redirect( Url.Content("~/"));
            }
            else
            {
                _repository.LogOutUser();
                 return Redirect(Constants.LoginPageUrl);
            }
           
        }

        #region RC4 шифрование

        protected string GetUserKey()
        {
            return StringHelper.StrToBase64(Request.ServerVariables["REMOTE_ADDR"]);
        }

        protected string GetConstKey()
        {
            return StringHelper.StrToBase64("login barweb");
        }


        protected string GetChallenge()
        {
            string challenge = Request.Params["challenge"];

            if (challenge == null)
            {
                return CreateChallengeString();
            }
            return challenge;
        }

        private string CreateChallengeString()
        {
            var rng = new Random(DateTime.Now.Millisecond);

            // Create random string
            var salt = new byte[64];
            int index = 0;
            string localIp = Request.ServerVariables["REMOTE_ADDR"];
            localIp = localIp.PadRight(15, ' ');
            foreach (char ch in localIp)
                salt[index++] = (byte)ch;

            for (int i = 16; i < 64; )
            {
                salt[i++] = (byte)rng.Next(65, 90); // a-z
                salt[i++] = (byte)rng.Next(97, 122); // A-Z
            }

            string challenge = ComputeHashString(salt);
            return challenge;
        }

        private string ComputeHashString(byte[] salt)
        {
            var target = new byte[salt.Length];
            Buffer.BlockCopy(salt, 0, target, 0, salt.Length);

            var sha = new SHA1Managed();
            return StringHelper.ToBase64(sha.ComputeHash(target));
        }
        # endregion
    }

}