#define SBER

using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Configuration;
using Bars.Oracle;
using Oracle.DataAccess.Client;


namespace bars.web
{


    /// <summary>
    /// Заголовок страницы
    /// </summary>
    public partial class head : Bars.BarsPage
    {
        protected void Page_Load(object sender, System.EventArgs e)
        {
            if (!IsPostBack)
            {
                InitHeader();
                EDocsActive.Value = ConfigurationSettings.AppSettings.Get("Custom.EDocs.Active");
                EDocsTimeOut.Value = ConfigurationSettings.AppSettings.Get("Custom.EDocs.TimeOut");
                hCustomAuthentication.Value = ConfigurationSettings.AppSettings.Get("CustomAuthentication");
                hCookieName.Value = ConfigurationSettings.AppSettings.Get("CustomAuthentication.Cookie.Name");
                //Время в сек. опроса веб-сервиса в header
                string globalTimeout = (string.IsNullOrEmpty(ConfigurationSettings.AppSettings.Get("Global.TimeOut"))) ? ("30") : (ConfigurationSettings.AppSettings.Get("Global.TimeOut"));
                ClientScript.RegisterHiddenField("hGlobalTimeout", globalTimeout);
            }
        }

        private void InitHeader()
        {
            bool secEnabled = (ConfigurationSettings.AppSettings.Get("CustomAuthentication") == "On") ? (true) : (false);
            bool nbuSecEnabled = (ConfigurationSettings.AppSettings.Get("CustomAuthentication.AuthNbu") == "On") ? (true) : (false);
            if (!secEnabled || nbuSecEnabled)
                lnExitSystem.Visible = false;

            Boolean bDelimNeed = false;

            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection(Context);

            try
            {
                // устанавливаем роль
                OracleCommand command = new OracleCommand();
                command.Connection = connect;

                OracleDataReader reader = null;

                command.CommandText = conn.GetSetRoleCommand("basic_info");
                command.ExecuteNonQuery();

                //Робота с архивной схемой
                command.CommandText = "SELECT VAL FROM PARAMS WHERE PAR='USEHIST'";
                string useHist = Convert.ToString(command.ExecuteScalar());
                string useArc = string.Empty;
                string currSchema = "BARS";
                if (useHist == "1")
                {
                    command.CommandText = "SELECT usearc,cschema FROM staff WHERE logname = sys_context('userenv', 'session_user')";
                    reader = command.ExecuteReader();
                    if (reader.Read())
                    {
                        useArc = Convert.ToString(reader.GetValue(0));
                        currSchema = Convert.ToString(reader.GetValue(1));
                    }
                }

                tdProductTitle.InnerHtml = ConfigurationSettings.AppSettings["Product.Title"];

                //Проверяем глобальные параметры
                command.CommandText = "SELECT VAL FROM PARAMS WHERE PAR='W_HTOBO'";
                string htobo = Convert.ToString(command.ExecuteScalar());

                if (htobo == "1")
                {
                    ed_Tobo.Visible = false;
                    imgTobo.Visible = false;
                    textLogin.Width = 200;
                }
                //Прятать кнопку выбора отделения
                command.CommandText = "SELECT VAL FROM PARAMS WHERE PAR='W_HTBCH'";
                string htoboch = Convert.ToString(command.ExecuteScalar());

                if (htoboch == "1")
                {
                    imgTobo.Visible = false;
                }

                command.CommandText = @"SELECT	CODEOPER, 
												FUNCNAME,
												' ',
												SEMANTIC,
												OPERNAME, 
												'main' 
										FROM v_operapp 
										WHERE CODEAPP = 'WTOP' and runable <>3 
										ORDER BY CODEOPER";
                /*@"select codeoper, navurl, imgurl, text, tooltip, targetframe 
                from web_toplink where pos >= 0  order by pos";*/
                reader = command.ExecuteReader();
                while (reader.Read())
                {
                    HyperLink link = new HyperLink();
                    if (bDelimNeed)
                    {
                        // добавляем разделитель
                        ToolBar.Controls.Add(new LiteralControl("&nbsp<span style=\"margin-left:4;background-color:#848284;width:1px\" ></span><span  style=\"background-color:#ffffff;width:1px\"></span>&nbsp"));
                    }
                    else
                        bDelimNeed = true;

                    // создаем кнопку на toolbar
                    link.ID = Convert.ToString(reader.GetValue(0));
                    link.NavigateUrl = "#";//reader.GetString(1);
                    link.Text = reader.GetString(3);
                    link.ToolTip = reader.GetString(4);
                    //link.Target = reader.GetString(5);
                    link.Style.Add("FONT-WEIGHT", "bold");
                    link.Style.Add("FONT-SIZE", "10pt");
                    link.Style.Add("COLOR", "gray");
                    link.Style.Add("FONT-FAMILY", "Arial");
                    link.Style.Add("HEIGHT", "8px");
                    link.Style.Add("TEXT-DECORATION", "none");
                    link.Attributes.Add("onmousemove", "window.status=this.title");
                    link.Attributes.Add("onmouseleave", "window.status=''");
                    link.Attributes.Add("onclick", "go('" + reader.GetString(1) + "')");
                    // добавляем кнопку
                    ToolBar.Controls.Add(link);

                }

                reader.Close();

                if (bDelimNeed)
                {
                    // добавляем разделитель
                    ToolBar.Controls.Add(new LiteralControl("&nbsp<span style=\"margin-left:4;background-color:#848284;width:1px\" ></span><span  style=\"background-color:#ffffff;width:1px\"></span>&nbsp"));
                }


                if (ConfigurationSettings.AppSettings.Get("Localization.Mode") == "On")
                {
                    // добавляем строку настроек
                    HyperLink linkOptions = new HyperLink();
                    // создаем кнопку на toolbar
                    linkOptions.ID = "linkOptions";
                    linkOptions.NavigateUrl = "#";//reader.GetString(1);
                    linkOptions.Text = Resources.barsweb.GlobalResources.optionButton;//"Настройки";
                    linkOptions.ToolTip = Resources.barsweb.GlobalResources.optionToolTip;//"Здесь вы можете отредактировать параметры вашего профиля";
                    linkOptions.Style.Add("FONT-WEIGHT", "bold");
                    linkOptions.Style.Add("FONT-SIZE", "10pt");
                    linkOptions.Style.Add("COLOR", "gray");
                    linkOptions.Style.Add("FONT-FAMILY", "Arial");
                    linkOptions.Style.Add("HEIGHT", "8px");
                    linkOptions.Style.Add("TEXT-DECORATION", "none");
                    linkOptions.Attributes.Add("onmousemove", "window.status=this.title");
                    linkOptions.Attributes.Add("onmouseleave", "window.status=''");
                    linkOptions.Attributes.Add("onclick", "showOptions()");
                    // добавляем кнопку
                    ToolBar.Controls.Add(linkOptions);
                }
                if (useArc == "1")
                {
                    DropDownList ddCScheme = new DropDownList();
                    ddCScheme.ID = "ddCScheme";

                    ddCScheme.Items.Add(new ListItem(Resources.barsweb.GlobalResources.SchemaWork, "BARS"));
                    ddCScheme.Items.Add(new ListItem(Resources.barsweb.GlobalResources.SchemaHist, "HIST"));
                    
                    ddCScheme.CssClass = "headTextBox";
                    ddCScheme.Style.Add("font-weight", "bold");
                    ddCScheme.Attributes.Add("onchange", "ChangeSchema()");
                    ddCScheme.SelectedValue = currSchema;

                    Label lbCScheme = new Label();
                    lbCScheme.Text = Resources.barsweb.GlobalResources.SchemaName;
                    
                    lbCScheme.CssClass = "headTitle";
                    ToolBar.Controls.Add(lbCScheme);
                    ToolBar.Controls.Add(new LiteralControl("&nbsp"));
                    ToolBar.Controls.Add(ddCScheme);
                }

                // вычитываем имя пользователя, банковскую дату, код отделения
                string strBranch = string.Empty;
                command.CommandText = @"select web_utl.get_user_fullname,  
							TO_CHAR(web_utl.get_bankdate,'dd.MM.yyyy'), tobopack.gettobo, tobopack.gettoboname from dual";
                reader = command.ExecuteReader();
                reader.Read();
                textLogin.Text = Convert.ToString(reader.GetValue(0));

                textBankDate.Text = Convert.ToString(reader.GetValue(1));

                strBranch = Convert.ToString(reader.GetValue(2));
                ed_Tobo.Text = Convert.ToString(reader.GetValue(3));
                
                reader.Close();
                reader.Dispose();

                // Допустимие отделения - можно представлятся
                bool canSelectBranch = false;
                command.CommandText = "select count(column_name) from all_tab_cols where owner = 'BARS' and table_name = 'STAFF$BASE' and column_name = 'CAN_SELECT_BRANCH'";
                if (Convert.ToInt16(command.ExecuteScalar()) > 0)
                {
                    command.CommandText = "select can_select_branch from staff$base where id=user_id";
                    canSelectBranch = "Y" == Convert.ToString(command.ExecuteScalar());

                    if (canSelectBranch)
                    {
                        tdUserBranches.Visible = true;
                        OracleDataAdapter adapter = new OracleDataAdapter(command);
                        command.CommandText = "select branch, name from v_user_branches";
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);

                        ddUserBranches.DataSource = dt;
                        ddUserBranches.DataBind();
                        ddUserBranches.SelectedValue = strBranch;

                        adapter.Dispose();
                    }
                }
            }
            finally
            {
                connect.Close();
                connect.Dispose();
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

        protected void lnExitSystem_Click(object sender, EventArgs e)
        {
            if (Bars.Configuration.ConfigurationSettings.AppSettings["CustomAuthentication.UseSession"] == "On")
                Session.Abandon();
            else
            {
                string port = (Request.ServerVariables["SERVER_PORT"] == "80") ? ("") : (Request.ServerVariables["SERVER_PORT"]);
                string cookieName = Bars.Configuration.ConfigurationSettings.AppSettings["CustomAuthentication.Cookie.Name"] + port;
                HttpCookie cookie = Request.Cookies[cookieName.ToUpper()];
                cookie.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(cookie);
            }
            Response.Write("<script language=javascript>parent.location.reload();</script>");
        }
        protected void ddUserBranches_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                InitOraConnection();
                SetParameters("p_branch", DB_TYPE.Varchar2, ddUserBranches.SelectedValue, DIRECTION.Input);
                SQL_PROCEDURE("bc.select_branch");
            }
            finally
            {
                DisposeOraConnection();
            }
            Response.Write("<script language=javascript>parent.location.reload();</script>");
        }
}
}
