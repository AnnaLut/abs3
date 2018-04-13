using System;
using System.Data;
using System.Globalization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Classes;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using Bars.Exception;
using Bars.Logger;

public partial class Transfer : Bars.BarsPage
{
    /// <summary>
    /// Завантаження сторінки
    /// </summary>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request["dpt_id"] == null || Request["cash"] == null)
                throw new DepositException("Сторінка викликана з некоректними параметрами!");

            DPT_ID.Value = Convert.ToString(Request["dpt_id"]);

            cash.Value = (Request["cash"] == "1" ? "1" : "0");

            dpf_oper.Value = BankType.GetDpfOper(Convert.ToDecimal(Request["dpt_id"]));

            //if (BankType.GetDptBankType() == BANKTYPE.UPB)
            //{
            //    before_pay.Value = String.Empty;
            //}
            //else
            //{
                before_pay.Value = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE") +
                "@" + "declare l_out number; begin dpt_charge_interest(" + Request["dpt_id"] + ",l_out,1);end;";
            //}

            if (Request["cash"] == "1")
            {
                if (Request["owner"] == "H")
                {
                    Sum.Enabled = false;
                }
                Commission.Enabled = false;
            }
            else
            {
                if ((BankType.GetDptBankType() == BANKTYPE.SBER) && (Request.QueryString["tt"] == "DPO" || Request.QueryString["tt"] == "USV" || Request.QueryString["tt"] == "USG"))
                {
                    // Виначка Ощадбанку для перерахувань SWIFT на АВАЛЬ
                    btPay.Visible = false;
                    btnPay.Visible = true;
                }
                else
                {
                    Commission.Enabled = false;
                    tbTransferInfo.Visible = true;
                    //Sum.Attributes["onblur"] = "javascript:CalculateCommission()";
                    //textMFO_B.Attributes["onblur"] = "javascript:CalculateMaxSum()";
                }
            }

            if (Request["action"] == "return")
            {
                rbMain.Checked = true;
                rbPercent.Checked = false;
            }
            else if (Request["action"] == "percent")
            {
                rbPercent.Checked = true;
                rbMain.Checked = false;
            }            

            // Метали
            Bars.Metals.DepositMetals.ClearData();

