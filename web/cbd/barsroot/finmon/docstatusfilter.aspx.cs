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


public partial class finmon_docstatusfilter : Bars.BarsPage
{
    private void FillData()
    {
        odsStatus.DataBind();
        gvStatus.DataBind();
    }

    protected void Init()
    {
        if (!String.IsNullOrEmpty(Session["FinmonStatuses"] as string))
        {
            tbStatuses.Value = Session["FinmonStatuses"].ToString().Replace("'","");
            if (Session["FinmonBlockedDocs"].ToString() == "1")
            {
                tbStatuses.Value += ",BL,";
            }
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        gvStatus.AutoGenerateCheckBoxColumn = true;
        gvStatus.ShowFooter = false;
        gvStatus.ShowPageSizeBox = false;

        FillGrid();
        Init();
    }

    private void FillGrid()
    {

        odsStatus.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        odsStatus.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("");
        odsStatus.SelectParameters.Clear();
        odsStatus.WhereParameters.Clear();

        String selectCommand = @"select  status, name from finmon_que_status 
                                 union all
                                 select 'BL' status, 'Заблоковані' name from dual
                                 order by 1";

        odsStatus.SelectCommand = selectCommand;
    }

    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }

    protected void btOk_Click(object sender, EventArgs e)
    {
        Session["FinminReload"] = "1";
        string p_status = "0";
        string p_blocked = "0";
        foreach (int row in gvStatus.GetSelectedIndices())
        {
            if (gvStatus.DataKeys[row]["STATUS"].ToString() == "BL")
            {
                p_blocked = "1";
              //  p_status += "'" + gvStatus.DataKeys[row]["STATUS"].ToString() + "',";
            }
            else
            {
                p_status += "'" + gvStatus.DataKeys[row]["STATUS"].ToString() + "',";
            }
        }

        if (p_status.Length > 1)
        {
            int x = p_status.Length;
            Session["FinmonStatuses"] = p_status.Substring(1, x - 1);

            string ww = p_status.Substring(1, x - 2);
        }
        else
        {
            int x = p_status.Length;
            Session["FinmonStatuses"] = "0";//p_status.Substring(1, x - 1); 
        }

        Session["FinmonBlockedDocs"] = p_blocked;

        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "close", " window.close('this');", true);
    }

    protected void btCancel_Click(object sender, EventArgs e)
    {
        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "close", " window.close('this');", true);
    }
}