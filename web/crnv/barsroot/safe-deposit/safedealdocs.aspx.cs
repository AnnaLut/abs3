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
using Bars.Oracle;
using Oracle.DataAccess.Client;
using Bars.Classes;

public partial class safe_deposit_safedealdocs : System.Web.UI.Page
{
    /// <summary>
    /// 
    /// </summary>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["nd"] == null || Request["safe_id"] == null)
            Response.Redirect("safeportfolio.aspx");

        if (!IsPostBack)
        {
            lbTitle.Text = lbTitle.Text.Replace("%s",
                safe_deposit.GetNumById(Convert.ToDecimal(Convert.ToString(Request["safe_id"]))));
            FillGrid();
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sourceControl"></param>
    /// <param name="eventArgument"></param>
    protected override void RaisePostBackEvent(IPostBackEventHandler sourceControl, string eventArgument)
    {
        if (sourceControl.GetType().Name == "BarsGridView" || (eventArgument != null && eventArgument.Length > 4 && eventArgument.Substring(0, eventArgument.IndexOf("$")) == "Bars"))
        { FillGrid(); }

        base.RaisePostBackEvent(sourceControl, eventArgument);
    }    
    /// <summary>
    /// 
    /// </summary>
    private void FillGrid()
    {
        dsDocs.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsDocs.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DEP_SKRN");
        dsDocs.SelectParameters.Clear();

        String selectCommand = "select '<A href=# onclick=''ShowDocCard('||o.REF||')''>'||o.REF||'</a>' AS REF, " +
            "o.datd DATD,o.nlsa NLSA,o.kv KVA,o.s/100 SA,o.nlsb NLSB, " +
            "o.kv2 KVB,to_char(o.s2/100,'999999999990.99') SB,o.nazn NAZN " +
            "from oper o, skrynka_nd_ref r " +
            "where o.ref(+) = r.ref and r.nd = :nd and (o.sos >= 0 or sos is null) " +
            "order by r.ref";

        dsDocs.SelectParameters.Add("nd", TypeCode.Decimal, Convert.ToString(Request["nd"]));

        dsDocs.SelectCommand = selectCommand;
    }
    /// <summary>
    /// 
    /// </summary>
    protected void btRefresh_Click(object sender, EventArgs e)
    {
        FillGrid();
    }
}
