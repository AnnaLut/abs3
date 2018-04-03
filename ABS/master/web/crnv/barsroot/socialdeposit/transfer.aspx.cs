using System;
using System.Data;
using System.Globalization;
using System.Web.Services;
using System.Web.UI;
using Bars.Classes;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using Bars.Exception;

public partial class Transfer : Bars.BarsPage
{
    /// <summary>
    /// Завантаження сторінки
    /// </summary>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request["action"] == null || Request["cash"] == null)
                throw new SocialDepositException("Сторінка викликана з некоректними параметрами!");

            DPT_ID.Value = Convert.ToString(Request["dpt_id"]);
            textRNK.Text = Convert.ToString(Request["rnk"]);
            cash.Value = (Request["cash"] == "true" ? "1" : "0");
            dpf_oper.Value = BankType.GetDpfOper(Convert.ToDecimal(Request["dpt_id"]));

            if (Request["cash"] == "true")
            {
                if (Request["owner"] == "H")
                {
                    Sum.Enabled = false;
                }
                Commission.Enabled = false;
            }
            else
            {
                Commission.Enabled = false;
                tbTransferInfo.Visible = true;
                //Sum.Attributes["onblur"] = "javascript:CalculateCommission()";
                //textMFO_B.Attributes["onblur"] = "javascript:CalculateMaxSum()";
            }

