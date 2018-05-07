using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using BarsWeb.Areas.Security.Models;
using BarsWeb.Areas.Security.Models.Enums;
using BarsWeb.Core;
using BarsWeb.Core.Infrastructure.Helpers;
using BarsWeb.Core.Infrastructure.Repository;
using BarsWeb.Core.Logger;
using BarsWeb.Core.Models;

namespace BarsWeb.Areas.Security.Infrastructure.Repository
{
    /// <summary>
    /// Summary description for AccountRepository
    /// </summary>
    public class AccountRepository : IAccountRepository
    {
        readonly SecurityDbContext _entities;
        private readonly IEncryptionHelper _encryption;
        private readonly IUserInfoRepository _userInfoRepo;
        private readonly IDbLogger _logger;
        public AccountRepository(
            ISecurityModel model, 
            IEncryptionHelper encryption, 
            IUserInfoRepository userInfoRepo,
            IDbLogger logger)
        {
            _entities = model.GetDbContext();
            _encryption = encryption;
            _userInfoRepo = userInfoRepo;
            _logger = logger;
        }

        public AuthorizedStatus Authorize(string userName, string password)
        {
            password = _encryption.GetSha1Hash(password);
            return AuthorizeByHash(userName, password);
        }

        public AuthorizedStatus AuthorizeByHash(string userName, string hashPass)
        {
            var result = new AuthorizedStatus();
            bool isAuthenticated;
            try
            {
                isAuthenticated = CustomAuthenticateUser(userName, hashPass, false);
            }
            catch (AutenticationPasswordExpireException e)
            {
                result.Status = AuthorizedStatusCode.PasswordExpire;
                result.Message = e.Message;
                return result;
            }
            catch (AutenticationException ex)
            {
                /*if (ex is AutenticationPasswordExpireException)
                {
                    result.Status = AuthorizedStatusCode.PasswordExpire;
                }*/
                result.Status = AuthorizedStatusCode.Error;
                result.Message = ex.Message;
                return result;
            }
            if (isAuthenticated)
            {
                result.Status = LoginUser(userName);
                switch (result.Status)
                {
                    case AuthorizedStatusCode.Error:
                        result.Message = "Банківський день закрито.<br>Спробуйте перезайти в систему через деякий час.";
                        break;
                    case AuthorizedStatusCode.SelectDate:
                        return result;
                    case AuthorizedStatusCode.Ok:
                        return result;
                }
            }
            else
            {
                result.Status = AuthorizedStatusCode.Error;
                result.Message = "Користувач не авроризований. Помилка не визначена";
            }
            return result;
        }

        public AuthorizedStatusCode LoginUser(string userName)
        {
            // информация о текущем пользователе
            UserInfo userMap = _userInfoRepo.GetUserInfo(userName);
            var result = BaseLoginUser(Convert.ToDecimal(userMap.Id));
            // Проверка на возможность работы с несколькоми банковскими днями
            if (result == AuthorizedStatusCode.Error && userMap.ChangeDate != "Y")
            {
                HttpContext.Current.Session.Abandon();
                return result;
            }
            if (userMap.ChangeDate == "Y")
            {
                result = AuthorizedStatusCode.SelectDate;
            }
            // Если выполнили установку параметров
            HttpContext.Current.Session["UserLoggedIn"] = true;
            HttpContext.Current.Session[Constants.SkUserId] = userMap.Id;
            _logger.Info(string.Format("Веб-користувач [ {0} ] розпочав роботу в глобальній банківській даті - {1}",
                                                    userName, 
                                                    userMap.BankDate.ToString("dd.MM.yyyy")));

            return result;
        }

        public AuthorizedStatusCode LoginUser(decimal userId)
        {
            var result = BaseLoginUser(userId);
            // Если выполнили установку параметров
            HttpContext.Current.Session["UserLoggedIn"] = true;
            HttpContext.Current.Session[Constants.SkUserId] = userId;
            _logger.Info(string.Format("Користувач [ {0} ] розпочав роботу з веб додатком",userId));
            return result;
        }

