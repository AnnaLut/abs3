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


public partial class finmon_refcustomers : Bars.BarsPage
{
    private void FillData()
    {
        odsRefCustomers.DataBind();
        gvRefCustomers.DataBind();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        gvRefCustomers.ShowFooter = false;
        gvRefCustomers.ShowPageSizeBox = false;

        FillGrid();
    }

    private void FillGrid()
    {

        odsRefCustomers.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        odsRefCustomers.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("");
        odsRefCustomers.SelectParameters.Clear();
        odsRefCustomers.WhereParameters.Clear();

        String selectCommand = "select * from V_CUSTOMER_FM where okpo is not null ";

        if (String.IsNullOrEmpty(tbRNK.Text) && String.IsNullOrEmpty(tbOKPO.Text))
        {
            selectCommand += " order by rnk desc";
        }
        else if (null != tbRNK.Text && String.IsNullOrEmpty(tbOKPO.Text))
        {
            selectCommand += " and to_char(rnk) = " + tbRNK.Text + " order by rnk desc";
        }
        else if (String.IsNullOrEmpty(tbRNK.Text) && null != tbOKPO.Text)
        {
            selectCommand += " and to_char(okpo) = " + tbOKPO.Text + " order by rnk desc";
        }
        else if (null != tbRNK.Text && null != tbOKPO.Text)
        {
            selectCommand += " and to_char(rnk) = " + tbRNK.Text + " and to_char(okpo) = " + tbOKPO.Text + " order by rnk desc";
        }
        odsRefCustomers.SelectCommand = selectCommand;
    }

    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }

    protected void btSearch_Click(object sender, EventArgs e)
    {
        FillGrid();
        FillData();

    }

    protected void btOK_Click(object sender, EventArgs e)
    {
        if (gvRefCustomers.SelectedRows.Count != 0)
        {
            string rnk = gvRefCustomers.DataKeys[gvRefCustomers.SelectedRows[0]]["RNK"].ToString();
            string okpo = gvRefCustomers.DataKeys[gvRefCustomers.SelectedRows[0]]["OKPO"].ToString();
            string nmk = gvRefCustomers.DataKeys[gvRefCustomers.SelectedRows[0]]["NMK"].ToString();
                     
            ScriptManager.RegisterStartupScript(this, this.GetType(), "close_dialog", "Close('" + rnk + "','" + okpo + "','" + nmk + "');", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "no_row_selected", "NoRows();", true);
        }
    }
    protected void btCancel_Click(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "close_dialog", "Close(-1,-1,-1);", true);
    }
}