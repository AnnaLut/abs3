using System;
using System.Data;
using System.Globalization;
using System.Web.Services;
using System.Web.UI;
using Bars.Classes;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using Bars.Exception;

public partial class DepositTechAcc : Page
{
    /// <summary>
    /// Завантаження сторінки
    /// </summary>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["acc"] == null || Request["rnk"] == null)
            throw new TechAccountsException("Сторінка викликана з некоректними параметрами!");

        if (!IsPostBack)
        {
            FillControls();
        }
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
            cmdGetInfo.CommandText = @"SELECT v.tech_accid,v.tech_accnum, v.tech_currency, 
                TO_CHAR(v.tech_dat_open,'dd/mm/yyyy'),
                TO_CHAR(v.tech_saldo/100,'999999999990.99'), 
                v.tech_custnum, v.tech_customer, v.tech_custid, v.dpt_num,t.kv,
                TO_CHAR(v.tech_dat_end_plan,'DD/MM/YYYY'), v.dpt_id
                FROM v_dpt_tech_accounts v, tabval t
                WHERE v.tech_accid = :acc and v.tech_currency = t.lcv";

            cmdGetInfo.Parameters.Add("acc", OracleDbType.Decimal, Convert.ToDecimal(Request["acc"]), ParameterDirection.Input);

            OracleDataReader rdr = cmdGetInfo.ExecuteReader();

            if (!rdr.Read())
                throw new TechAccountsException("Дані про рахунок acc=" + 
                    Convert.ToString(Request["acc"]) + " не знайдені!");

            if (!rdr.IsDBNull(0))
                acc.Value = Convert.ToString(rdr.GetOracleDecimal(0).Value);
            if (!rdr.IsDBNull(1))
                textNLS.Text = Convert.ToString(rdr.GetOracleString(1).Value);
            if (!rdr.IsDBNull(2))
                textKV.Text = Convert.ToString(rdr.GetOracleString(2).Value);
            if (!rdr.IsDBNull(3))
                textDAT.Text = Convert.ToString(rdr.GetOracleString(3).Value);
            if (!rdr.IsDBNull(4))
                textSUM.Text = Convert.ToString(rdr.GetOracleString(4).Value);
            if (!rdr.IsDBNull(5))
                textRNK.Text = Convert.ToString(rdr.GetOracleDecimal(5).Value);
            if (!rdr.IsDBNull(6))
                textNMK.Text = Convert.ToString(rdr.GetOracleString(6).Value);
            if (!rdr.IsDBNull(7))
                textOKPO.Text = Convert.ToString(rdr.GetOracleString(7).Value);
            if (!rdr.IsDBNull(8))
                textDPT_NUM.Text = Convert.ToString(rdr.GetOracleString(8).Value);
            if (!rdr.IsDBNull(9))
                KV.Value = Convert.ToString(rdr.GetOracleDecimal(9).Value);
            if (!rdr.IsDBNull(10))
                textDateClose.Text = Convert.ToString(rdr.GetOracleString(10).Value);
            if (!rdr.IsDBNull(11))
                dpt_id.Value = Convert.ToString(rdr.GetOracleDecimal(11).Value);

            cmdGetInfo.Parameters.Clear();

            /// Процедура реєстрації документа за вкладом
            String bpp = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE") +
                "@" + "begin dpt_web.fill_dpt_payments(" + dpt_id.Value + ",:REF);end;";
            AfterPay.Value = bpp;