        public AuthorizedStatusCode BaseLoginUser(decimal userId)
        {
            var sql = @"begin 
                            bars.bars_login.login_user(
                                :p_session_id,
                                :p_user_id,
                                :p_hostname,
                                :p_appname);
                        end;";
            object[] parameters =
            {
                HttpContext.Current.Session.SessionID,
                Convert.ToString(userId),
                GetHostName(),
                "barsroot"
            };
            _entities.Database.ExecuteSqlCommand(sql, parameters);
            try
            {
                _entities.Database.ExecuteSqlCommand(sql, parameters);
            }
            catch (Exception ex)
            {
                if (ex.Message.StartsWith("ORA-20984") /*Банковский день закрыт*/ ||
                    ex.Message.StartsWith("ORA-20980") /*Повторная регистрация с одним и тем же SESSION_ID*/ ||
                    ex.Message.StartsWith("ORA-20981") /*Не передан идентификатор сессии или он пустой*/ ||
                    ex.Message.StartsWith("ORA-20983") /*Пользователь не найден по переданному USER_ID*/
                  )
                {
                    if (ex.Message.StartsWith("ORA-20984"))
                    {
                        return AuthorizedStatusCode.Error;
                    }
                }
                else
                    throw;
            }

            return AuthorizedStatusCode.Ok;
        }

        public List<DateTime> GetOpenBankDates(DateTime currentMonth)
        {
            object[] parameters =
                {
                    currentMonth.AddDays(-1),
                    currentMonth.AddDays(DateTime.DaysInMonth(currentMonth.Year, currentMonth.Month))
                };
            const string sql = "SELECT fdat FROM bars.v_open_bankdates where fdat > :p_dstart and fdat <:p_dend";
            var openBankDates = _entities.Database.SqlQuery<DateTime>(sql, parameters).ToList();
            return openBankDates;
        }

        public void ChangeUserBankDate(DateTime date)
        {
            object[] parameters =
                {
                    date
                };
            _entities.Database.ExecuteSqlCommand("begin bars.bars_login.set_user_bankdate(:p_ldate); end;", parameters);
        }
        public void LogOutUser()
        {
            var context = HttpContext.Current;
            if (ConfigurationSettings.AppSettings["CustomAuthentication.UseSession"] != "On")
            {
                string port = (context.Request.ServerVariables["SERVER_PORT"] == "80") ? ("") : (context.Request.ServerVariables["SERVER_PORT"]);
                string cookieName = ConfigurationSettings.AppSettings["CustomAuthentication.Cookie.Name"] + port;
                HttpCookie cookie = context.Request.Cookies[cookieName.ToUpper()];
                if (cookie != null)
                {
                    cookie.Expires = DateTime.Now.AddDays(-1);
                    context.Response.Cookies.Add(cookie);
                }
            }
            ClearSessionTmpDir();
            context.Session.Abandon();
        }


        private void ChangePassword(string userLogin, string pswhash)
        {
            var sql = "begin bars.web_utl.change_password(:p_webuser,:p_pswhash); end;";
            _entities.Database.ExecuteSqlCommand(sql, userLogin, pswhash);
        }
        private void AddUserAtempt(string userLogin)
        {
            var sql = "begin bars.web_utl.add_user_atempt(:p_webuser); end;";
            _entities.Database.ExecuteSqlCommand(sql, userLogin);
        }

        private void CleraUserAtempt(string userLogin)
        {
            var sql = "begin bars.web_utl.clear_user_atempt(:p_webuser); end;";
            _entities.Database.ExecuteSqlCommand(sql, userLogin);
        }

        private void BlockUser(string userLogin)
        {
            var sql = "begin bars.web_utl.blockUser(:p_webuser); end;";
            _entities.Database.ExecuteSqlCommand(sql, userLogin);
        }
        private void ChangeDataLastChangePsw(string userLogin)
        {
            var sql = "begin bars.web_utl.set_user_changedate(:p_webuser,:p_dt); end;";
            _entities.Database.ExecuteSqlCommand(sql, userLogin, DateTime.Now);
        }