            /// Заповнюємо інформацію для оплати
            FillControls(true);
        }
        else
            FillControls(false);
    }
    /// <summary>
    /// Наповнення контролів
    /// </summary>
    private void FillControls(bool complete)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdGetInfo = connect.CreateCommand();

            OracleDataReader rdr = null;

            if (complete)
            {
                cmdGetInfo.CommandText = @"SELECT c.adr, pa.name, TO_CHAR(p.ser) || ' ' ||  TO_CHAR(p.NUMDOC),
                    TO_CHAR(p.ORGAN) || ' ' || TO_CHAR (p.PDATE,'dd/mm/yyyy'),
                    TO_CHAR(p.bday,'dd/mm/yyyy'), c.nmk
                    FROM  customer c, person p, passp pa
                    WHERE c.rnk = :rnk AND c.rnk = p.rnk AND pa.passp = p.passp";
                cmdGetInfo.Parameters.Add("rnk", OracleDbType.Decimal, Convert.ToDecimal(Convert.ToString(Request["rnk"])), ParameterDirection.Input);

                rdr = cmdGetInfo.ExecuteReader();

                if (!rdr.Read())
                    throw new SocialDepositException("Дані про клієнта rnk=" +
                        Convert.ToString(Request["rnk"]) + " не знайдені!");

                if (!rdr.IsDBNull(0))
                    ADRES.Value = Convert.ToString(rdr.GetOracleString(0).Value);
                if (!rdr.IsDBNull(1))
                    PASP.Value = Convert.ToString(rdr.GetOracleString(1).Value);
                if (!rdr.IsDBNull(2))
                    PASPN.Value = Convert.ToString(rdr.GetOracleString(2).Value);
                if (!rdr.IsDBNull(3))
                    ATRT.Value = Convert.ToString(rdr.GetOracleString(3).Value);
                if (!rdr.IsDBNull(4))
                    DT_R.Value = Convert.ToString(rdr.GetOracleString(4).Value);
                if (!rdr.IsDBNull(5))
                    NMK.Value = Convert.ToString(rdr.GetOracleString(5).Value);

                cmdGetInfo.Parameters.Clear();
            }
            Decimal p_int = Decimal.MinValue;
            OracleCommand cmdAddPercent = connect.CreateCommand();
            cmdAddPercent.CommandText = @"DECLARE 
                p_err BOOLEAN;	
                v_rc sys_refcursor; 
                BEGIN	
                	OPEN v_rc FOR 
                    SELECT bankdate, bars_context.extract_mfo(a.BRANCH), a.BRANCH, 
                	a.acc, 1, a.nls, a.kv, 
                	a.nbs, a.nms, t.lcv, a.daos, 
                	SUBSTR('Нарахування відсотків по договору №' 
                	||trim(s.contract_num) 
                	||' від ' 
                	||f_dat_lit(s.contract_date,'U'), 1, 160), 
                	NULL 
                	FROM ACCOUNTS a, social_contracts s, TABVAL t 
                	WHERE s.acc = a.acc 
                	AND t.kv = a.kv 
                	AND s.contract_id = :contract_id; 
                	p_make_int(v_rc,bankdate-1,1,0,:p_int,p_err); 
                END;";
            cmdAddPercent.Parameters.Add("contract_id", OracleDbType.Decimal, Convert.ToDecimal(Request["dpt_id"]), ParameterDirection.Input);
            cmdAddPercent.Parameters.Add("p_int", OracleDbType.Decimal, p_int, ParameterDirection.Output);

            cmdAddPercent.ExecuteNonQuery();

            if (rbMain.Checked)
            {
                cmdGetInfo.CommandText = @"select account_number, currency_code,
                    TO_CHAR(account_saldo/100,'999999999990.99'),
                    customer_id,  customer_name, cusomer_code,
                    contract_number, currency_id,
                    bars_context.extract_mfo(branch_id) 
                    from v_socialcontracts
                    where contract_id = :contract_id";
            }
            else if (rbPercent.Checked)
            {
                cmdGetInfo.CommandText = @"select interest_number, currency_code,
                    nvl(TO_CHAR(interest_saldo_pl/100,'999999999990.99'),'0.00'),
                    customer_id,  customer_name, cusomer_code,
                    contract_number, currency_id,
                    bars_context.extract_mfo(branch_id) 
                    from v_socialcontracts
                    where contract_id = :contract_id";
            }
            cmdGetInfo.Parameters.Add("contract_id", OracleDbType.Decimal, 
                Convert.ToDecimal(Request["dpt_id"]), ParameterDirection.Input);

            rdr = cmdGetInfo.ExecuteReader();

            if (!rdr.Read())
                throw new SocialDepositException("Дані про договір id=" +
                    Convert.ToString(Request["dpt_id"]) + " не знайдені!");

            if (!rdr.IsDBNull(0))
                textNLS.Text = Convert.ToString(rdr.GetOracleString(0).Value);
            if (!rdr.IsDBNull(1))
                textKV.Text = Convert.ToString(rdr.GetOracleString(1).Value);
            if (!rdr.IsDBNull(2))
                textSUM.Text = Convert.ToString(rdr.GetOracleString(2).Value);
            if (!rdr.IsDBNull(4))
                textNMK.Text = Convert.ToString(rdr.GetOracleString(4).Value);
            if (!rdr.IsDBNull(5))
                textOKPO.Text = Convert.ToString(rdr.GetOracleString(5).Value);
            if (!rdr.IsDBNull(6))
                textDPT_NUM.Text = Convert.ToString(rdr.GetOracleString(6).Value);
            if (!rdr.IsDBNull(7))
                KV.Value = Convert.ToString(rdr.GetOracleDecimal(7).Value);
            if (!rdr.IsDBNull(8))
            {
                textMFO_B.Text = Convert.ToString(rdr.GetOracleString(8).Value);
                ourMFO.Value = textMFO_B.Text;
            }

            cmdGetInfo.Parameters.Clear();

            /// Одержуємо коди операцій
            GetTts();

            Sum.Text = textSUM.Text;

            if (!rdr.IsClosed) rdr.Close();
            rdr.Dispose();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// AJAX метод
    /// обрахування комісії
    /// </summary>
    /// <param name="_tt">Операція комісії</param>
    /// <param name="s">Сума основної операції</param>
    /// <returns>Сума комісії</returns>
    [WebMethod(EnableSession = true)]
    public static string CalculateCommission(String _tt,String s)
    {
        OracleConnection connect = new OracleConnection();
        Decimal result = Decimal.MinValue;

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdGetInfo = connect.CreateCommand();
            cmdGetInfo.CommandText = "SELECT s FROM TTS WHERE tt =:tt";
            cmdGetInfo.Parameters.Add("tt", OracleDbType.Varchar2, _tt, ParameterDirection.Input);
            String formula = Convert.ToString(cmdGetInfo.ExecuteScalar());

            if (formula == String.Empty)
                throw new ApplicationException("В операції " + _tt + " відсутня формула суми!");

            formula = formula.Replace("#(SMAIN)", s.Replace(",","."));

            cmdGetInfo.Parameters.Clear();
            formula = "SELECT ROUND(" + formula + ") from dual";
            cmdGetInfo.CommandText = "begin Doc_Strans(:text,:s_a); end;";
            cmdGetInfo.Parameters.Add("text", OracleDbType.Varchar2, formula, ParameterDirection.Input);
            cmdGetInfo.Parameters.Add("s_a", OracleDbType.Decimal, result, ParameterDirection.Output);            
            cmdGetInfo.ExecuteNonQuery();

            result = Convert.ToDecimal(Convert.ToString(cmdGetInfo.Parameters["s_a"].Value)) / 100;

            return result.ToString();
        }
        ///// Перехоплюємо бо ASP.NET ajax НІЯК не обробляє викинуті помилки
        catch (Exception ex)
        {
            Deposit.SaveException(ex);
            throw ex;
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
    /// <param name="_tt"></param>
    /// <returns></returns>
    [WebMethod(EnableSession = true)]
    public static string CalculateMaxSum(String _tt, String s)
    {
        OracleConnection connect = new OracleConnection();
        Decimal result = Decimal.MinValue;

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            NumberFormatInfo nf = new NumberFormatInfo();
            nf.NumberDecimalSeparator = ".";
            nf.NumberGroupSeparator = " ";

            OracleCommand cmdGetInfo = connect.CreateCommand();
            cmdGetInfo.CommandText = "begin root(:tt,:ms,:x); end;";
            cmdGetInfo.Parameters.Add("tt", OracleDbType.Varchar2, _tt, ParameterDirection.Input);
            cmdGetInfo.Parameters.Add("ms", OracleDbType.Decimal, Convert.ToDecimal(s, nf),
                ParameterDirection.Input);
            cmdGetInfo.Parameters.Add("x", OracleDbType.Decimal, result, ParameterDirection.Output);
            cmdGetInfo.ExecuteNonQuery();

            result = Convert.ToDecimal(Convert.ToString(cmdGetInfo.Parameters["x"].Value), nf) / 100;
            return result.ToString();
        }
        ///// Перехоплюємо бо ASP.NET ajax НІЯК не обробляє викинуті помилки
        catch (Exception ex)
        {
            Deposit.SaveException(ex);
            throw ex;
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
    private void GetTts()
    {
        if (rbMain.Checked)
        {
            /// Виплата готівкою
            tt.Value = SocialDeposit.GetSocTT(DPT_OP.OP_21);
            /// Переказ по міжбанку
            tt_OUT.Value = SocialDeposit.GetSocTT(DPT_OP.OP_26);

            tt_IN.Value = SocialDeposit.GetSocTT(DPT_OP.OP_23);
        }
        else if (rbPercent.Checked)
        {
            /// Виплата готівкою
            tt.Value = SocialDeposit.GetSocTT(DPT_OP.OP_3);
            /// Переказ по міжбанку
            tt_OUT.Value = SocialDeposit.GetSocTT(DPT_OP.OP_46);

            tt_IN.Value = SocialDeposit.GetSocTT(DPT_OP.OP_43);
        }
    }
}
