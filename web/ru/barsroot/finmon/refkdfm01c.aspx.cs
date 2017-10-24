﻿using System;
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


public partial class finmon_refkdfm01c : Bars.BarsPage
{
    private void FillData()
    {
        odsKdfm01c.DataBind();
        gvKdfm01c.DataBind();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        gvKdfm01c.ShowFooter = false;
        gvKdfm01c.ShowPageSizeBox = false;

        FillGrid();
    }

    private void FillGrid()
    {
        odsKdfm01c.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        odsKdfm01c.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("");
        odsKdfm01c.SelectParameters.Clear();
        odsKdfm01c.WhereParameters.Clear();

        String selectCommand = "select code,name from k_dfm01c where (d_close is null or d_close > sysdate)";

        if (String.IsNullOrEmpty(tbCode.Text) && String.IsNullOrEmpty(tbName.Text))
        {
            selectCommand += " order by code";
        }
        else if (null != tbCode.Text && String.IsNullOrEmpty(tbName.Text))
        {
            selectCommand += " and to_char(code) = '" + tbCode.Text + "' order by code";
        }
        else if (String.IsNullOrEmpty(tbCode.Text) && null != tbName.Text)
        {
            selectCommand += " and upper(name) like upper('%" + tbName.Text + "%') order by code";
        }
        else if (null != tbCode.Text && null != tbName.Text)
        {
            selectCommand += " and  to_char(code) = " + tbCode.Text + " and upper(name) like upper('%" + tbName.Text + "%') order by code";
        }
        odsKdfm01c.SelectCommand = selectCommand;
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
        if (gvKdfm01c.SelectedRows.Count != 0)
        {
            string Code = Convert.ToString(gvKdfm01c.DataKeys[gvKdfm01c.SelectedRows[0]].Value);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "close_dialog", "Close(" + Code + ");", true);
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