        public string GetHostName()
        {
            string userHost = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

            if (String.IsNullOrEmpty(userHost) || String.Compare(userHost, "unknown", StringComparison.OrdinalIgnoreCase) == 0)
                userHost = HttpContext.Current.Request.UserHostAddress;

            if (String.CompareOrdinal(userHost, HttpContext.Current.Request.UserHostName) != 0)
                userHost += " (" + HttpContext.Current.Request.UserHostName + ")";

            return userHost;
        }
        public void ClearSessionTmpDir()
        {
            var context = HttpContext.Current;
            if (context != null && context.Session != null && context.Session.SessionID != null)
            {
                string strTempDir = Path.Combine(Environment.GetEnvironmentVariable("TEMP") ?? Path.GetTempPath(),
                    context.Session.SessionID);
                DeletePatch(strTempDir);
            }
        }
        private void DeletePatch(string dir)
        {
            if (Directory.Exists(dir))
            {
                DirectoryInfo dirInfo = new DirectoryInfo(dir);
                foreach (var file in dirInfo.GetFiles())
                {
                    try
                    {
                        file.Delete();
                    }
                    catch (Exception)
                    {
                        //тушимо Exception на випадок якщо файл зайнятий
                    }
                }
                foreach (var d in dirInfo.GetDirectories())
                {
                    DeletePatch(d.FullName);
                }
                try
                {
                    dirInfo.Delete();
                }
                catch (Exception)
                {
                    //тушимо Exception на випадок якщо каталог зайнятий
                }
            }
        }






