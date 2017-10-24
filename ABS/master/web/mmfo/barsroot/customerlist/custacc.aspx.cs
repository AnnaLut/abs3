using System;
using System.Web.UI;

namespace CustomerList
{
    public partial class AccountsList : Bars.BarsPage
    {
        private void Page_Load(object sender, EventArgs e)
        {
            if (Request.Params.Get("type") == null)
                throw new Exception("Не задан параметр type!");
            decimal type = Convert.ToDecimal(Request.Params.Get("type"));

            if (type != 0 && type != 1 && type != 2 && type != 3 && type != 4 && type != 5 && type != 6 && type != 7 && type != 8 && type != 9 && type != 10 && type != 11)
                throw new Exception("Недопустимое значение параметра type");

            if (type == 3 && Request.Params.Get("nd") == null)
                throw new Exception("Не задан параметр nd!");
            if (type == 0 && Request.Params.Get("rnk") == null)
                throw new Exception("Не задан параметр rnk!");
            if (type == 4 && Request.Params.Get("acc") == null)
                throw new Exception("Не задан параметр acc!");
            if (type == 5 && Request.Params.Get("bpkw4nd") == null)
                throw new Exception("Не задан параметр bpkw4nd!");
            if (type == 9 && Request.Params.Get("cp_ref") == null)
                throw new Exception("Не задан параметр cp_ref!");
            if (type == 10 && Request.Params.Get("e_deal_nd") == null)
                throw new Exception("Не задан параметр e_deal_nd!");
            if (type == 11 && Request.Params.Get("premium_banking") == null)
                throw new Exception("Не задан параметр premium_banking!");

            if (!IsPostBack)
            {
                try
                {
                    InitOraConnection();
                    if (Request["type"] == "1")
                    {
                        ddWhereClause.DataSource = SQL_SELECT_dataset("select where_clause, name_clause from web_where_clause where type_clause = 2").Tables[0];
                        ddWhereClause.DataTextField = "NAME_CLAUSE";
                        ddWhereClause.DataValueField = "WHERE_CLAUSE";
                        ddWhereClause.DataBind();
                        tdSaldo.Visible = true;
                        lbFilterDD.Text = "Умова відбору:";
                    }
                    else if (Request["type"] == "2")
                    {
                        ddBranches.DataSource = SQL_SELECT_dataset("select branch, name from branch where branch like sys_context('bars_context','user_branch_mask') and date_closed is null order by branch asc").Tables[0];
                        ddBranches.DataTextField = "NAME";
                        ddBranches.DataValueField = "BRANCH";
                        ddBranches.DataBind();
                        string curr_branch = Convert.ToString(SQL_SELECT_scalar("select sys_context('bars_context','user_branch') from dual"));
                        ddBranches.SelectedValue = curr_branch;
                        ddBranches.Visible = true;
                        lbFilterDD.Text = "Відділення:";
                    }
                    else if (Request["type"] == "5")
                    {
                        ddWhereClause.DataSource = SQL_SELECT_dataset("select where_clause, name_clause from web_where_clause where id_clause = 'bpk_w4_nd' ").Tables[0];
                        ddWhereClause.DataTextField = "NAME_CLAUSE";
                        ddWhereClause.DataValueField = "WHERE_CLAUSE";
                        ddWhereClause.DataBind();
                        tdSaldo.Visible = true;
                        lbFilterDD.Text = "Умова відбору:";
                    }
                    else if (Request["type"] == "8")
                    {
                        pnSearsh.GroupingText = String.Format("Обороти за період з {0} по {1}", Request["Dat1"], Request["Dat2"]);
                    }
                    else if (Request["type"] == "9")
                    {
                        ddWhereClause.DataSource = SQL_SELECT_dataset("select where_clause, name_clause from web_where_clause where id_clause = 'cp_ref' ").Tables[0];
                        ddWhereClause.DataTextField = "NAME_CLAUSE";
                        ddWhereClause.DataValueField = "WHERE_CLAUSE";
                        ddWhereClause.DataBind();
                        tdSaldo.Visible = true;
                        lbFilterDD.Text = "Умова відбору:";
                    }
                    else if (Request["type"] == "10")
                    {
                        ddWhereClause.DataSource = SQL_SELECT_dataset("select where_clause, name_clause from web_where_clause where id_clause = 'e_deal_nd' ").Tables[0];
                        ddWhereClause.DataTextField = "NAME_CLAUSE";
                        ddWhereClause.DataValueField = "WHERE_CLAUSE";
                        ddWhereClause.DataBind();
                        tdSaldo.Visible = true;
                        lbFilterDD.Text = "Умова відбору:";
                    }
                    else if (Request["type"] == "11")
                    {
                        ddWhereClause.DataSource = SQL_SELECT_dataset("select where_clause, name_clause from web_where_clause where id_clause = 'premium_banking' ").Tables[0];
                        ddWhereClause.DataTextField = "NAME_CLAUSE";
                        ddWhereClause.DataValueField = "WHERE_CLAUSE";
                        ddWhereClause.DataBind();
                        tdSaldo.Visible = true;
                        lbFilterDD.Text = "Умова відбору:";
                    }

                    if (Request.Params.Get("acc") != null)
                    {
                        string acc = Convert.ToString(Request.Params.Get("acc"));
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "document", "setNls('" + acc + "');", true);

                    }

                    if (null != Request.QueryString.Get("acc") && null == Request.QueryString.Get("nls") && 2 == type)
                    {
                        tbFindNls.Value = Request.QueryString.Get("acc");
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