            // Заповнюємо інформацію для оплати
            FillControls(true);
        }
 else
        {
            // Метали
            Bars.Metals.DepositMetals.ClearData();
            //fvBankMetals.DataSource = null;
           // fvBankMetals.DataBind();
            FillControls(false);
        }
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
                if (Request["rnk_tr"] != null)
                {
                    cmdGetInfo.CommandText = @"SELECT c.adr, pa.name, TO_CHAR(p.ser) || ' ' ||  TO_CHAR(p.NUMDOC),
                        TO_CHAR(p.ORGAN) || ' ' || TO_CHAR (p.PDATE,'dd/mm/yyyy'),
                        TO_CHAR(p.bday,'dd/mm/yyyy'), c.nmk, c.rnk
                        FROM  customer c, person p, passp pa
                        WHERE c.rnk = :rnk AND c.rnk = p.rnk AND pa.passp = p.passp";

                    cmdGetInfo.Parameters.Add("rnk", OracleDbType.Decimal, Convert.ToDecimal(Convert.ToString(Request["rnk_tr"])), ParameterDirection.Input);
                }
                else
                {
                    cmdGetInfo.CommandText = @"SELECT c.adr, pa.name, TO_CHAR(p.ser) || ' ' ||  TO_CHAR(p.NUMDOC),
                        TO_CHAR(p.ORGAN) || ' ' || TO_CHAR (p.PDATE,'dd/mm/yyyy'),
                        TO_CHAR(p.bday,'dd/mm/yyyy'), c.nmk, c.rnk
                        FROM  customer c, person p, passp pa, dpt_deposit d
                        WHERE d.deposit_id = :dpt_id and c.rnk = d.rnk AND c.rnk = p.rnk AND pa.passp = p.passp";

                    cmdGetInfo.Parameters.Add("dpt_id", OracleDbType.Decimal, Convert.ToDecimal(Convert.ToString(Request["dpt_id"])), ParameterDirection.Input);
                }

                rdr = cmdGetInfo.ExecuteReader();

                if (!rdr.Read())
                    throw new SocialDepositException("Дані про клієнта rnk=" +
                        Convert.ToString(Request["rnk_tr"]) + " не знайдені!");

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
                if (!rdr.IsDBNull(6))
                    textRNK.Text = Convert.ToString(rdr.GetOracleDecimal(6).Value);

                cmdGetInfo.Parameters.Clear();
            }

            Deposit.ChargeInterest(Convert.ToDecimal(Request["dpt_id"]));

            if (rbMain.Checked)
            {
                cmdGetInfo.CommandText = @"select dpt_accnum, dpt_curcode,
                   TO_CHAR(dpt_saldo/100,'999999999990.99'),
                   cust_id, cust_name, cust_idcode, 
                   dpt_num, dpt_curid, 
                   bars_context.extract_mfo(branch_id),
                   dpt_cur_denom       
                   from v_dpt_portfolio_active 
                   where dpt_id = :contract_id";
          // Метали
                Bars.Metals.DepositMetals.ClearData();

            }
            else if (rbPercent.Checked)
            {
                cmdGetInfo.CommandText = @"select int_accnum, int_curcode,                   
                   nvl(TO_CHAR(int_saldo_pl/100,'999999999990.99'),'0.00'),
                   cust_id, cust_name, cust_idcode, 
                   dpt_num, dpt_curid, 
                   bars_context.extract_mfo(branch_id),
                   int_saldo_pl,
                   dpt_cur_denom 
                   from " + ((Convert.ToString(Request["other"]) == "Y") ? "v_dpt_portfolio_other " : "v_dpt_portfolio_active ") +
                 " where dpt_id = :contract_id";
             // Метали
                Bars.Metals.DepositMetals.ClearData();

            }
            cmdGetInfo.Parameters.Add("contract_id", OracleDbType.Decimal, 
                Convert.ToDecimal(Request["dpt_id"]), ParameterDirection.Input);

            rdr = cmdGetInfo.ExecuteReader();

            if (!rdr.Read())
                throw new SocialDepositException("Дані про договір id=" + Request.QueryString["dpt_id"] + " не знайдені!");

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

 
            if (rbPercent.Checked)
            {
                Decimal int_saldo_pl = 0;

                if (!rdr.IsDBNull(9))
                {
                    int_saldo_pl = rdr.GetOracleDecimal(9).Value;
                }

                if (!rdr.IsDBNull(10))
                {
                    denom.Value = Convert.ToString(rdr.GetOracleDecimal(10).Value);
                }

                cmdGetInfo.CommandText = "begin dpt_web.get_intpayoff_amount(:p_dptid, :p_amount); end;";

                cmdGetInfo.Parameters.Clear();
                cmdGetInfo.Parameters.Add("p_dptid", OracleDbType.Decimal, 
                    Convert.ToDecimal(Request["dpt_id"]), ParameterDirection.Input);

                cmdGetInfo.Parameters.Add("p_amount", OracleDbType.Decimal,
                    int_saldo_pl, ParameterDirection.Input);

                cmdGetInfo.ExecuteNonQuery();

                Sum.Text = (Convert.ToDecimal(Convert.ToString(cmdGetInfo.Parameters[1].Value)) / 100).ToString("000000000.00");
                maxSUM.Value = Sum.Text;
            }
            else
            {
                Sum.Text = textSUM.Text;
                maxSUM.Value = Sum.Text;

                if (!rdr.IsDBNull(9))
                {
                    denom.Value = Convert.ToString(rdr.GetOracleDecimal(9).Value);
                }

            }

            #region METALS
            // Вклади у БАНКІВСЬКИХ МЕТАЛАХ:
            if (KV.Value == "959" || KV.Value == "961" || KV.Value == "962")
            {
                // сума формується на основі опису злитків
                metalParameters.Visible = true;
                Sum.Text = "0";
                Sum.ReadOnly = true;
                /*
                // депозити розміщаються і виплачуються тільки через поточні рахунки
                if (dpt.EndDate == DateTime.MinValue)
                {
                    TT.Value = dpt.GetTT(DPT_OP.OP_1, CASH.YES);
                }
                else
                {
                    TT.Value = dpt.GetTT(DPT_OP.OP_1, CASH.NO);
                }
                 * */
            }
            else
            {
                Sum.ReadOnly = false;
                //TT.Value = dpt.GetTT(DPT_OP.OP_1, CASH.YES);
            }
            #endregion
            DBLogger.Info("KV.Value = " + KV.Value, "deposit");


            cmdGetInfo.Parameters.Clear();

            /// Одержуємо коди операцій
            GetTts(Convert.ToDecimal(Request["dpt_id"]));            

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
    private void GetTts(Decimal dpt_id)
    {
        tt.Value = Convert.ToString(Request["tt"]);
        tt_OUT.Value = Convert.ToString(Request["tt"]);
        tt_IN.Value = Convert.ToString(Request["tt"]);

        //Decimal kv_id = Convert.ToDecimal(KV.Value);

        //if (rbMain.Checked)
        //{
        //    /// Виплата готівкою
        //    tt.Value = Deposit.GetDptTT(DPT_OP.OP_21, kv_id);
        //    /// Переказ по міжбанку
        //    tt_OUT.Value = Deposit.GetDptTT(DPT_OP.OP_26, kv_id);

        //    tt_IN.Value = Deposit.GetDptTT(DPT_OP.OP_23, kv_id);
        //}
        //else if (rbPercent.Checked)
        //{
        //    /// Виплата готівкою
        //    tt.Value = Deposit.GetDptTT(DPT_OP.OP_3, kv_id);
        //    /// Переказ по міжбанку
        //    tt_OUT.Value = Deposit.GetDptTT(DPT_OP.OP_46, kv_id);

        //    tt_IN.Value = Deposit.GetDptTT(DPT_OP.OP_43, kv_id);
        //}
    }

    /// <summary>
    /// Безготівкова виплата на банк АВАЛЬ (для Ощадбанку)
    /// </summary>
    protected void btnPay_Click(object sender, EventArgs e)
    {

        Decimal den = Convert.ToDecimal(denom.Value);
        Decimal sum = Convert.ToDecimal(Sum.Text);

        sum = Math.Round(sum * den);

        if (sum < 1)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, Page.GetType(), "Error",
                "alert('Неможливо здійснити операцію з нульовою сумою!');", true);
        }
        else
        {
            String url = "/barsroot/DocInput/DocInput.aspx?";

            url += "tt=" + tt.Value;
            url += "&nd=" + DPT_ID.Value;
	        url += "&Nls_A=" + textNLS.Text;
	        url += "&Kv_A=" + KV.Value;	        	    
	        
            /*
	        url += "&Mfo_B=" + textMFO_B.Text;
            url += "&Nls_B=" + textNLS_B.Text;
            url += "&Kv_B=" + KV.Value;
		    url += "&Nam_B=" + textNMS_B.Text;
		    url += "&Id_B="	+ textOKPO_B.Text;		    
            */
            
            url += "&SumC_t=" + sum.ToString();
            url += "&Nazn=" + textNAZN.Text;
            url += "&RNK=" + textRNK.Text;

            /*
	        if (rbMain.Checked)
            {
	            url += "&BPROC=" + before_pay.Value;
	        }
            */
            Random r = new Random();

            url += "&code=" + r.Next();
            
            url = "window.showModalDialog('" + url + "',null,'dialogWidth:650px; dialogHeight:800px; center:yes; status:no');";

            ScriptManager.RegisterClientScriptBlock(this.Page, Page.GetType(), "DocInput", url, true);

            // DisableControls
            if (tbTransferInfo.Visible)
            {
                textMFO_B.Enabled = false;
                textNLS_B.Enabled = false;
                textNMS_B.Enabled = false;
                textOKPO_B.Enabled = false;
                textNAZN.Enabled = false;
            }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    protected void btForm_Click(object sender, EventArgs e)
    {
        Deposit.WriteContractTextExt(Convert.ToDecimal(DPT_ID.Value), 15);
    }
    
    /// <summary>
    /// Закрити поточний рахунок
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btClose_Click(object sender, EventArgs e)
    {
        DBLogger.Info("Користувач натиснув кнопку \"Закрити договір\"  №" + DPT_ID.Value + " на сторінці Виплата коштів з поточного рахунку.", "deposit");

        if (Deposit.Close(Convert.ToDecimal(DPT_ID.Value)))
            Response.Write("<script>alert('Заявка на закриття успішно сформована');</script>");
        else
            Response.Write("<script>alert('Договір закривати заборонено');</script>");
    }

    protected void btPrint_Click(object sender, EventArgs e)
    {
        Session["DPTPRINT_DPTID"] = DPT_ID.Value;
        Session["DPTPRINT_AGRID"] = 15;
        Session["DPTPRINT_AGRNUM"] = -1;
        Session["DPTPRINT_TEMPLATE"] = "DPT_ADD_POTOCHN_CLOS";

        Response.Write(@"<script>
            var url = 'DepositPrint.aspx?code=' + Math.random();
	        window.showModalDialog(url,null,
	        'dialogWidth:800px; dialogHeight:800px; center:yes; status:no');		
        </script>");
    }
    protected void btPrintReport_Click(object sender, EventArgs e)
    {
        if (KV.Value == "980")
            Response.Redirect("/barsroot/cbirep/rep_query.aspx?repid=701&codeapp=WDPT&Param0=" + Request["dpt_id"]);
        else
            Response.Redirect("/barsroot/cbirep/rep_query.aspx?repid=702&codeapp=WDPT&Param0=" + Request["dpt_id"]);
    }

    /// <summary>
    /// Формування сум (в унціях та грамах) поповнення депозиту на основі інфр. про злитки
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvBankMetals_DataBound(object sender, EventArgs e)
    {
        Sum.Text = Bars.Metals.DepositMetals.SumOunce().ToString();
        SumGrams.Value = Convert.ToString(Bars.Metals.DepositMetals.Sum());
        METAL.Value = Bars.Metals.DepositMetals.TagValueMETAL().ToString();
        DBLogger.Info("METAL=" + METAL.Value);
    }

    //*************************
    //*** Робота з FormView ***
    //*************************

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void fvBankMetals_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        gvBankMetals.DataBind();
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void fvBankMetals_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        gvBankMetals.DataBind();
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void fvBankMetals_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        gvBankMetals.DataBind();
    }

    /// <summary>
    /// Заповнення значення поля проба металу "по замовчуванню"
    /// PreRender
    /// </summary>
    /// <param name="sender">об'єст</param>
    /// <param name="e">подія</param>
    protected void PROBA_I_PreRender(object sender, EventArgs e)
    {
        TextBox PROBA_I = (sender as TextBox);

        if (String.IsNullOrEmpty(PROBA_I.Text))
        {
            PROBA_I.Text = "999.9";
        }
    }
}
