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
using Bars.Classes;
using Oracle.DataAccess.Client;


public partial class deposit_depositcommissionquest : System.Web.UI.Page
{
    /// <summary>
    /// 
    /// </summary>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["dpt_id"] == null || Request["agr_id"] == null || Request["name"] == null)
            Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");

        String url = "DepositAgreementTemplate.aspx?dpt_id=" + Request["dpt_id"] +
            "&agr_id=" + Request["agr_id"] + "&name=" + Request["name"];

        if (Request["rnk_tr"] != null)
            url += "&rnk_tr=" + Convert.ToString(Request["rnk_tr"]);

        String param_req_id = ckFormAbility();

        if (!IsPostBack)
        {
            /// Якщо комісії не передбачено - йдемо сміло далі
            if (HasNoCommission(Convert.ToString(Request["agr_id"])))
            { Session["NO_COMISSION"] = String.Empty; Response.Redirect(url); }

            FillGrid(param_req_id);
        }
        else if (!String.IsNullOrEmpty(reqid.Value))
        {
            String val = reqid.Value;
            reqid.Value = String.Empty;
            confirm_reqid.Value = String.Empty;
            confirm_agr_type.Value = String.Empty;
            pDelComissRequest(val);
        }
        else if (!String.IsNullOrEmpty(confirm_reqid.Value) && !String.IsNullOrEmpty(confirm_agr_type.Value))
        {
            String val1 = confirm_reqid.Value;
            String val2 = confirm_agr_type.Value;
            confirm_reqid.Value = String.Empty;
            confirm_agr_type.Value = String.Empty;
            reqid.Value = String.Empty;

            pNoComiss(val1,val2);
        }
    }
    /// <summary>
    /// 
    /// </summary>
    private void FillGrid(String param_req_id)
    {
        dsQuest.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsQuest.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
        dsQuest.SelectParameters.Clear();

        String selectCommand = @"select 
            decode(REQ_STATE,1,'<A href=# onclick=''NoComiss('||REQ_ID||','||AGRMNT_TYPE||')''>Без комісії</a>',null) AS ACCEPT,
            '<A href=# onclick=''DelComissRequest('||REQ_ID||')''>Видалити</a>' AS DEL,
            REQ_ID,REQ_CRDATE,REQ_CRUSER,REQ_PRCDATE,REQ_PRCUSER,DPT_ID,AGRMNT_TYPENAME,REQ_STATENAME
            from V_DPT_COMMISREQS
            where dpt_id = :dpt_id and REQ_ID= :REQ_ID";

        dsQuest.SelectParameters.Add("dpt_id", TypeCode.Decimal, Convert.ToString(Request["dpt_id"]));
        dsQuest.SelectParameters.Add("REQ_ID", TypeCode.Decimal, param_req_id);

        dsQuest.SelectCommand = selectCommand;
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="agr_id"></param>
    /// <returns></returns>
    private bool HasNoCommission(String agr_id)
    {
        OracleConnection connect = new OracleConnection();
        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmd.ExecuteNonQuery();

            cmd.CommandText = "select nvl(main_tt,'') from dpt_vidd_flags where id=:agr_id";
            cmd.Parameters.Add("agr_id", OracleDbType.Decimal, Convert.ToDecimal(agr_id), ParameterDirection.Input);

            String TT = Convert.ToString(cmd.ExecuteScalar());

            return String.IsNullOrEmpty(TT);
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
    protected void btTakeComission_ServerClick(object sender, EventArgs e)
    {
        String url = "DepositAgreementTemplate.aspx?dpt_id=" + Request["dpt_id"] +
            "&agr_id=" + Request["agr_id"] + "&name=" + Request["name"];

        if (Request["rnk_tr"] != null)
            url += "&rnk_tr=" + Convert.ToString(Request["rnk_tr"]);

        Session["NO_COMISSION"] = String.Empty; 
        Response.Redirect(url);
    }
    /// <summary>
    /// 
    /// </summary>
    protected void btForm_ServerClick(object sender, EventArgs e)
    {
        OracleConnection connect = new OracleConnection();
        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmd.ExecuteNonQuery();

            cmd.CommandText = "declare " +
                "result number; " +
                "begin result := DPT_WEB.CREATE_COMMIS_REQUEST(:dpt_id, :agr_id); end;";
            cmd.Parameters.Add("dpt_id", OracleDbType.Decimal, Convert.ToString(Request["dpt_id"]), ParameterDirection.Input);
            cmd.Parameters.Add("agr_id", OracleDbType.Decimal, Convert.ToString(Request["agr_id"]), ParameterDirection.Input);

            cmd.ExecuteNonQuery();

            String param_req_id = ckFormAbility();
            FillGrid(param_req_id);
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
    /// <param name="request_id"></param>
    private void pDelComissRequest(String request_id)
    {
        OracleConnection connect = new OracleConnection();
        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmd.ExecuteNonQuery();

            cmd.CommandText = "begin DPT_WEB.DELETE_COMMIS_REQUEST(:req_id); end;";
            cmd.Parameters.Add("req_id", OracleDbType.Decimal, request_id, ParameterDirection.Input);

            cmd.ExecuteNonQuery();

            String param_req_id = ckFormAbility();
            FillGrid(param_req_id);
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
    /// <param name="request_id"></param>
    /// <param name="agr_id"></param>
    private void pNoComiss(String request_id, String agr_type)
    {
        if (Convert.ToString(Request["agr_id"]) != agr_type)
        {
            String param_req_id = ckFormAbility();
            FillGrid(param_req_id);

            Response.Write("<script>alert('Підтвердження для іншого типу додаткової угоди!');</script>");
            Response.Flush();
            return;
        }
        else
        {
            String url = "DepositAgreementTemplate.aspx?dpt_id=" + Request["dpt_id"] +
                "&agr_id=" + Request["agr_id"] + "&name=" + Request["name"];

            if (Request["rnk_tr"] != null)
                url += "&rnk_tr=" + Convert.ToString(Request["rnk_tr"]);

            Session["NO_COMISSION"] = request_id;
            Response.Redirect(url);
        }
    }
    /// <summary>
    /// 
    /// </summary>
    private String ckFormAbility()
    {
        OracleConnection connect = new OracleConnection();
        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmd.ExecuteNonQuery();

            cmd.CommandText = "select DPT_WEB.GET_COMMISREQ_ACTIVE(:dpt_id) from dual";
            cmd.Parameters.Add("dpt_id", OracleDbType.Decimal, Convert.ToString(Request["dpt_id"]), ParameterDirection.Input);

            String result = Convert.ToString(cmd.ExecuteScalar());
            if (!String.IsNullOrEmpty(result))
                btForm.Disabled = true;
            else
                btForm.Disabled = false;

            return result;
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
    protected void btRefresh_ServerClick(object sender, EventArgs e)
    {
        String param_req_id = ckFormAbility();
        FillGrid(param_req_id);
    }
}
