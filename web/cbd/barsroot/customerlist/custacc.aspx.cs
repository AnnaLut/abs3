using System;
namespace CustomerList
{
    public partial class AccountsList : Bars.BarsPage
    {
        private void Page_Load(object sender, EventArgs e)
        {
            if (Request.Params.Get("type") == null)
                throw new Exception("Не задан параметр type!");
            decimal type = Convert.ToDecimal(Request.Params.Get("type"));

            if (type != 0 && type != 1 && type != 2 && type != 3 && type != 4)
                throw new Exception("Недопустимое значение параметра");

            if (type == 3 && Request.Params.Get("nd") == null)
                throw new Exception("Не задан параметр nd!");
            if (type == 0 && Request.Params.Get("rnk") == null)
                throw new Exception("Не задан параметр rnk!");
            if (type == 4 && Request.Params.Get("acc") == null)
                throw new Exception("Не задан параметр acc!");

            if (!IsPostBack)
            {
                try
                {
                    InitOraConnection();
                    if (Request["type"] == "1")
                    {
                        ddWhereClause.DataSource = SQL_SELECT_dataset("select where_clause, name_clause from web_where_clause").Tables[0];
                        ddWhereClause.DataTextField = "NAME_CLAUSE";
                        ddWhereClause.DataValueField = "WHERE_CLAUSE";
                        ddWhereClause.DataBind();
                        tdSaldo.Visible = true;
                        lbFilterDD.Text = "Умова відбору:";
                    }
                    else if (Request["type"] == "2")
                    {
                        ddBranches.DataSource = SQL_SELECT_dataset("select branch, name from branch where branch like sys_context('bars_context','user_branch_mask') and date_closed is null").Tables[0];
                        ddBranches.DataTextField = "NAME";
                        ddBranches.DataValueField = "BRANCH";
                        ddBranches.DataBind();
                        string curr_branch = Convert.ToString(SQL_SELECT_scalar("select sys_context('bars_context','user_branch') from dual"));
                        ddBranches.SelectedValue = curr_branch;
                        tdBranch.Visible = true;
                        lbFilterDD.Text = "Відділення:";
                    }
                    
                }
                finally
                {
                    DisposeOraConnection();
                }
            }
            (new Bars.Configuration.ModuleSettings()).JsSettingsBlockRegister(this);
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
            this.Load += new System.EventHandler(this.Page_Load);

        }
        #endregion

    }
}
