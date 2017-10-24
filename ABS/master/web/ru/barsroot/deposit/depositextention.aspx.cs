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
using Oracle.DataAccess.Client;
using Bars.Oracle;
using Bars.Exception;

public partial class deposit_depositextention : System.Web.UI.Page
{
    /// <summary>
    /// 
    /// </summary>
    private String P_VISA_URL = "visa";
    /// <summary>
    /// 
    /// </summary>
    private Boolean IsVisa
    {
        get
        {
            if (Request[P_VISA_URL] != null)
                return true;
            else
                return false;
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["dpt_id"] == null)
            Response.Redirect("/barsroot/barsweb/welcome.aspx");

        if (!IsPostBack)
        {
            if (IsVisa)
            {
                lbTitle.Text = "Візування відмови від переоформлення вкладу №%s";
                btRefuse.Text = "Візувати";
                btStorno.Visible = true;
                rStorno.Visible = true;
            }
            else
            {
                lbTitle.Text = "Відмова від переоформлення вкладу №%s";
                btRefuse.Text = "Відмовитися";
                btStorno.Visible = false;
                rStorno.Visible = false;
            }

            FillControls();
        }
    }
    /// <summary>
    /// 
    /// </summary>
    private void FillControls()
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection(Context);

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdGetData = connect.CreateCommand();
            cmdGetData.CommandText = @"select dpt_num, 
                        to_char(dpt_dat,'dd/MM/yyyy'), 
                        to_char(dat_begin,'dd/MM/yyyy'), 
                        to_char(dat_end,'dd/MM/yyyy'), 
                        vidd_name, rate, 
                        cust_name,  
                        doc_serial || ' ' || doc_num, 
                        doc_issued  || ' ' || to_char(doc_date,'dd/MM/yyyy'),                         
                        dpt_curcode, dpt_accnum, dpt_saldo/100, 
                        int_curcode, int_accnum, int_saldo/100, dpt_num ";
            if (IsVisa)
                cmdGetData.CommandText += " from v_dptext_refusreqs where dpt_id = :dpt_id";
            else
                cmdGetData.CommandText += " from v_dptext_pretenders where dpt_id = :dpt_id";

            cmdGetData.Parameters.Add("dpt_id", OracleDbType.Decimal, Request["dpt_id"], ParameterDirection.Input);

            OracleDataReader rdr = cmdGetData.ExecuteReader();

            if (rdr.Read())
            {
                if (!rdr.IsDBNull(0))
                    textContractNumber.Text = rdr.GetOracleString(0).Value;
                if (!rdr.IsDBNull(1))
                    textDateFrom.Text = rdr.GetOracleString(1).Value;
                if (!rdr.IsDBNull(2))
                    textDatBegin.Text = rdr.GetOracleString(2).Value;
                if (!rdr.IsDBNull(3))
                    textDatEnd.Text = rdr.GetOracleString(3).Value;
                if (!rdr.IsDBNull(4))
                    textDepositType.Text = rdr.GetOracleString(4).Value;
                if (!rdr.IsDBNull(5))
                    textRate.Text = rdr.GetOracleDecimal(5).Value.ToString("### ### ### ### ### ##0.00");
                if (!rdr.IsDBNull(6))
                    textClientName.Text = rdr.GetOracleString(6).Value;
                if (!rdr.IsDBNull(7))
                    textDocNumber.Text = rdr.GetOracleString(7).Value;
                if (!rdr.IsDBNull(8))
                    textDocOrg.Text = rdr.GetOracleString(8).Value;                
                if (!rdr.IsDBNull(9))
                    textDepositAccountCurrency.Text = rdr.GetOracleString(9).Value;
                if (!rdr.IsDBNull(10))
                    textDepositAccount.Text = rdr.GetOracleString(10).Value;
                if (!rdr.IsDBNull(11))
                    textDepositAccountRest.Text = rdr.GetOracleDecimal(11).Value.ToString("### ### ### ### ### ##0.00");
                if (!rdr.IsDBNull(12))
                    textIntAccountCurrency.Text = rdr.GetOracleString(12).Value;
                if (!rdr.IsDBNull(13))
                    textInterestAccount.Text = rdr.GetOracleString(13).Value;
                if (!rdr.IsDBNull(14))
                    textInterestAccountRest.Text = rdr.GetOracleDecimal(14).Value.ToString("### ### ### ### ### ##0.00");
                if (!rdr.IsDBNull(15))
                    lbTitle.Text = lbTitle.Text.Replace("%s", rdr.GetOracleString(15).Value);
            }
            else
                throw new DepositException("По депозитному договору №" + Convert.ToString(Request["DPT_ID"]) +
                    " неможливо здійснити відмову від переоформлення.");
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
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void  btRefuse_Click(object sender, System.EventArgs e)
    {
        if (IsVisa)
            Deposit.VerifyExtention(Convert.ToDecimal(Request["dpt_id"]), VERIFY_STATUS.VISA,String.Empty);
        else
            Deposit.RefuseExtention(Convert.ToDecimal(Request["dpt_id"]));

        btRefuse.Enabled = false;
        btStorno.Enabled = false;

        if (IsVisa)
            Response.Write("<script>alert('Візування відмови від переоформлення пройшло успішно');</script>");
        else
            Response.Write("<script>alert('Відмова від переоформлення пройшла успішно');</script>");
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btStorno_Click(object sender, EventArgs e)
    {
        Deposit.VerifyExtention(Convert.ToDecimal(Request["dpt_id"]), VERIFY_STATUS.STORNO, textStornoReason.Text);

        btRefuse.Enabled = false;
        btStorno.Enabled = false;

        if (IsVisa)
            Response.Write("<script>alert('Візування відмови від переоформлення пройшло успішно');</script>");
        else
            Response.Write("<script>alert('Відмова від переоформлення пройшла успішно');</script>");
    }
}
