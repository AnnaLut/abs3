using System;
using barsroot.core;
using System.Collections;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Bars.Application;
using Bars.Exception;

namespace barsweb
{
    /// <summary>
    /// Summary description for ChangePsw.
    /// </summary>
    public partial class ChangePsw : Bars.BarsPage
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                btChangePsw.Attributes["onclick"] = "return Validate()";
                string pswMinLength = Bars.Configuration.ConfigurationSettings.AppSettings["CustomAuthentication.Password.MinLength"];
                string pswMaxSeq = Bars.Configuration.ConfigurationSettings.AppSettings["CustomAuthentication.Password.MaxSeq"];
                string initPassword = Bars.Configuration.ConfigurationSettings.AppSettings["CustomAuthentication.InitPassword.Hash"];
                string sysUser = "";
                if (Context.User.Identity.Name != string.Empty)
                    sysUser = (Context.User.Identity.Name.IndexOf('\\') > 0) ? (Context.User.Identity.Name.Substring(Context.User.Identity.Name.IndexOf('\\') + 1)) : (Context.User.Identity.Name);
                __pswMinLength.Value = pswMinLength;
                __pswMaxSeq.Value = pswMaxSeq;
                __sysUser.Value = sysUser;
                __InitPassword.Value = initPassword;
                txtPasswordNew.Attributes["onkeyup"] = "EvalPwdStrength(this)";
                txtPasswordNew.Attributes["onkeydown"] = "pressEnter()";
                txtPasswordNew.Attributes["onfocusin"] = "InitAddPolicyParam(document.all.txtUserName,document.all.txtPasswordOld)";
                txtUserName.Attributes["onfocusin"] = "focusOut()";
                txtPasswordOld.Attributes["onfocusin"] = "focusOut()";
                txtUserName.Text = Request.Params.Get("name");
                if (string.Empty != txtUserName.Text)
                    txtUserName.Enabled = false;
            }
        }

        #region Web Form Designer generated code
        override protected void OnInit(EventArgs e)
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

        private string GetHostName()
        {
            string userHost = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

            if (String.IsNullOrEmpty(userHost) || String.Compare(userHost, "unknown", true) == 0)
                userHost = Request.UserHostAddress;

            if (String.Compare(userHost, Request.UserHostName) != 0)
                userHost += " (" + Request.UserHostName + ")";

            return userHost;
        }

        protected void btChangePsw_Click(object sender, EventArgs e)
        {
            bool isAuthenticated = false;
            string userName = this.txtUserName.Text.Trim().ToLower();
            if (userName != string.Empty && this.txtPasswordOld.Text.Trim() != string.Empty)
            {
                try
                {
                    isAuthenticated = CustomAuthentication.AuthenticateUser(userName, txtPasswordOld_encrypt.Value, false);
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
                        lbMessage.Text = ex.Message;
                        lbMessage.Visible = true;
                        return;
                    }
                }
            }
            if (isAuthenticated)
            {
                Bars.Configuration.ConfigurationSettings.ChangePassword(userName, txtPasswordNew_encrypt.Value);
                if (!canUserChangeDate(userName))
                    CustomAuthentication.RedirectFromLoginPage((CustomIdentity)Session["userIdentity"]);
            }
            else
            {
                lbMessage.Text = "Невірний старий пароль.";
                lbMessage.Visible = true;
            }
        }

        private bool canUserChangeDate(string userName)
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
            finally
            {
                DisposeOraConnection();
            }
            // Если выполнили установку параметров
            Session["UserLoggedIn"] = true;

            // Проверка на возможность работы с несколькоми банковскими днями
            if (userMap.change_date == "Y")
            {
                Response.Redirect("/barsroot/barsweb/loginpage.aspx?changedate=on");
                return true;
            }
            return false;
        }

        private bool IsAuthenticated(string user, string psw)
        {
            string psw_real = Bars.Configuration.ConfigurationSettings.GetUserInfo(user).webpass;
            if (psw_real == string.Empty)
                psw_real = Bars.Configuration.ConfigurationSettings.GetUserInfo(user).adminpass;
            if (psw_real != psw)
                return false;
            else
                return true;
        }
    }
}
