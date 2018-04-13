using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Classes;

public partial class credit_bpk_deal : Bars.BarsPage
{
    # region Приватные свойства
    private String _ShowCustomerReferPattern = "ShowCustomerRefer(0, '{0}', '{1}', '{2}'); return false;";
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        // сохраняем страничку с которой перешли
        if (!IsPostBack)
        {
            ViewState.Add("PREV_URL", Request.UrlReferrer.PathAndQuery);
        }
    }
    protected void RNK_ValueChanged(object sender, EventArgs e)
    {
        Decimal? RNK = (sender as Bars.UserControls.TextBoxNumb).Value;
        if (!RNK.HasValue) return;

        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);

        try
        {
            // установка роли
            cmd.ExecuteNonQuery();

            cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, RNK, ParameterDirection.Input);
            cmd.CommandText = "select okpo, nmk as fio from customer where rnk = :p_rnk";
            OracleDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {
                OKPO.Text = rdr["OKPO"] == DBNull.Value ? (String)null : (String)rdr["OKPO"];
                FIO.Text = rdr["FIO"] == DBNull.Value ? (String)null : (String)rdr["FIO"]; 
            }
            else
            {
                (sender as Bars.UserControls.TextBoxNumb).Value = (Decimal?)null;
                OKPO.Text = "";
                FIO.Text = "";

                ShowError("Клієн (" + RNK.ToString() + ") не знайдений");
            }
            rdr.Close();
            rdr.Dispose();
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }
    protected void btSend_Click(object sender, EventArgs e)
    {
        if (ValidatePage() && SendZay())
        {
            // действия выполняются в проц ValidatePage, SendZay
        }
    }
    protected override void OnPreRender(EventArgs e)
    {
        BindControls();

        base.OnPreRender(e);
    }
    # endregion

    # region Приватные методы
    private void BindControls()
    {
        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);
        OracleDataAdapter adr = new OracleDataAdapter(cmd);

        try
        {
            // установка роли
            cmd.ExecuteNonQuery();

            // Клієнт
            // Код Контрагенту : 
            btCustomerReferRNK.OnClientClick = String.Format(_ShowCustomerReferPattern, RNK.BaseClientID, OKPO.ClientID, FIO.ClientID);

            // Картка
            // ОБ22 : 
            if (!IsPostBack)
            {
                DataTable dtOB22 = new DataTable();
                cmd.CommandText = "select ob22 as id, ob22 || ' - ' || ob22_name as name from v_obpc_tips order by ob22";
                adr.Fill(dtOB22);

                OB22.DataSource = dtOB22;
                OB22.DataValueField = "ID";
                OB22.DataTextField = "NAME";
                OB22.DataBind();
            }

            // Валюта : 
            if (!IsPostBack)
            {
                DataTable dtKV = new DataTable();
                cmd.CommandText = "select kv as id, kv || ' - ' || name || ' (' || lcv || ')' as name from tabval where d_close is null or d_close > bankdate";
                adr.Fill(dtKV);
                adr.Dispose();

                KV.DataSource = dtKV;
                KV.DataValueField = "ID";
                KV.DataTextField = "NAME";
                KV.DataBind();

                KV.SelectedValue = "980";
            }
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    private void ShowError(String ErrorText)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_error", "alert('" + ErrorText + "');", true);
    }
    private void HideError()
    {
    }
    private Boolean ValidatePage()
    {
        return true;
    }
    private Boolean SendZay()
    {
        // скрываем ошибки
        HideError();

        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);

        try
        {
            // установка роли
            cmd.ExecuteNonQuery();

            Decimal? ND;
            Decimal? ErrCode;
            String ErrMessage;

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "obpc.bpk_deal";

            cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, RNK.Value, ParameterDirection.Input);
            cmd.Parameters.Add("p_kv", OracleDbType.Decimal, KV.Value, ParameterDirection.Input);
            cmd.Parameters.Add("p_ob22", OracleDbType.Varchar2, OB22.SelectedValue, ParameterDirection.Input);
            cmd.Parameters.Add("p_kl", OracleDbType.Decimal, Convert.ToDecimal(CreditLine.SelectedValue), ParameterDirection.Input);
            cmd.Parameters.Add("p_dp", OracleDbType.Decimal, Convert.ToDecimal(Deposit.SelectedValue), ParameterDirection.Input);
            cmd.Parameters.Add("p_nd", OracleDbType.Decimal, null, ParameterDirection.Output);
            cmd.Parameters.Add("p_err_code", OracleDbType.Decimal, null, ParameterDirection.Output);
            cmd.Parameters.Add("p_err_msg", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);

            cmd.ExecuteNonQuery();

            ND = ((OracleDecimal)cmd.Parameters["p_nd"].Value).IsNull ? (Decimal?)null : ((OracleDecimal)cmd.Parameters["p_nd"].Value).Value;
            ErrCode = ((OracleDecimal)cmd.Parameters["p_err_code"].Value).IsNull ? (Decimal?)null : ((OracleDecimal)cmd.Parameters["p_err_code"].Value).Value;
            ErrMessage = ((OracleString)cmd.Parameters["p_err_msg"].Value).IsNull ? (String)null : ((OracleString)cmd.Parameters["p_err_msg"].Value).Value;

            // анализируем результат
            if (ErrCode.HasValue && ErrCode != 0)
            {
                ShowError(ErrMessage);
                return false;
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "send_success", "alert('Картка відкрита. Присвоєно номер " + ND.ToString() + "'); location.replace('/barsroot/credit/bpk_deal.aspx')", true);
                ViewState.Remove("PREV_URL");
            }
        }
        finally
        {
            con.Close();
            con.Dispose();
        }

        return true;
    }
    # endregion
}
