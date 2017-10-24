using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Oracle.DataAccess.Client;
using System.Data;
using Bars.Classes;
using Bars.Oracle;
using Oracle.DataAccess.Types;
using System.Globalization;
using Bars.UserControls;
using Bars.Oracle;
using Bars.Classes;
using System.Web.Services;


public partial class dwh_references : Bars.BarsPage
{
    private void FillData()
    {
        odsDwhRef.DataBind();
        gvDwhRef.DataBind();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        gvDwhRef.ShowFooter = false;
        gvDwhRef.ShowPageSizeBox = false;
 
        if (IsPostBack)
        {
            FillGrid();
        }
		if (!IsPostBack)
        {
        btSearch_Click(null,null);
		}
    }

    private void FillGrid()
    {

        odsDwhRef.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        odsDwhRef.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("");
        odsDwhRef.SelectParameters.Clear();
        odsDwhRef.WhereParameters.Clear();

        string view_name = Request["p_view"];
        String selectCommand = @"select r.id, r.name from " + view_name +" r";

        if (String.IsNullOrEmpty(tbId.Text) && String.IsNullOrEmpty(tbName.Text))
        {
            selectCommand += " order by r.id";
        }
        else if (null != tbId.Text && String.IsNullOrEmpty(tbName.Text))
        {
            selectCommand += " where r.id like '" + tbId.Text + "%' order by r.id";
        }
        else if (String.IsNullOrEmpty(tbId.Text) && null != tbName.Text)
        {
            selectCommand += " where upper(r.name) like upper('%" + tbName.Text + "%') ')) order by r.id";
        }
        else if (null != tbId.Text && null != tbName.Text)
        {
            selectCommand += " where r.id = '" + tbId.Text + "' and upper(r.name) like upper('%" + tbName.Text + "%') ) order by r.id";
        }

        odsDwhRef.SelectCommand = selectCommand;

    }

    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }

    protected void btSearch_Click(object sender, EventArgs e)
    {
        pnDwhRef.Visible = true;
        FillGrid();
        FillData();
    }

    protected void btOK_Click(object sender, EventArgs e)
    {
        if (gvDwhRef.SelectedRows.Count != 0)
        {
            string ID = gvDwhRef.DataKeys[gvDwhRef.SelectedRows[0]]["ID"].ToString();
            string NAME = gvDwhRef.DataKeys[gvDwhRef.SelectedRows[0]]["NAME"].ToString();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "close_dialog", "Close('" + ID + "','" + NAME + "');", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "no_row_selected", "NoRows();", true);
        }
    }
    protected void btCancel_Click(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "close_dialog", "Close(-1);", true);
    }
}