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

public partial class deposit_depositpayoffresource : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    /// <summary>
    /// 
    /// </summary>
    protected override void RaisePostBackEvent(IPostBackEventHandler sourceControl, string eventArgument)
    {
        if (sourceControl.GetType().Name == "BarsGridView" || (eventArgument != null && eventArgument.Length > 4 && eventArgument.Substring(0, eventArgument.IndexOf("$")) == "Bars"))
        { InitGrid(); }

        base.RaisePostBackEvent(sourceControl, eventArgument);
    }
    /// <summary>
    /// 
    /// </summary>
    private void InitGrid()
    {
        dsResource.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsResource.PreliminaryStatement = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
        dsResource.SelectCommand = Convert.ToString(Session["DPT_RESOURCE_QUERY"]);
    }
    protected void btRefreshByDay_Click(object sender, EventArgs e)
    {
        Session["DPT_RESOURCE_QUERY"] = @"SELECT dpt_1.kv, dpt_1.lcv LCV, dpt_1.datk DAT, 
               to_char(sum(dpt_1.s)/power(10,tabval.dig),'999999999990.99') SUM, tabval.dig , dpt_1.branch TOBO
          FROM dpt_1, tabval 
         WHERE dpt_1.kv=tabval.kv AND  isp > 0 
           AND dpt_1.s <> 0  
         GROUP BY dpt_1.kv, dpt_1.lcv, dpt_1.datk, tabval.dig , dpt_1.branch
         ORDER BY dpt_1.kv, dpt_1.datk";
        InitGrid();
    }
    protected void btRefreshMonth_Click(object sender, EventArgs e)
    {
        Session["DPT_RESOURCE_QUERY"] = @"SELECT dpt_1.kv, dpt_1.lcv LCV, to_char(dpt_1.datk,'yyyy-mm') DAT, 
               to_char(sum(dpt_1.s)/power(10,tabval.dig),'999999999990.99') SUM, tabval.dig , dpt_1.branch TOBO
          FROM dpt_1, tabval 
         WHERE dpt_1.kv=tabval.kv AND  isp > 0 
           AND dpt_1.s <> 0 
         GROUP BY dpt_1.kv, dpt_1.lcv, to_char(dpt_1.datk,'yyyy-mm'), tabval.dig , dpt_1.branch
         ORDER BY dpt_1.kv, to_char(dpt_1.datk,'yyyy-mm')";
        InitGrid();
    }
}
