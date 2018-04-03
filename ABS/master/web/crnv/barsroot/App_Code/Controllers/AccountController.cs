using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Bars.Encryption;
using System.Security.Cryptography;
using Bars.Exception;
using Bars.Application;
using Bars.Configuration;
using barsroot.core;
using barsroot.Models;
using Models;
using Oracle.DataAccess;

namespace barsroot.Controllers
{
    //[Authorize]
    [IsPartinalRequest]
    public class AccountController : Controller
    {
        EntitiesBars entities;
        /// <summary>
        /// переброс на страницу по умолчанию
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            return Redirect(Url.Content("~/barsweb/default.aspx"));
        }
        
        public ActionResult Login() 
        {
            ViewBag.UserKey = GetUserKey();
            ViewBag.ConstKey = GetConstKey();
            ViewBag.Challenge = GetChallenge();

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
        public ActionResult Login(FormCollection collection) 
        {
            ViewBag.UserKey = GetUserKey();
            ViewBag.ConstKey = GetConstKey();
            ViewBag.Challenge = GetChallenge();

            string const_key = "";
            string userName = "";
            string hashpsw = "";
            string challenge = "";
            string ip_address = "";
            try
            {
                string key = StringHelper.StrToBase64(Request.ServerVariables["REMOTE_ADDR"]);
                string encdata = Request.Params["encdata"];
                //Если параметр из url-я, то заменяем пробелы на +
                encdata = encdata.Replace(" ", "+");
                RC4Crypto rc4 = new RC4Crypto(key);
                string tmp = rc4.Decrypt(encdata);

                string[] parts = tmp.Split('\\');

                if (parts.Length == 5)
                {
                    const_key = parts[0];
                    if (GetConstKey() != const_key)
                        throw new BarsException("Порушена цілісність шифру.");
                    challenge = parts[1];
                    ip_address = StringHelper.FromBase64ToStr(parts[2]);

                    if (Request.ServerVariables["REMOTE_ADDR"] != ip_address.Trim())
                        throw new BarsException("Доступ заборонено (невідповідна ip-адреса).");
                    if (challenge != null
                        && challenge.Length > 0)
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

            //TryLogin(userName, hashpsw);

            bool isAuthenticated = false;
            try
            {
                isAuthenticated = CustomAuthentication.AuthenticateUser(userName, hashpsw, false);
            }
            catch (AutenticationException ex)
            {
                if (ex is AutenticationPasswordExpireException)
                {
                    return RedirectToAction("ChangePassword", new { username = userName, message=ex.Message +"&"+ Request.QueryString });
                    /*Response.Write(@"<script>
                                        alert('" + ex.Message + "');" +
                                       "location.replace('changepsw.aspx?name=" + txtUserName.Text + "&" + Request.QueryString +
                                       @"');	
                                     </script>");
                    return;*/
                }
                ViewBag.ErrorSumary = ex.Message;
                return View();
            }
            if (isAuthenticated)
            {
                var statusLogin=LoginUser(userName);
                if (statusLogin=="selDate") return RedirectToAction("");
                if (statusLogin == "err") return View();
                if (statusLogin=="ok") return Redirect(Url.Content("~/barsweb/default.aspx"));
            }
            return View();
        }

        public ActionResult ChangePassword(string UserName = "", string message="")
        {
            ViewBag.UserKey = GetUserKey();
            ViewBag.ConstKey = GetConstKey();
            ViewBag.Challenge = GetChallenge();

            var t = User.Identity.IsAuthenticated;
            ViewBag.pswMinLength = Bars.Configuration.ConfigurationSettings.AppSettings["CustomAuthentication.Password.MinLength"];
            ViewBag.pswMaxSeq = Bars.Configuration.ConfigurationSettings.AppSettings["CustomAuthentication.Password.MaxSeq"];
            ViewBag.initPassword = Bars.Configuration.ConfigurationSettings.AppSettings["CustomAuthentication.InitPassword.Hash"];
            ViewBag.UserName = UserName != "" ? UserName : Response.Cookies["userLogin"].Value;
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

            string const_key = "";
            string userName = "";
            string hashpswOld = "";
            string hashpswNew = "";
            string hashpswNewConf = "";
            string challenge = "";
            string ip_address = "";
            try
            {
                string key = StringHelper.StrToBase64(Request.ServerVariables["REMOTE_ADDR"]);
                string encdata = Request.Params["encdata"];
                //Если параметр из url-я, то заменяем пробелы на +
                encdata = encdata.Replace(" ", "+");
                RC4Crypto rc4 = new RC4Crypto(key);
                string tmp = rc4.Decrypt(encdata);

                string[] parts = tmp.Split('\\');

                if (parts.Length == 7)
                {
                    const_key = parts[0];
                    if (GetConstKey() != const_key)
                        throw new BarsException("Порушена цілісність шифру.");
                    challenge = parts[1];
                    ip_address = StringHelper.FromBase64ToStr(parts[2]);

                    if (Request.ServerVariables["REMOTE_ADDR"] != ip_address.Trim())
                        throw new BarsException("Доступ заборонено (невідповідна ip-адреса).");
                    if (challenge != null
                        && challenge.Length > 0)
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
            if (userName != string.Empty && hashpswOld != string.Empty)
            {
                try
                {
                    isAuthenticated = CustomAuthentication.AuthenticateUser(userName, hashpswOld, false);
                }
                catch (AutenticationException ex)
                {
                    // Если смена пароля то, ничего не делаем
                    if (ex is AutenticationPasswordExpireException)
                    {
                        isAuthenticated = true;
                    }
                    else
                    {
                        ViewBag.ErrorSumary = ex.Message;
                        return View();
                    }
                }
            }
            if (isAuthenticated)
            {
                if (hashpswNew == hashpswNewConf)
                    Bars.Configuration.ConfigurationSettings.ChangePassword(userName, hashpswNew);
                else
                {
                    Session.Abandon();
                    ViewBag.ErrorSumary = "Виявлені помилки при зміні пароля.";
                    ViewBag.ErrorPasswordNewConf = "Підтвердження пароля не співпадає";
                    return View();
                }
                var statusLogin = LoginUser(userName);
                if (statusLogin == "selDate") return RedirectToAction("");
                if (statusLogin == "err") return View();
                if (statusLogin == "ok") return Redirect(Url.Content("~/barsweb/default.aspx"));


                /*if (!canUserChangeDate(userName))
                    CustomAuthentication.RedirectFromLoginPage((CustomIdentity)Session["userIdentity"]);
                */
            }
            else
            {
                ViewBag.ErrorSumary = "Виявлені помилки при зміні пароля.";
                ViewBag.ErrorPasswordOld = "Невірний старий пароль";
            }

            return View();
        }


        public void TryLogin(string login, string password_hash)
        {
            bool isAuthenticated = false;

            try
            {
                isAuthenticated = CustomAuthentication.AuthenticateUser(login, password_hash, false);
            }
            catch (AutenticationException ex)
            {
                if (ex is AutenticationPasswordExpireException)
                {
                    Response.Write(@"<script>
                                        alert('" + ex.Message + "');" +
                                       "location.replace('/Account/ChangePassword/?UserName=" + login + "&" + Request.QueryString +
                                       @"');	
                                     </script>");
                    return;
                }
                ViewBag.ErrorSumary = ex.Message;
                return;
            }
            if (isAuthenticated)
            {
                LoginUser(login);
            }
        }

        private string GetHostName()
        {
            string userHost = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

            if (String.IsNullOrEmpty(userHost) || String.Compare(userHost, "unknown", true) == 0)
                userHost = Request.UserHostAddress;

            if (String.Compare(userHost, Request.UserHostName) != 0)
                userHost += " (" + Request.UserHostName + ")";

            return userHost;
        }

        private string LoginUser(string userName)
        {
            // информация о текущем пользователе
            UserMap userMap = Bars.Configuration.ConfigurationSettings.GetUserInfo(userName);
            entities = new EntitiesBarsCore().GetEntitiesBars();
            var t = entities.Connection.ConnectionString;
            var barsPage= new Bars.BarsPage();
            try
            {
                /*try
                {
                    entities.BARS_LOGIN_LOGIN_USER(Convert.ToString(Session.SessionID), Convert.ToDecimal(userMap.user_id), GetHostName(), "barsroot");
                }
                catch (Exception e) 
                {
                   var t1 = e;
                }*/

                barsPage.InitOraConnection();
                 /*InitOraConnection();*/
                // установка первичных параметров
                barsPage.SetParameters("p_session_id", Bars.BarsPage.DB_TYPE.Varchar2, Session.SessionID, Bars.BarsPage.DIRECTION.Input);
                barsPage.SetParameters("p_user_id", Bars.BarsPage.DB_TYPE.Varchar2, userMap.user_id, Bars.BarsPage.DIRECTION.Input);
                barsPage.SetParameters("p_hostname", Bars.BarsPage.DB_TYPE.Varchar2, GetHostName(), Bars.BarsPage.DIRECTION.Input);
                barsPage.SetParameters("p_appname", Bars.BarsPage.DB_TYPE.Varchar2, "barsroot", Bars.BarsPage.DIRECTION.Input);
                barsPage.SQL_PROCEDURE("bars.bars_login.login_user");
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
                        ViewBag.ErrorSumary = "Банківський день закрито.<br>Спробуйте перезайти в систему через деякий час.";
                        return "err";
                    }
                }
                else
                    throw ex;
            }
            finally
            {
                barsPage.DisposeOraConnection();
            }
            // Если выполнили установку параметров
            Session["UserLoggedIn"] = true;

            Bars.Logger.DBLogger.Info("Веб-користувач [" + userName + "] розпочав роботу в глобальній банківській даті - " + userMap.bank_date.ToString("dd.MM.yyyy"));

            // Проверка на возможность работы с несколькоми банковскими днями
            if (userMap.change_date == "Y")
            {
                return "selDate"; //ShowBankDates();
            }
            else
                return "ok";//CustomAuthentication.RedirectFromLoginPage((CustomIdentity)Session["userIdentity"]);
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
            else
            {
                return challenge;
            }
        }

        private string CreateChallengeString()
        {
            System.Random rng = new Random(DateTime.Now.Millisecond);

            // Create random string
            byte[] salt = new byte[64];
            int index = 0;
            string local_ip = Request.ServerVariables["REMOTE_ADDR"];
            local_ip = local_ip.PadRight(15, ' ');
            foreach (char ch in local_ip)
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
            byte[] target = new byte[salt.Length];
            System.Buffer.BlockCopy(salt, 0, target, 0, salt.Length);

            SHA1Managed sha = new SHA1Managed();
            return StringHelper.ToBase64(sha.ComputeHash(target));
        }
        # endregion
    }

}