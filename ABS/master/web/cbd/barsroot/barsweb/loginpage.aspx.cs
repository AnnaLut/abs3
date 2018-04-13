using System;
using System.Collections;
using System.Globalization;
using System.Runtime.InteropServices;
using System.Security.Cryptography;
using System.Text;
using System.Threading;
using System.Web;
using System.Web.UI.WebControls;
using Bars.Application;
using Bars.Configuration;
using Bars.Encryption;
using Bars.Exception;
using barsroot.core;

namespace barsroot.barsweb
{
    /// <summary>
    /// Summary description for LoginPage.
    /// </summary>
    public partial class LoginPage : Bars.BarsPage
    {
        //Импорт метода для определиения иденификатора, каким создан шлюз
        [DllImport("purelogin.dll", SetLastError = true)]
        public static extern int ResolveConnection(string szHost, int nPort, StringBuilder szKey, int nKeySize);

        //Установка метода трассировки (0-сообщения, 1-файл трассы)
        [DllImport("purelogin.dll", SetLastError = true)]
        public static extern void SetTraceMode(int nTraceMode);

        const int RESOLVE_LOCK = 1;
        const int RESOLVE_OK = 0;

        private int m_Port;
        private string m_hostAdress;
        private StringBuilder m_receivedKey = new StringBuilder("");
        private int m_Result;
        private bool m_methodDone;
        private Exception m_threadException;

        private void getUserSecurityKey()
        {
            try
            {
                if (Application["isSetTraceMode"] == null)
                {
                    SetTraceMode(2);
                    Application["isSetTraceMode"] = true;
                }

                TimeSpan ts_max = TimeSpan.FromSeconds(10);
                TimeSpan ts_start = DateTime.Now.TimeOfDay;
                TimeSpan ts_delta = TimeSpan.Zero;
                do
                {
                    m_Result = ResolveConnection(m_hostAdress, m_Port, m_receivedKey, 32);
                    if (RESOLVE_LOCK == m_Result)
                    {
                        Thread.Sleep(10);
                    }
                    ts_delta = DateTime.Now.TimeOfDay - ts_start;
                }
                while (RESOLVE_LOCK == m_Result && ts_delta < ts_max);

                if (RESOLVE_OK == m_Result)
                    m_methodDone = true;
            }
            catch (Exception ex)
            {
                m_threadException = ex;
            }
        }

        private void ShowLogin()
        {
            lnEnterSystem.Visible = true;
            btLogIn.Visible = true;
            txtUserName.Visible = true;
            txtPassword.Visible = true;
            lbUser.Visible = true;
            lbPsw.Visible = true;
            btNext.Visible = false;

            ClientScript.RegisterHiddenField("hDisPrnScr", ConfigurationSettings.AppSettings.Get("Security.DisablePrintScreen"));

            if (ConfigurationSettings.AppSettings.Get("CustomAuthentication.AuthNbu") == "On")
            {
                m_Port = Convert.ToInt32(Request.ServerVariables["REMOTE_PORT"]);
                m_hostAdress = Request.ServerVariables["LOCAL_ADDR"];
                m_methodDone = false;

                Thread thread = new Thread(new ThreadStart(getUserSecurityKey));
                thread.Start();
                thread.Join(30000);

                if (!m_methodDone)
                    throw new BarsException("Не вдалося виконати метод ResolveConnection. m_Result=" + m_Result.ToString(), m_threadException);
                if (m_Result != 0 || m_receivedKey.Length == 0)
                    throw new BarsException("Не вдалося визначити ідентифікатор ключа, яким створено з'єднання з сервером.");
                string userKey = Request.Params.Get("keySec");
                if (m_receivedKey.ToString() != userKey && !string.IsNullOrEmpty(userKey))
                    throw new BarsException("Не співпадає ідентифікатор ключа клієнта з ключем, яким створено з'єднання з сервером(" + m_receivedKey + "!=" + userKey + ").");
                if (!string.IsNullOrEmpty(m_receivedKey.ToString()))
                {
                    string userName = m_receivedKey.ToString().ToLower();
                    // Обновляем информацию об пользователе
                    ConfigurationSettings.RefreshUserInfo(userName);
                    if (ConfigurationSettings.UserMapSettings[userName] == null)
                        throw new BarsException("Користувача з іменем " + userName + " не знайдено. Зверніться до адміністратора.");

                    CustomIdentity userIdentity = new CustomIdentity(userName, 1, true, false, userName, "", "");
                    CustomPrincipal principal = new CustomPrincipal(userIdentity, new ArrayList());
                    Context.User = principal;
                    Session["userIdentity"] = userIdentity;
                    // Login
                    LoginUser(userName);
                }
                return;
            }

            btLogIn.Attributes["onclick"] = "return validateForm();";
            if (ConfigurationSettings.AppSettings.Get("CustomAuthentication.SecureValidation") == "On")
            {
                linkChangePsw.Visible = true;
            }

            // авто-логин по переданным параметрам в строке вызова
            string login = Convert.ToString(Session["AutoLogin.Login"]).ToLower();
            string password_hash = Convert.ToString(Session["AutoLogin.PasswordHash"]);
            string pageUrl = Convert.ToString(Session["AutoLogin.PageUrl"]);

            if (!string.IsNullOrEmpty(login) && !string.IsNullOrEmpty(password_hash))
            {
                if (!pageUrl.ToLower().Contains("barsweb/default.aspx"))
                {
                    HttpCookie cookie = new HttpCookie("lastUrl" + login);
                    cookie.Value = pageUrl;
                    Response.Cookies.Add(cookie);
                }
                TryLogin(login, password_hash);
            }
        }

