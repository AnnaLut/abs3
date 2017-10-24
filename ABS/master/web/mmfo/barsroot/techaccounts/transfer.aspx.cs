using System;
using System.Data;
using System.Globalization;
using System.Web.Services;
using System.Web.UI;
using Bars.Classes;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using Bars.Exception;

public partial class Transfer : Page
{
    /// <summary>
    /// Завантаження сторінки
    /// </summary>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["acc"] == null || Request["action"] == null || Request["cash"] == null)
            throw new TechAccountsException("Сторінка викликана з некоректними параметрами!");

        DPT_ID.Value = Convert.ToString(Request["dpt_id"]);
        cash.Value = (Request["cash"] == "true" ? "1" : "0");

        if (Request["cash"] == "true")
        {
            if (Request["owner"] == "H")
            {
                Sum.Enabled = false;
                tbDocs.Visible = true;
            }
            Commission.Enabled = false;
//            btPayCommission.Disabled = true;
        }
        else
        {
            Commission.Enabled = true;
//            btPayCommission.Disabled = true;
            tbTransferInfo.Visible = true;
            Sum.Attributes["onblur"] = "javascript:CalculateCommission()";
            textMFO_B.Attributes["onblur"] = "javascript:CalculateMaxSum()";
        }

        /// Заповнюємо інформацію для оплати
        FillControls();
    }
    /// <summary>
    /// Наповнення контролів
    /// </summary>
    private void FillControls()
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
            cmdGetInfo.CommandText = @"SELECT c.adr, pa.name, TO_CHAR(p.ser) || ' ' ||  TO_CHAR(p.NUMDOC),
                TO_CHAR(p.ORGAN) || ' ' || TO_CHAR (p.PDATE,'dd/mm/yyyy'),
                TO_CHAR(p.bday,'dd/mm/yyyy'), c.nmk
                FROM  customer c, person p, passp pa
                WHERE c.rnk = :rnk AND c.rnk = p.rnk AND pa.passp = p.passp";
            cmdGetInfo.Parameters.Add("rnk", OracleDbType.Decimal, Convert.ToDecimal(Convert.ToString(Request["rnk"])), ParameterDirection.Input);

            OracleDataReader rdr = cmdGetInfo.ExecuteReader();

            if (!rdr.Read())
                throw new TechAccountsException("Дані про клієнта rnk=" +
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
            
            /// Поповнення готівкою
            cmdGetInfo.CommandText = "SELECT tt_main FROM v_techacc_operations WHERE op_id = :op_id";
            cmdGetInfo.Parameters.Add("op_id", OracleDbType.Decimal, 203, ParameterDirection.Input);
            tt.Value = Convert.ToString(cmdGetInfo.ExecuteScalar());

            cmdGetInfo.Parameters.Clear();

            cmdGetInfo.CommandText = @"SELECT v.tech_accnum, v.tech_currency, 
                TO_CHAR(v.tech_dat_open,'dd/mm/yyyy'),
                TO_CHAR(v.tech_saldo/100,'999999999990.99'), 
                v.tech_custnum, v.tech_customer, v.tech_custid, v.dpt_num,t.kv,
                bars_context.extract_mfo(v.branch_id)
                FROM v_dpt_tech_accounts v, tabval t
                WHERE v.tech_accid = :acc and v.tech_currency = t.lcv";

            cmdGetInfo.Parameters.Add("acc", OracleDbType.Decimal, Convert.ToDecimal(Request["acc"]), ParameterDirection.Input);

            rdr = cmdGetInfo.ExecuteReader();

            if (!rdr.Read())
                throw new TechAccountsException("Дані про рахунок acc=" +
                    Convert.ToString(Request["acc"]) + " не знайдені!");

            if (!rdr.IsDBNull(0))
                textNLS.Text = Convert.ToString(rdr.GetOracleString(0).Value);
            if (!rdr.IsDBNull(1))
                textKV.Text = Convert.ToString(rdr.GetOracleString(1).Value);
            if (!rdr.IsDBNull(2))
                textDAT.Text = Convert.ToString(rdr.GetOracleString(2).Value);
            if (!rdr.IsDBNull(3))
                textSUM.Text = Convert.ToString(rdr.GetOracleString(3).Value);
            if (!rdr.IsDBNull(4))
                textRNK.Text = Convert.ToString(rdr.GetOracleDecimal(4).Value);
            if (!rdr.IsDBNull(5))
                textNMK.Text = Convert.ToString(rdr.GetOracleString(5).Value);
            if (!rdr.IsDBNull(6))
                textOKPO.Text = Convert.ToString(rdr.GetOracleString(6).Value);
            if (!rdr.IsDBNull(7))
                textDPT_NUM.Text = Convert.ToString(rdr.GetOracleString(7).Value);
            if (!rdr.IsDBNull(8))
                KV.Value = Convert.ToString(rdr.GetOracleDecimal(8).Value);
            if (!rdr.IsDBNull(9))
            {
                textMFO_B.Text = Convert.ToString(rdr.GetOracleString(9).Value);
                ourMFO.Value = textMFO_B.Text;
            }

            cmdGetInfo.Parameters.Clear();

            /// Рахунок в нац. валюті
            if (KV.Value == "980")
            {
                /// Переказ по міжбанку
                cmdGetInfo.CommandText = "SELECT tt_main, tt_comiss FROM v_techacc_operations WHERE op_id = :op_id";
                cmdGetInfo.Parameters.Add("op_id", OracleDbType.Decimal, 199 , ParameterDirection.Input);
                
                rdr = cmdGetInfo.ExecuteReader();

                if (!rdr.Read())
                    throw new TechAccountsException("Дані про операції з технічними рахунками типу 199 не знайдені!");
                
                if (!rdr.IsDBNull(0))
                    tt_OUT.Value = Convert.ToString(rdr.GetOracleString(0).Value);
                if (!rdr.IsDBNull(1))
                    tt_OUT_K.Value = Convert.ToString(rdr.GetOracleString(1).Value);

                cmdGetInfo.Parameters.Clear();
                
                /// Переказ по внутрібанку
                cmdGetInfo.Parameters.Add("op_id", OracleDbType.Decimal, 201 , ParameterDirection.Input);
                
                rdr = cmdGetInfo.ExecuteReader();

                if (!rdr.Read())
                    throw new TechAccountsException("Дані про операції з технічними рахунками типу 201 не знайдені!");
                
                if (!rdr.IsDBNull(0))
                    tt_IN.Value = Convert.ToString(rdr.GetOracleString(0).Value);
                if (!rdr.IsDBNull(1))
                    tt_IN_K.Value = Convert.ToString(rdr.GetOracleString(1).Value);

                cmdGetInfo.Parameters.Clear();
            }
            /// Рахунок в іноземній валюті
            else
            {
                /// Переказ по міжбанку
                cmdGetInfo.CommandText = "SELECT tt_main, tt_comiss FROM v_techacc_operations WHERE op_id = :op_id";
                cmdGetInfo.Parameters.Add("op_id", OracleDbType.Decimal, 200 , ParameterDirection.Input);
                
                rdr = cmdGetInfo.ExecuteReader();

                if (!rdr.Read())
                    throw new TechAccountsException("Дані про операції з технічними рахунками типу 200 не знайдені!");
                
                if (!rdr.IsDBNull(0))
                    tt_OUT.Value = Convert.ToString(rdr.GetOracleString(0).Value);
                if (!rdr.IsDBNull(1))
                    tt_OUT_K.Value = Convert.ToString(rdr.GetOracleString(1).Value);

                cmdGetInfo.Parameters.Clear();
                
                /// Переказ по внутрібанку
                cmdGetInfo.Parameters.Add("op_id", OracleDbType.Decimal, 202 , ParameterDirection.Input);
                
                rdr = cmdGetInfo.ExecuteReader();

                if (!rdr.Read())
                    throw new TechAccountsException("Дані про операції з технічними рахунками типу 202 не знайдені!");
                
                if (!rdr.IsDBNull(0))
                    tt_IN.Value = Convert.ToString(rdr.GetOracleString(0).Value);
                if (!rdr.IsDBNull(1))
                    tt_IN_K.Value = Convert.ToString(rdr.GetOracleString(1).Value);

                cmdGetInfo.Parameters.Clear();
            }
            if (Request["cash"] == "true")
            {
                Sum.Text = textSUM.Text;
            }
            else
            {
                NumberFormatInfo nf = new NumberFormatInfo();
                nf.NumberDecimalSeparator = ".";
                nf.NumberGroupSeparator = " ";

                Decimal result = 0;
                cmdGetInfo.CommandText = "begin root(:tt,:ms,:x); end;";
                cmdGetInfo.Parameters.Add("tt", OracleDbType.Varchar2, tt_IN_K.Value, ParameterDirection.Input);
                cmdGetInfo.Parameters.Add("ms", OracleDbType.Decimal, Convert.ToDecimal(textSUM.Text, nf) * 100, 
                    ParameterDirection.Input);
                cmdGetInfo.Parameters.Add("x", OracleDbType.Decimal, result, ParameterDirection.Output);
                cmdGetInfo.ExecuteNonQuery();

                result = Convert.ToDecimal(Convert.ToString(cmdGetInfo.Parameters["x"].Value),nf) / 100;
                Sum.Text = Convert.ToString(result);

                Decimal sum_t = Convert.ToDecimal(Sum.Text) * 100;
                Commission.Text = CalculateCommission(tt_IN_K.Value,sum_t.ToString());
            }

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
    /// Формування текстів договорів
    /// </summary>
    protected void btFormDocuments_ServerClick(object sender, EventArgs e)
    {
        String[] _templates;

        if (Templates.Value == String.Empty)
        { Response.Write("<script>alert('Не вибрано жодного документу!');</script>"); return; }
        else
        {
            String val = Templates.Value;
            _templates = val.Split(';');
        }

        TechAcc t_acc = new TechAcc(Convert.ToDecimal(textDPT_NUM.Text));
        t_acc.WriteContractText(_templates);
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
}
