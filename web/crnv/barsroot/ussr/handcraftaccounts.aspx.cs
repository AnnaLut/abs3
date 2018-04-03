using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Bars.Classes;

public partial class ussr_handcraftaccounts : Bars.BarsPage
{
    private string sRole = "WR_USSR_TECH";
    protected override void  OnInit(EventArgs e)
    {
        base.OnInit(e);
        
        ds.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand(sRole);
        ds.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
    }
    protected void Page_Load(object sender, EventArgs e)
    {
       /* if (!IsPostBack)
        {
            DataTable dtBranch = new DataTable();

            InitOraConnection();
            try
            {
                SetRole(sRole);
                dtBranch = SQL_SELECT_dataset("select BRANCH as VALUE, BRANCH || ' - ' || NAME as TEXT from branch order by branch").Tables[0];
            }
            finally
            {
                DisposeOraConnection();
            }

            // наполняем бранчи
            ddlBranch.DataSource = dtBranch;
            ddlBranch.DataValueField = "VALUE";
            ddlBranch.DataTextField = "TEXT";
            ddlBranch.DataBind();

            ddlBranch.SelectedIndex = 0;
        }*/
    }
    protected void btRefresh_Click(object sender, ImageClickEventArgs e)
    {
        // ничего не делаем
    }
    protected void gv_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EQUAL")
        {
            decimal nId = Convert.ToDecimal(e.CommandArgument);

            InitOraConnection();
            try
            {
                SetRole(sRole);

                ClearParameters();
                SetParameters("pid", DB_TYPE.Decimal, nId, DIRECTION.Input);
                SQL_NONQUERY("begin p_ussr_collation_equal_ost(:pid); end;");
            }
            finally
            {
                DisposeOraConnection();
            }
        }
    }
}
