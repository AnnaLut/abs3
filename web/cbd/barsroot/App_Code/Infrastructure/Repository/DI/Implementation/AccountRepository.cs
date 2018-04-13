using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using Bars.Application;
using Bars.Configuration;
using Bars.Exception;
using barsroot;
using barsroot.core;
using BarsWeb.Models;
using Models;
using Oracle.DataAccess.Client;
using BarsWeb.Infrastructure.Repository.DI.Abstract;

namespace BarsWeb.Infrastructure.Repository.DI.Implementation
{
    /// <summary>
    /// Summary description for AccountRepository
    /// </summary>
    public class AccountRepository : IAccountRepository
    {
        readonly EntitiesBars _entities;

        public AccountRepository(IAppModel model)
        {
            _entities = model.Entities;
        }

        public AuthorizedStatus Authorize(string userName, string password)
        {
            password = CustomEncryption.GetSHA1Hash(password);
            return AuthorizeByHash(userName, password);
        }

        public AuthorizedStatus AuthorizeByHash(string userName, string hashPass)
        {
            var result = new AuthorizedStatus();
            bool isAuthenticated;
            try
            {
                isAuthenticated = CustomAuthentication.AuthenticateUser(userName, hashPass, false);
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
            UserMap userMap = ConfigurationSettings.GetUserInfo(userName);
            var result = BaseLoginUser(Convert.ToDecimal(userMap.user_id));
            // Проверка на возможность работы с несколькоми банковскими днями
            if (result == AuthorizedStatusCode.Error && userMap.change_date != "Y")
            {
                HttpContext.Current.Session.Abandon();
                return result;
            }
            if (userMap.change_date == "Y")
            {
                result = AuthorizedStatusCode.SelectDate;
            }
            // Если выполнили установку параметров
            HttpContext.Current.Session["UserLoggedIn"] = true;
            HttpContext.Current.Session[Constants.UserId] = userMap.user_id;
            Bars.Logger.DBLogger.Info(string.Format("Веб-користувач [ {0} ] розпочав роботу в глобальній банківській даті - {1}",
                                                    userName, 
                                                    userMap.bank_date.ToString("dd.MM.yyyy")));

            return result;
        }

        public AuthorizedStatusCode LoginUser(decimal userId)
        {
            var result = BaseLoginUser(userId);
            // Если выполнили установку параметров
            HttpContext.Current.Session["UserLoggedIn"] = true;
            HttpContext.Current.Session[Constants.UserId] = userId;
            Bars.Logger.DBLogger.Info(string.Format("Користувач [ {0} ] розпочав роботу з веб додатком",userId));
            return result;
        }

        public AuthorizedStatusCode BaseLoginUser(decimal userId)
        {
            var barsPage = new Bars.BarsPage();
            try
            {
                barsPage.InitOraConnection();
                // установка первичных параметров
                barsPage.SetParameters("p_session_id", Bars.BarsPage.DB_TYPE.Varchar2, HttpContext.Current.Session.SessionID, Bars.BarsPage.DIRECTION.Input);
                barsPage.SetParameters("p_user_id", Bars.BarsPage.DB_TYPE.Varchar2, Convert.ToString(userId), Bars.BarsPage.DIRECTION.Input);
                barsPage.SetParameters("p_hostname", Bars.BarsPage.DB_TYPE.Varchar2, GetHostName(), Bars.BarsPage.DIRECTION.Input);
                barsPage.SetParameters("p_appname", Bars.BarsPage.DB_TYPE.Varchar2, "barsroot", Bars.BarsPage.DIRECTION.Input);
                barsPage.SQL_PROCEDURE("bars.bars_login.login_user");
            }
            catch (OracleException ex)
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
            finally
            {
                barsPage.DisposeOraConnection();
            }
            return AuthorizedStatusCode.Ok;
        }

        public List<DateTime> GetOpenBankDates(DateTime currentMonth)
        {
            object[] parameters =
                {
                    new OracleParameter("p_dstart", OracleDbType.Date).Value = currentMonth.AddDays(-1),
                    new OracleParameter("p_dend", OracleDbType.Date).Value =
                        currentMonth.AddDays(DateTime.DaysInMonth(currentMonth.Year, currentMonth.Month))
                };
            const string sql = "SELECT fdat FROM bars.v_open_bankdates where fdat > :p_dstart and fdat <:p_dend";
            var openBankDates = _entities.ExecuteStoreQuery<DateTime>(sql, parameters).ToList();
            return openBankDates;
        }

        public void ChangeUserBankDate(DateTime date)
        {
            object[] parameters =
                {
                    new OracleParameter("p_ldate", OracleDbType.Date).Value = date
                };
            _entities.ExecuteStoreCommand("begin bars.bars_login.set_user_bankdate(:p_ldate); end;", parameters);
        }

        public List<V_SEC_AUDIT_UI> GetUserSecAudit(decimal pageNum, decimal pageSize)
        {
            string sqlText = ServicesClass.GetSelectStryng(
                                typeSeach: "V_SEC_AUDIT_UI",
                                filterString: "",
                                sort: "rec_id",
                                sortDir: "desc",
                                pageNum: Convert.ToInt32(pageNum),
                                pageSize: Convert.ToInt32(pageSize));

            var audit = _entities.ExecuteStoreQuery<V_SEC_AUDIT_UI>(sqlText).ToList();
            return audit;
        }

        public decimal GetCountUserSecAudit()
        {
            return _entities.ExecuteStoreQuery<decimal>("select count(*) from V_SEC_AUDIT_UI").FirstOrDefault();
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

        public void SetUserError(string stack)
        {
            object[] parameters =
            {
                new OracleParameter("p_stack",OracleDbType.Varchar2).Value = stack
            };
            _entities.ExecuteStoreCommand("begin bars_audit.error(:p_stack);end;", parameters);
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
    }

}
