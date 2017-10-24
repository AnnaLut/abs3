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


public partial class finmon_refterorist : Bars.BarsPage
{
    private void FillData()
    {
        odsRefTer.DataBind();
        gvRefTer.DataBind();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        gvRefTer.ShowFooter = false;
        gvRefTer.ShowPageSizeBox = false;

        FillGrid();
    }

    private void FillGrid()
    {
        odsRefTer.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        odsRefTer.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("");
        odsRefTer.SelectParameters.Clear();
        odsRefTer.WhereParameters.Clear();

        odsRefTer.SelectCommand = "select v.*, to_char(v.c2,'dd.mm.yyyy') c2char from v_finmon_reft v where v.c1 =" + Request["otm"];

    }

    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }

}