            if (Request["action"] == "close")
            {
                /// прийшов запит на закриття технічного рахунку
                btSurvey.Visible = false;
                btHistory.Visible = false;
                btClose.Visible = true;

                NumberFormatInfo nf = new NumberFormatInfo();
                nf.NumberDecimalSeparator = ".";
                nf.NumberGroupSeparator = " ";

                if (Convert.ToDecimal(textSUM.Text,nf) > 0)
                {
                    btPay.Value = "Виплата залишку";

                    cmdGetInfo.Parameters.Clear();
                    /// вибираємо операцію для виплати залушку
                    cmdGetInfo.CommandText = @"SELECT tt_main
                        FROM v_techacc_operations
                        WHERE op_id = :op_id";
                    cmdGetInfo.Parameters.Add("op_id", OracleDbType.Decimal, 203, ParameterDirection.Input);
                    tt.Value = Convert.ToString(cmdGetInfo.ExecuteScalar());
                    btPay.Attributes["onclick"] = "javascript:ShowDocInput(1)";

                    cmdGetInfo.Parameters.Clear();
                    /// вибираємо операцію для викупу центів
                    cmdGetInfo.CommandText = @"SELECT NVL(TT,'') FROM OP_RULES WHERE val='7' AND tag='DPTOP'";
                    dpf_oper.Value = Convert.ToString(cmdGetInfo.ExecuteScalar());

                    /// Не даємо закрити поки плановий остаток не нуль
                    btClose.Disabled = true;
                }
                else
                {
                    btClose.Disabled = false;
                    btPay.Visible = false;
                    tt.Value = "";
                }
            }
            else if (Request["action"] == "show")
            {
                /// прийшов запит на перегляд картки
                //btSurvey.Visible = false;
                //btFormDocuments.Visible = false;
                //btPrintDocuments.Visible = false;
                //btPay.Visible = false;
                //btClose.Visible = false;
                cmdGetInfo.Parameters.Clear();
                cmdGetInfo.CommandText = @"SELECT tt_comiss
                        FROM v_techacc_operations
                        WHERE op_id = :op_id";
                cmdGetInfo.Parameters.Add("op_id", OracleDbType.Decimal, 195, ParameterDirection.Input);

                tt.Value = Convert.ToString(cmdGetInfo.ExecuteScalar());

                OracleCommand cmdGetKomiss = connect.CreateCommand();
                cmdGetKomiss.CommandText = "select dpt_web.techacc_open_comiss_taken(:p_dptid, 195) from dual";
                cmdGetKomiss.Parameters.Add("p_dptid", OracleDbType.Decimal, dpt_id.Value, ParameterDirection.Input);

                String res = Convert.ToString(cmdGetKomiss.ExecuteScalar());
                if (res.ToUpper() == "Y") btPay.Disabled = true;
            }
            else
            {
                /// прийшов запит на відкриття технічного рахунку
                /// вибираємо операцію для взяття комісії за відкриття
                cmdGetInfo.Parameters.Clear();
                cmdGetInfo.CommandText = @"SELECT tt_comiss
                        FROM v_techacc_operations
                        WHERE op_id = :op_id";
                cmdGetInfo.Parameters.Add("op_id", OracleDbType.Decimal, 195, ParameterDirection.Input);

                tt.Value = Convert.ToString(cmdGetInfo.ExecuteScalar());
                
                btClose.Visible = false;

                OracleCommand cmdGetKomiss = connect.CreateCommand();
                cmdGetKomiss.CommandText = "select dpt_web.techacc_open_comiss_taken(:p_dptid, 195) from dual";
                cmdGetKomiss.Parameters.Add("p_dptid", OracleDbType.Decimal, dpt_id.Value, ParameterDirection.Input);

                String res = Convert.ToString(cmdGetKomiss.ExecuteScalar());
                if (res.ToUpper() == "Y") btPay.Disabled = true;
            }
            
            cmdGetInfo.Parameters.Clear();
            cmdGetInfo.CommandText = @"SELECT c.adr, pa.name, TO_CHAR(p.ser) || ' ' ||  TO_CHAR(p.NUMDOC),
                TO_CHAR(p.ORGAN) || ' ' || TO_CHAR (p.PDATE,'dd/mm/yyyy'),
                TO_CHAR(p.bday,'dd/mm/yyyy'), c.nmk
                FROM  customer c, person p, passp pa
                WHERE c.rnk = :rnk AND c.rnk = p.rnk AND pa.passp = p.passp";
            cmdGetInfo.Parameters.Add("rnk", OracleDbType.Decimal, Convert.ToDecimal(Convert.ToString(Request["rnk"])), ParameterDirection.Input);

            rdr = cmdGetInfo.ExecuteReader();

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

