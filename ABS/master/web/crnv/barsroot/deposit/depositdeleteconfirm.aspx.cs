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
using Oracle.DataAccess.Client;
using Bars.Oracle;

public partial class deposit_depositdeleteconfirm : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Decimal req_id = Decimal.MinValue;

        if (!IsPostBack)
        {
            FillGrid();
        }
        else if (!String.IsNullOrEmpty(hidConfirmDelete.Value))
        {
            req_id = Convert.ToDecimal(hidConfirmDelete.Value);
            hidConfirmDelete.Value = String.Empty;
            hidDeclineDelete.Value = String.Empty;

            pConfirmDelete(req_id);
            FillGrid();
        }
        else if (!String.IsNullOrEmpty(hidDeclineDelete.Value))
        {
            req_id = Convert.ToDecimal(hidDeclineDelete.Value);
            hidDeclineDelete.Value = String.Empty;
            hidConfirmDelete.Value = String.Empty;

            pDeclineDelete(req_id);
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
        dsDeleteQue.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsDeleteQue.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
        dsDeleteQue.SelectParameters.Clear();

        String selectCommand = @"select 
            '<A href=# onclick=''ConfirmDelete('||REQ_ID||')''>Підтвердити</a>' AS CONFIRM,
            '<A href=# onclick=''DeclineDelete('||REQ_ID||')''>Відмовитися</a>' AS DECLINE, 
            REQ_ID, 
            '<A href=# onclick=''ShowDepositCard('||DPT_ID||')''>'||DPT_ID||'</a>' AS DPT_ID, 
            DPT_ND, DPT_DATE, USER_FIO from V_DPT_USER_DELREQS
            order by req_id";

        dsDeleteQue.SelectCommand = selectCommand;
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="p_req_id"></param>
    private void pConfirmDelete(Decimal p_req_id)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdDelReq = connect.CreateCommand();
            cmdDelReq.CommandText = "begin dpt_web.PUT_DELDEAL_CHECK(:p_req_id,dpt_web.REQUEST_ALLOWED); end;";
            cmdDelReq.Parameters.Add("p_req_id", OracleDbType.Decimal, p_req_id, ParameterDirection.Input);

            cmdDelReq.ExecuteNonQuery();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="p_req_id"></param>
    private void pDeclineDelete(Decimal p_req_id)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdDelReq = connect.CreateCommand();
            cmdDelReq.CommandText = "begin dpt_web.PUT_DELDEAL_CHECK(:p_req_id,dpt_web.REQUEST_DISALLOWED); end;";
            cmdDelReq.Parameters.Add("p_req_id", OracleDbType.Decimal, p_req_id, ParameterDirection.Input);

            cmdDelReq.ExecuteNonQuery();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
}