        #region Web Form Designer generated code

        protected override void OnInit(EventArgs e)
        {
            //
            // CODEGEN: This call is required by the ASP.NET Web Form Designer.
            //
            InitializeComponent();
            base.OnInit(e);
        }

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
        }

        #endregion

        protected void btLogIn_Click(object sender, EventArgs e)
        {
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
                lbMessage.Text = "Помилка авторизації (" + ex.Message + ").";
                lbMessage.Visible = true;
                return;
            }

            TryLogin(userName, hashpsw);
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
                                       "location.replace('changepsw.aspx?name=" + txtUserName.Text + "&" + Request.QueryString +
                                       @"');	
                                     </script>");
                    return;
                }
                lbMessage.Text = ex.Message;
                lbMessage.Visible = true;
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

        private void LoginUser(string userName)
        {
            // информация о текущем пользователе
            UserMap userMap = Bars.Configuration.ConfigurationSettings.GetUserInfo(userName);

            try
            {
                InitOraConnection();
                // установка первичных параметров
                SetParameters("p_session_id", DB_TYPE.Varchar2, Session.SessionID, DIRECTION.Input);
                SetParameters("p_user_id", DB_TYPE.Varchar2, userMap.user_id, DIRECTION.Input);
                SetParameters("p_hostname", DB_TYPE.Varchar2, GetHostName(), DIRECTION.Input);
                SetParameters("p_appname", DB_TYPE.Varchar2, "barsroot", DIRECTION.Input);
                SQL_PROCEDURE("bars.bars_login.login_user");
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
                        lbMessage.Text = "Банківський день закрито.<br>Спробуйте перезайти в систему через деякий час.";
                        lbMessage.Visible = true;
                        return;
                    }
                }
                else
                    throw ex;
            }
            finally
            {
                DisposeOraConnection();
            }
            // Если выполнили установку параметров
            Session["UserLoggedIn"] = true;

            Bars.Logger.DBLogger.Info("Веб-користувач [" + userName + "] розпочав роботу в глобальній банківській даті - " + userMap.bank_date.ToString("dd.MM.yyyy"));

            // Проверка на возможность работы с несколькоми банковскими днями
            if (userMap.change_date == "Y")
            {
                ShowBankDates();
            }
            else
                CustomAuthentication.RedirectFromLoginPage((CustomIdentity)Session["userIdentity"]);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect( BarsWeb.Infrastructure.Constants.LoginPageUrl);
            /*
            if (!IsPostBack)
            {
                lbServer.Text = "Server : " + Server.MachineName + "(" + Request.ServerVariables["LOCAL_ADDR"] + ")";
                Page.GetPostBackEventReference(btLogIn);
                if (Request.Params["encdata"] != null)
                {
                    btLogIn_Click(sender, e);
                    return;
                }

                bool formsAuthEnabled = (ConfigurationSettings.AppSettings.Get("CustomAuthentication") == "On") ? (true) : (false);
                if (formsAuthEnabled && Request.Params.Get("changedate") != "on")
                    ShowLogin();
                else if (Request.Params.Get("changedate") == "on")
                    ShowBankDates();
            }
            else
            {
                if (!Calendar.Visible)
                    btLogIn_Click(sender, e);
            }*/
        }

        private void ShowBankDates()
        {
            lbSelectBankDate.Visible = true;
            Calendar.Visible = true;
            lnEnterSystem.Visible = false;
            btLogIn.Visible = false;
            txtUserName.Visible = false;
            txtPassword.Visible = false;
            lbUser.Visible = false;
            lbPsw.Visible = false;
            lbMessage.Visible = false;
            linkChangePsw.Visible = false;
            btNext.Visible = true;
            try
            {
                InitOraConnection();

                CultureInfo culture = new CultureInfo("en-GB", true);
                culture.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";

                string userName = Context.User.Identity.Name;
                UserMap userMap = Bars.Configuration.ConfigurationSettings.GetUserInfo(userName);

                DateTime bDate = userMap.bank_date;

                Calendar.TodaysDate = bDate;
                Calendar.VisibleDate = bDate.AddDays(-bDate.Day + 1);

                Calendar.SelectedDates.Clear();
                SQL_Reader_Exec("SELECT fdat FROM bars.v_open_bankdates");
                while (SQL_Reader_Read())
                {
                    ArrayList row = SQL_Reader_GetValues();
                    DateTime fDate = Convert.ToDateTime(row[0]);
                    //if (fDate < bDate)
                    //    continue;
                    Calendar.SelectedDates.Add(fDate);
                }
                SQL_Reader_Close();
            }
            finally
            {
                DisposeOraConnection();
            }
        }

        private bool IsAuthenticated(string user, string psw)
        {
            string psw_real = ConfigurationSettings.GetUserInfo(user).webpass;
            if (psw_real != psw)
                return false;
            else
                return true;
        }

        protected void Calendar_DayRender(object sender, DayRenderEventArgs e)
        {
            if (Calendar.TodaysDate == e.Day.Date)
                e.Cell.BackColor = System.Drawing.Color.LightGreen;
            if (!e.Day.IsSelected)
                e.Day.IsSelectable = false;
        }
        protected void Calendar_SelectionChanged(object sender, EventArgs e)
        {
            if (Session["userIdentity"] != null)
            {
                CustomPrincipal principal = new CustomPrincipal((CustomIdentity)Session["userIdentity"], new ArrayList());
                Context.User = principal;
            }
            try
            {
                InitOraConnection();

                // информация о текущем пользователе
                string userName = Context.User.Identity.Name;
                UserMap userMap = Bars.Configuration.ConfigurationSettings.GetUserInfo(userName);

                SetParameters("ldate", DB_TYPE.Date, Calendar.SelectedDate, DIRECTION.Input);
                SQL_PROCEDURE("bars.bars_login.set_user_bankdate");

                DateTime bDate = userMap.bank_date;
                if (Calendar.SelectedDate != userMap.bank_date)
                {
                    Session["LocalBDate"] = "1";
                }
                Bars.Logger.DBLogger.Info("Веб-користувач [" + userName + "] розпочав роботу в локальній банківській даті - " + Calendar.SelectedDate.ToString("dd.MM.yyyy"));
                if (Session["userIdentity"] != null && Request.Params.Get("changedate") != "on")
                {
                    CustomIdentity userIdentity = (CustomIdentity)Session["userIdentity"];
                    CustomAuthentication.RedirectFromLoginPage(userIdentity);
                }
                else
                    Response.Redirect("/barsroot/barsweb/default.aspx", false);

            }
            finally
            {
                DisposeOraConnection();
            }
        }
        protected void btNext_Click(object sender, EventArgs e)
        {
            Calendar.SelectedDate = Calendar.TodaysDate;
            Calendar_SelectionChanged(sender, e);
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