            Decimal sur_type;
            OracleCommand cmdGetSurType = connect.CreateCommand();
            cmdGetSurType.CommandText = "select cust_survey.get_survey_id('SURVTECH') from dual";
            sur_type = Convert.ToDecimal(cmdGetSurType.ExecuteScalar());

            OracleCommand cmdCheckSurvey = connect.CreateCommand();
            cmdCheckSurvey.CommandText = "select cust_survey.fill_up_survey(:rnk,:sur_type) from dual";
            cmdCheckSurvey.Parameters.Add("rnk", OracleDbType.Decimal, Convert.ToDecimal(Convert.ToString(Request["rnk"]))
                , ParameterDirection.Input);
            cmdCheckSurvey.Parameters.Add("sur_type", OracleDbType.Decimal, sur_type, ParameterDirection.Input);

            String res_sur = Convert.ToString(cmdCheckSurvey.ExecuteScalar());
            if (res_sur != "1")
                btSurvey.Visible = false;
            else
                btSurvey.Visible = true;

            if (!rdr.IsClosed) rdr.Close();
            rdr.Dispose();

            cmdGetInfo.Dispose();
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
        { Response.Write("<script>alert('Не вибрано жодного документу!');</script>");return; }
        else
        {
            String val = Templates.Value;
            _templates = val.Split(';');
        }

        TechAcc t_acc = new TechAcc(Convert.ToDecimal(dpt_id.Value));
        t_acc.WriteContractText(_templates);
    }
    /// <summary>
    /// Закриття технічного рахунку
    /// </summary>
    protected void btClose_ServerClick(object sender, EventArgs e)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();
         
            OracleCommand cmdDeleteTechAcc = connect.CreateCommand();
            cmdDeleteTechAcc.CommandText = "BEGIN dpt_web.p_techacc_close(1,:acc,bankdate,:branch,null); END;";
            cmdDeleteTechAcc.Parameters.Add("acc", OracleDbType.Decimal,
                Convert.ToDecimal(Convert.ToString(Request["acc"])), ParameterDirection.Input);
            cmdDeleteTechAcc.Parameters.Add("branch", OracleDbType.Varchar2,
                Convert.ToString(Request["branch"]), ParameterDirection.Input);

            cmdDeleteTechAcc.ExecuteNonQuery();
            
            FillControls();
            btClose.Disabled = true;

            String script = "<script>alert('Технічний рахунок " + textNLS.Text + " успішно закритий');</script>";
            Response.Write(script);
            Response.Flush();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    [WebMethod(EnableSession = true)]
    public static string GetOstB(String acc)
    {
        OracleConnection connect = new OracleConnection();
        Decimal result;

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdGetInfo = connect.CreateCommand();
            cmdGetInfo.CommandText = "select ostb from saldo where acc = :acc";
            cmdGetInfo.Parameters.Add("acc", OracleDbType.Decimal, acc, ParameterDirection.Input);
            result = Convert.ToDecimal(Convert.ToString(cmdGetInfo.ExecuteScalar()));
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

        return result.ToString();
    }
    [WebMethod(EnableSession = true)]
    public static string GetOstC(String acc)
    {
        OracleConnection connect = new OracleConnection();
        Decimal result;

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdGetInfo = connect.CreateCommand();
            cmdGetInfo.CommandText = "select ostc from saldo where acc = :acc";
            cmdGetInfo.Parameters.Add("acc", OracleDbType.Decimal, acc, ParameterDirection.Input);
            result = Convert.ToDecimal(Convert.ToString(cmdGetInfo.ExecuteScalar()));
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

        return result.ToString();
    }
    [WebMethod(EnableSession = true)]
    public static string KomissPaid(String dpt_id)
    {
        OracleConnection connect = new OracleConnection();
        String result;

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdGetKomiss = connect.CreateCommand();
            cmdGetKomiss.CommandText = "select dpt_web.techacc_open_comiss_taken(:p_dptid, 195) from dual";
            cmdGetKomiss.Parameters.Add("p_dptid", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);

            result = Convert.ToString(cmdGetKomiss.ExecuteScalar());
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

        return result;
    }
}
