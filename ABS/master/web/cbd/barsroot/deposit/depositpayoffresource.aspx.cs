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
//        Session["DPT_RESOURCE_QUERY"] = @"SELECT dpt_1.kv, dpt_1.lcv LCV, dpt_1.datk DAT, 
//               to_char(sum(dpt_1.s)/power(10,tabval.dig),'999999999990.99') SUM, tabval.dig , dpt_1.branch TOBO
//          FROM dpt_1, tabval 
//         WHERE dpt_1.kv=tabval.kv AND  isp > 0 
//           AND dpt_1.s <> 0  
//         GROUP BY dpt_1.kv, dpt_1.lcv, dpt_1.datk, tabval.dig , dpt_1.branch
//         ORDER BY dpt_1.kv, dpt_1.datk";

        Session["DPT_RESOURCE_QUERY"] = @"SELECT t.lcv, d.dat, d.branch, to_char((d.suma/t.denom),'FM999G999G999G990D009') SUMA
          FROM (select d.kv, d.dat_end as dat, d.branch, sum(a.ostc) as suma
                  from dpt_deposit d,
                       accounts    a
                 where d.acc = a.acc
                   and d.branch like sys_context('bars_context','user_branch')||'%'
                   and d.dat_end > (bankdate -5)
                   and a.ostc <> 0
                 group by d.kv, d.dat_end, d.branch
               ) d, tabval t
         WHERE d.kv=t.kv
         ORDER BY d.kv, d.dat";
        
        InitGrid();
    }
    protected void btRefreshMonth_Click(object sender, EventArgs e)
    {
//        Session["DPT_RESOURCE_QUERY"] = @"SELECT dpt_1.kv, dpt_1.lcv LCV, to_char(dpt_1.datk,'yyyy-mm') DAT, 
//               to_char(sum(dpt_1.s)/power(10,tabval.dig),'999999999990.99') SUM, tabval.dig , dpt_1.branch TOBO
//          FROM dpt_1, tabval 
//         WHERE dpt_1.kv=tabval.kv AND  isp > 0 
//           AND dpt_1.s <> 0 
//         GROUP BY dpt_1.kv, dpt_1.lcv, to_char(dpt_1.datk,'yyyy-mm'), tabval.dig , dpt_1.branch
//         ORDER BY dpt_1.kv, to_char(dpt_1.datk,'yyyy-mm')";

        Session["DPT_RESOURCE_QUERY"] = @"SELECT t.lcv, d.dat, d.branch, to_char((d.suma/t.denom),'FM999G999G999G990D009') SUMA
          FROM (select d.kv, to_char(d.dat_end,'yyyy-mm') as dat, d.branch, sum(a.ostc) as suma
                  from dpt_deposit d,
                       accounts    a
                 where d.acc = a.acc
                   and d.branch like sys_context('bars_context','user_branch')||'%'
                   and d.dat_end >= trunc(bankdate,'MM')
                   and a.ostc <> 0
                 group by d.kv, to_char(d.dat_end,'yyyy-mm'), d.branch) d, tabval t
         WHERE d.kv=t.kv
         ORDER BY d.kv, d.dat";

        InitGrid();
    }
}