        /// <summary>
        /// Аутентифицировать пользователя (в случае ошибки ловить AutenticationException)
        /// </summary>
        /// <param name="userName">логин пользователя</param>
        /// <param name="password">пароль</param>
        /// <param name="clearPassword">true - пароль в чистом виде, false - SHA1 хеш</param>
        /// <returns></returns>
        public bool CustomAuthenticateUser(string userName, string password, bool clearPassword)
        {
            bool isAuthenticated = false;
            string errMessage;
            // Обновляем информацию об пользователе
            UserInfo currentUser = _userInfoRepo.GetUserInfo(userName);

            if (string.IsNullOrEmpty(currentUser.Login))
                throw new AutenticationException("Вхід неможливий: користувач " + userName + " не існує");

            // если пароль в чистом виде, то получаем хеш пароля
            if (clearPassword)
                password = _encryption.GetSha1Hash(password);

            // включена дополнительная проверка 
            bool secEnabled = (ConfigurationSettings.AppSettings.Get("CustomAuthentication.SecureValidation") == "On");

            if (1 == currentUser.Blocked)
            {
                errMessage = "Користувач заблокований. Зверніться до адміністратора.";
                throw new AutenticationException(errMessage);
            }

            if (string.IsNullOrEmpty(currentUser.Password))
            {
                if (string.IsNullOrEmpty(currentUser.AdminPassword))
                {
                    errMessage = "Користувачу не задано пароль. Зверніться до адміністратора.";
                    throw new AutenticationException(errMessage);
                }
                if (currentUser.AdminPassword == password)
                    isAuthenticated = true;
            }
            else
            {
                if (currentUser.Password == password)
                    isAuthenticated = true;
            }
            if (isAuthenticated)
            {
                CustomIdentity userIdentity = new CustomIdentity(userName, 1, true, false, userName, "", "");
                CustomPrincipal principal = new CustomPrincipal(userIdentity, new ArrayList());
                HttpContext.Current.User = principal;

                string chgDateStr = currentUser.ChangeDate;
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
                            throw new AutenticationPasswordExpireException(errMessage);
                        }
                    }
                    else
                        ChangeDataLastChangePsw(userName);
                    string initHash = ConfigurationSettings.AppSettings.Get("CustomAuthentication.InitPassword.Hash");
                    if ((password == initHash) || (password == currentUser.AdminPassword))
                    {
                        errMessage = "Ви використовуєте технічний пароль! Задайте новий пароль.";
                        throw new AutenticationPasswordExpireException(errMessage);
                    }
                }
                if (currentUser.Attempts != 0)
                    CleraUserAtempt(userName);
                HttpContext.Current.Session["userIdentity"] = userIdentity;
                HttpContext.Current.Session["dbuser"] = currentUser.Login;
            }
            else
            {
                if (secEnabled)
                {
                    byte attemps = Convert.ToByte(currentUser.Attempts);
                    byte maxAttemps =
                        Convert.ToByte(ConfigurationSettings.AppSettings.Get("CustomAuthentication.Password.Attempts"));
                    if (attemps >= maxAttemps)
                    {
                        BlockUser(userName);
                        CleraUserAtempt(userName);
                        errMessage = "Користувач перевищив максимально допустиму кількість спроб вводу невірного паролю і був заблокований. Зверніться до адміністратора.";
                        throw new AutenticationException(errMessage);
                    }
                    AddUserAtempt(userName);
                    errMessage = "Вхід неможливий: невірний пароль (залишилось " + (maxAttemps - attemps) + " спроб)";
                    throw new AutenticationException(errMessage);
                }
                else
                {
                    errMessage = "Вхід неможливий: невірний пароль";
                    throw new AutenticationException(errMessage);
                }
            }
            return isAuthenticated;
        }
    }

    /// <summary>
    /// Ошибки аутентификации
    /// </summary>
    public class AutenticationException : Exception
    {
        public AutenticationException(string message)
            : base(message)
        {
        }

        public AutenticationException(string message, Exception ex)
            : base(message, ex)
        {
        }
    }
    /// <summary>
    /// Срок действия истек
    /// </summary>
    public class AutenticationPasswordExpireException : AutenticationException
    {
        public AutenticationPasswordExpireException(string message)
            : base(message)
        {
        }

        public AutenticationPasswordExpireException(string message, System.Exception ex)
            : base(message, ex)
        {
        }
    }


    public interface IAccountRepository
    {
        /// <summary>
        /// авторизація по логіну і паролю
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        AuthorizedStatus Authorize(string userName, string password);
        /// <summary>
        /// авторизація по логіну і хешу пароля
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="hashPass"></param>
        /// <returns></returns>
        AuthorizedStatus AuthorizeByHash(string userName, string hashPass);
        /// <summary>
        /// Авторизація користувача по логіну
        /// </summary>
        /// <param name="userName">Логін</param>
        /// <returns>Статус авторизації</returns>
        AuthorizedStatusCode LoginUser(string userName);
        /// <summary>
        /// Авторизація користувача по Ідентифікотору
        /// </summary>
        /// <param name="userId">Ідентифікатор</param>
        /// <returns>Статус авторизації</returns>
        AuthorizedStatusCode LoginUser(decimal userId);
        /// <summary>
        /// Авторизація користувача в базі
        /// </summary>
        /// <param name="userId">Ідентифікатор</param>
        /// <returns>Статус авторизації</returns>
        AuthorizedStatusCode BaseLoginUser(decimal userId);
        /// <summary>
        /// Список відкритих банківських днів
        /// </summary>
        /// <param name="currentMonth">поточний місяць</param>
        /// <returns></returns>
        List<DateTime> GetOpenBankDates(DateTime currentMonth);
        /// <summary>
        /// Змінити банківську дату для користувача 
        /// </summary>
        /// <param name="date">Вибрана дата</param>
        void ChangeUserBankDate(DateTime date);

        /// <summary>
        /// Ім"я WEB-сервера
        /// </summary>
        /// <returns></returns>
        string GetHostName();
        /// <summary>
        /// Очистка темпових дерикторій
        /// </summary>
        void ClearSessionTmpDir();
        /// <summary>
        /// Видалити авторизаційнні данеі користувача
        /// </summary>
        void LogOutUser();
    }

}
