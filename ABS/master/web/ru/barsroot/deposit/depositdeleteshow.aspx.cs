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
using Bars.Oracle;
using Oracle.DataAccess.Client;

public partial class deposit_depositdeleteshow : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            FillGrid();
        else if (!String.IsNullOrEmpty(SelId.Value))
        {
            String par = SelId.Value;
            SelId.Value = String.Empty;

            FillGrid();
            FillDetailGrid(par);
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
        dsReqest.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsReqest.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
        dsReqest.SelectParameters.Clear();

        String selectCommand = @"select
            '<A href=# onclick=''DETAILS('||REQ_ID||')''>Детальніше</a>' AS DETAIL, 
            REQ_ID, REQ_CRDATE, 
            REQ_CRUSER, REQ_PRCDATE, REQ_PRCUSER, DPT_ID,DPT_ND, BRANCH_NAME, REQ_STATENAME
            from V_DPT_DELREQS
            ORDER BY REQ_ID";

        dsReqest.SelectCommand = selectCommand;
    }
    /// <summary>
    /// 
    /// </summary>
    private void FillDetailGrid(String par_req)
    {
        dsDetail.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsDetail.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
        dsDetail.SelectParameters.Clear();

        String selectCommand = @"select REQ_ID, USER_ID, USER_FIO, USER_DATE,USER_STATE 
            from V_DPT_DELREQ_DETAILS
            WHERE REQ_ID = :REQ_ID
            ORDER BY USER_DATE";

        dsDetail.SelectParameters.Add("REQ_ID",TypeCode.Decimal, par_req);

        dsDetail.SelectCommand = selectCommand;
    }
}
