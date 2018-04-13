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

public partial class deposit_DepositBonus : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["DPT_ID"] == null || Session["DPT_NUM"] == null || Session["DepositInfo"] == null)
            Response.Redirect("depositcontract.aspx");

        if (BankType.GetCurrentBank() == BANKTYPE.UPB)
            Response.Redirect("depositcontractinfo.aspx");

        if (!IsPostBack)
        {
            lbTitle.Text = lbTitle.Text.Replace("%", Convert.ToString(Session["DPT_NUM"]));
            lbAvailable.Text = lbAvailable.Text.Replace("%", Convert.ToString(Session["DPT_NUM"]));
            FillGrid();
            FillFreeGrid();
        }
        else if (!String.IsNullOrEmpty(bonus_id.Value))
        {
            Decimal bonusid = Convert.ToDecimal(bonus_id.Value);
            bonus_id.Value = String.Empty;
            RemoveRequest(bonusid);
            FillGrid();
            FillFreeGrid();
        }
        else if (!String.IsNullOrEmpty(ins_bonus_id.Value))
        {
            Decimal b_id = Convert.ToDecimal(ins_bonus_id.Value);
            ins_bonus_id.Value = String.Empty;
            CreateRequest(b_id);
            FillFreeGrid();
            FillGrid();
        }
    }
    /// <summary>
    /// 
    /// </summary>
    private void FillGrid()
    {
        Deposit dpt = (Deposit)Session["DepositInfo"];

        dsBonus.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsBonus.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
        dsBonus.SelectParameters.Clear();

        String selectCommand = String.Empty;
        if (Deposit.BonusFixed(dpt.ID))
            selectCommand = @"select BONUS_ID, BONUS_NAME, BONUS_VALUE_PLAN, BONUS_VALUE_FACT, REQ_CONFIRM, REQ_DELETED, REC_STATEID, REC_STATENAME,
                null AS DEL
                from v_dpt_bonus_requests
                WHERE DPT_ID = :DPT_ID";
        else
            selectCommand = @"select BONUS_ID, BONUS_NAME, BONUS_VALUE_PLAN, BONUS_VALUE_FACT, REQ_CONFIRM, REQ_DELETED, REC_STATEID, REC_STATENAME,
                '<A href=# onclick=''DelBonusRequest('||bonus_id||')''>Видалити</a>' AS DEL
                from v_dpt_bonus_requests
                WHERE DPT_ID = :DPT_ID";

        dsBonus.SelectParameters.Add("nd", TypeCode.Decimal, Convert.ToString(dpt.ID));

        dsBonus.SelectCommand = selectCommand;
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="bonus_id"></param>
    private void RemoveRequest(Decimal id)
    {
        Deposit dpt = (Deposit)Session["DepositInfo"];

        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdDelReq = connect.CreateCommand();
            cmdDelReq.CommandText = "begin dpt_bonus.del_request(:p_dptid,:p_bonusid); end;";
            cmdDelReq.Parameters.Add("p_dptid", OracleDbType.Decimal, dpt.ID, ParameterDirection.Input);
            cmdDelReq.Parameters.Add("p_bonusid", OracleDbType.Decimal, id, ParameterDirection.Input);

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
    protected void gridBonus_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e != null && e.Row.RowType == DataControlRowType.DataRow)
        {
            GridViewRow row = e.Row;
            CheckBox ckNeedsConfirm = new CheckBox();
            ckNeedsConfirm.Enabled = false;
            ckNeedsConfirm.Checked = (row.Cells[4].Text == "Y");
            CheckBox ckDeleted = new CheckBox();
            ckDeleted.Enabled = false;
            ckDeleted.Checked = (row.Cells[5].Text == "Y");

            row.Cells[4].Controls.Add(ckNeedsConfirm);
            row.Cells[5].Controls.Add(ckDeleted);

            row.Cells[0].HorizontalAlign = HorizontalAlign.Center;
            row.Cells[1].HorizontalAlign = HorizontalAlign.Left;
            row.Cells[2].HorizontalAlign = HorizontalAlign.Right;
            row.Cells[3].HorizontalAlign = HorizontalAlign.Right;
            row.Cells[4].HorizontalAlign = HorizontalAlign.Center;
            row.Cells[5].HorizontalAlign = HorizontalAlign.Center;
            row.Cells[6].HorizontalAlign = HorizontalAlign.Left;
            row.Cells[7].HorizontalAlign = HorizontalAlign.Center;
        }
    }
    /// <summary>
    /// 
    /// </summary>
    private void FillFreeGrid()
    {
        Deposit dpt = (Deposit)Session["DepositInfo"];

        dsFree.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsFree.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
        dsFree.SelectParameters.Clear();

        String selectCommand = String.Empty;

        if (Deposit.BonusFixed(dpt.ID))
            selectCommand = @"select BONUS_ID, BONUS_CODE, 
                null FRM 
                from v_dpt_bonuses_free
                where dpt_id = :dpt_id";
        else
            selectCommand = @"select BONUS_ID, BONUS_CODE, 
                '<A href=# onclick=''FormBonusRequest('||BONUS_ID||')''>Формувати</a>' FRM 
                from v_dpt_bonuses_free
                where dpt_id = :dpt_id";

        dsFree.SelectParameters.Add("nd", TypeCode.Decimal, Convert.ToString(dpt.ID));

        dsFree.SelectCommand = selectCommand;
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="bonusid"></param>
    private void CreateRequest(Decimal id)
    {
        Deposit dpt = (Deposit)Session["DepositInfo"];

        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdDelReq = connect.CreateCommand();
            cmdDelReq.CommandText = "begin dpt_bonus.ins_request(:p_dptid,:p_bonusid); end;";
            cmdDelReq.Parameters.Add("p_dptid", OracleDbType.Decimal, dpt.ID, ParameterDirection.Input);
            cmdDelReq.Parameters.Add("p_bonusid", OracleDbType.Decimal, id, ParameterDirection.Input);

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
    protected void btRefresh_ServerClick(object sender, EventArgs e)
    {
        FillGrid();
        FillFreeGrid();
    }
}
