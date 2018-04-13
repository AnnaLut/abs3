using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Bars.Logger;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using System.Globalization;
using Bars.DocHand;
using Bars.Exception;
using Bars.Classes;
using Oracle.DataAccess.Types;

/// <summary>
/// 
/// </summary>
public partial class DepositClosePayIt : Bars.BarsPage
{
    /// <summary>
    /// Загрузка формы
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void Page_Load(object sender, System.EventArgs e)
    {
        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositClosePayIt;

        if (Request["dpt_id"] == null)
            Response.Redirect("DepositSearch.aspx?action=close&extended=0");
        else
            textDepositNumber.Text = Convert.ToString(Session["DPT_NUM"]);
        
        if (Request["tt"] == null)
            Response.Redirect("DepositSelectTT.aspx?dest=close&dpt_id=" + Convert.ToString(Request["dpt_id"]));
        else
            tt.Value = Convert.ToString(Request["tt"]);

        if (Deposit.InheritedDeal(Convert.ToString(Request["dpt_id"])) && (Request["inherit_id"] == null))
            throw new DepositException("Дана функція заблокована. По депозитному договору є зареєстровані спадкоємці. Скористайтесь функцією \"Реєстрація свідоцтв про право на спадок\".");

        textNLS.Attributes["onblur"] = "javascript:doValueCheck(\"textNLS\");";
        textMFO.Attributes["onblur"] = "javascript:doValueCheck(\"textMFO\");";
        textOKPO.Attributes["onblur"] = "javascript:doValueCheck(\"textOKPO\");";
        textNLS.Attributes["onblur"] += "javascript:chkAccount(\"textNLS\",\"textMFO\");";
        btPay.Attributes["onclick"] = "javascript:if (CheckSum('MaxSum','SumToPay',false) && Valid(2))";

        btPayPercent.Attributes["onclick"] = "javascript:if (!Valid(0)) return false;";
        ckFullPay.Attributes["onclick"] = "javascript:enableSum();";
        btShtraf.Attributes["onclick"] = "javascript:if (CheckSum('MaxSum','SumToPay',false))";

        RegisterEventScript();
        
        dpt_id.Value = Convert.ToString(Request["dpt_id"]);
        
        if (!IsPostBack)
        {
            Deposit dpt;

            if (BankType.GetCurrentBank() == BANKTYPE.UPB)
            {
                Boolean other = ((Convert.ToString(Request["other"]) == "Y") ? true : false);

                dpt = new Deposit(Convert.ToDecimal(dpt_id.Value), other);
            }
            else
            {
                dpt = new Deposit(Convert.ToDecimal(dpt_id.Value));
            }

            int result = CkTTS(dpt);

            // Через касу
            if (result == 1)
            {
                textNLS.Enabled = false;
                textMFO.Enabled = false;
                textOKPO.Enabled = false;
                textNMK.Enabled = false;
            }
            // Внутрібанк
            else if (result == 3)
            {
                textMFO.Enabled = false;
            }

            /// Виплата не через касу заборонена
            //if ((result != 1) && (Request["inherit_id"] != null))
            //    throw new DepositException("Виплата не через касу заборонена!");

            /// Виплата на міжбанк заборонена -- COBUSUPABS-2772 спадкоємцям можна виплачувати на міжбанк, перевірку прибрали.
           // if ((result == 2) && (Request["inherit_id"] != null))
          //      throw new DepositException("Виплата на міжбанк заборонена!");

            CheckIfEnabled();

            FillControls(true, -1, -1, -1);

            /// Процедура реєстрації документа за вкладом
            String bpp = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE") +
                "@" + "begin dpt_web.fill_dpt_payments(" + Request.QueryString["dpt_id"] + ",:REF);end;";

            if (Request["agr_id"] != null)
            {
                tbShtraf.Visible = false; ;
                btShtraf.Disabled = true;
                btPay.Disabled = false;

                String BeforePayProc = String.Empty;
                IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];

                String rolecmd = conn.GetSetRoleCommand("DPT_ROLE");

                BeforePayProc += rolecmd + "@";
                /// Платіж по налу
                if (result == 1)
                    BeforePayProc += "declare " +
                    "agr_id dpt_agreements.agrmnt_id%type; " +
                    "begin " +
                    "dpt_web.create_agreement " +
                      "(" + Convert.ToString(Request["dpt_id"]) +
                      "," + Convert.ToString(Request["agr_id"]) +
                      "," + (Request["rnk_tr"] == null ? rnk.Value : Convert.ToString(Request["rnk_tr"])) +
                      ",null,null,null,null,#,null,null,null,null,null,null,null,null,null,null,:REF,null, " +
                      "agr_id); dpt_web.fill_dpt_payments(" + Request["dpt_id"] + ",:REF);" +
                    "end;";
                /// Платіж по безналу
                else
                    BeforePayProc += "declare " +
                    "agr_id dpt_agreements.agrmnt_id%type; " +
                    "begin " +
                    "dpt_web.create_agreement " +
                      "(" + Convert.ToString(Request["dpt_id"]) +
                      "," + Convert.ToString(Request["agr_id"]) +
                      "," + (Request["rnk_tr"] == null ? rnk.Value : Convert.ToString(Request["rnk_tr"])) +
                      ",null,null,null,null,null,#,null,null,null,null,null,null,null,null,null,:REF,null, " +
                      "agr_id); dpt_web.fill_dpt_payments(" + Request["dpt_id"] + ",:REF);" +
                    "end;";

                AfterPay.Value = BeforePayProc;
            }
            else if (BankType.GetCurrentBank() == BANKTYPE.PRVX ||
                     BankType.GetCurrentBank() == BANKTYPE.SBER)
            {
                AfterPay.Value = bpp;
                /// для виплати центів
                bpp_4_cent.Value = bpp;

                if (Deposit.InheritedDeal(dpt.ID.ToString()))
                {
                  ////////////////////////////////////////////////////////////////////////
                  // BAA - закоментарив у зв'язку з відміною утримання податку банками  //
                  ////////////////////////////////////////////////////////////////////////
                  //
                  //  BeforePay.Value = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE") +
                  //  "@" + "begin dpt_web.inherit_payment ( " + Request["dpt_id"] + ", " + Request["inherit_id"] + ", :l_taxref_in); if :l_taxref_in is not null then dpt_web.fill_dpt_payments(" + Request["dpt_id"] + ",:l_taxref_in); end if; end;";
                  //
                  //  AfterPay.Value = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE") +
                  //  "@" + "declare l_ref oper.ref%type := :REF; l_taxref oper.ref%type := :TAXREF; begin dpt_web.fill_dpt_payments(" + Request["dpt_id"] + ",l_ref); UPDATE oper SET refl = l_taxref WHERE ref = l_ref; end;";
                    
                    AfterPay.Value = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE") +
                    "@" + "declare l_ref oper.ref%type := :REF; begin dpt_web.fill_dpt_payments(" + Request["dpt_id"] + ",l_ref); end;";
                }
            }

            ///	Для УПБ
            if (BankType.GetCurrentBank() == BANKTYPE.UPB)
            {
                if (NoShtrafEnabled())
                    btNoShtraf.Visible = true;
                else
                    btNoShtraf.Visible = false;

                if (to_be_called_for.Value == "1")
                {
                    SumToPay.Enabled = true;
                    SumToPay.ReadOnly = false;
                    ckFullPay.Checked = false;
                    ckFullPay.Enabled = true;
                }
                else
                {
                    ckFullPay.Enabled = false;
                    ckFullPay.Checked = true;
                    SumToPay.ReadOnly = true;
                }
            }
            /// Якщо ми вернулися з вибраною операцією по ви
            else if (Request.QueryString["dest"] == "closep")
            {
                SumToPay.Enabled = false;
                ckFullPay.Enabled = false;
                btPrint.Disabled = true;
                btShtraf.Disabled = true;
                btPay.Disabled = true;
                btCancel.Enabled = false;
                btPayPercent.Enabled = true;
            }
        }
    }
    /// <summary>
    /// Локализация DataGrid
    /// </summary>
    protected override void OnPreRender(EventArgs evt)
    {
        // Локализируем infrag
        DateR.ToolTip = Resources.Deposit.GlobalResources.tb33;
        DepositSum.ToolTip = Resources.Deposit.GlobalResources.tb41;
        PercentSum.ToolTip = Resources.Deposit.GlobalResources.tb42;
        PercentRate.ToolTip = Resources.Deposit.GlobalResources.tb43;
        ShtrafRate.ToolTip = Resources.Deposit.GlobalResources.tb44;
        allPercentSum.ToolTip = Resources.Deposit.GlobalResources.tb45;
        ShtrafPercentSum.ToolTip = Resources.Deposit.GlobalResources.tb46;
        ShtrafSum.ToolTip = Resources.Deposit.GlobalResources.tb47;
        KomissionSum.ToolTip = Resources.Deposit.GlobalResources.tb48;
        SumToPay.ToolTip = Resources.Deposit.GlobalResources.tb49;
        MaxSum.ToolTip = Resources.Deposit.GlobalResources.tb50;
    }
    #region Web Form Designer generated code
    override protected void OnInit(EventArgs e)
    {
        //
        // CODEGEN: This call is required by the ASP.NET Web Form Designer.
        //
        InitializeComponent();
        base.OnInit(e);
    }

    /// <summary>
    /// Required method for Designer support - do not modify
    /// the contents of this method with the code editor.
    /// </summary>
    private void InitializeComponent()
    {
        this.btNoShtraf.Click += new System.EventHandler(this.btNoShtraf_Click);
        this.btCancel.Click += new System.EventHandler(this.btCancel_Click);
        this.btPayPercent.Click += new System.EventHandler(this.btPayPercent_Click);
        this.btShtraf.ServerClick += new System.EventHandler(this.btShtraf_ServerClick);
        this.btPay.ServerClick += new System.EventHandler(this.btPay_ServerClick);
        ;

    }
    #endregion
    /// <summary>
    /// Нажатие кнопки "Отмена"
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>  
    private void btCancel_Click(object sender, System.EventArgs e)
    {
        DBLogger.Info("Пользователь нажал кнопку \"Отмена\" на странице выплаты депозита до завершения. Номер депозита " + Convert.ToString(Request["dpt_id"]),
            "deposit");

        Response.Redirect("../barsweb/Welcome.aspx");
    }
    /// <summary>
    /// Заполнение контролов
    /// </summary>
    private void FillControls(bool getShtraf, decimal sum2pay, decimal perc2pay, decimal p_int2pay_ing)
    {
        if (Request["dpt_id"] == null)
            Response.Redirect("DepositSearch.aspx?action=close&extended=1");
        
        Deposit dpt;

        if (BankType.GetCurrentBank() == BANKTYPE.UPB)
        {
            Boolean other = ((Convert.ToString(Request["other"]) == "Y") ? true : false);

            dpt = new Deposit(Convert.ToDecimal(dpt_id.Value), other);
        }
        else
        {
            dpt = new Deposit(Convert.ToDecimal(dpt_id.Value));
        }
        
        to_be_called_for.Value = (dpt.EndDate == DateTime.MinValue ? "1" : "0");

        // Ознака виклику перший раз
        if (sum2pay < 0)
        {
            OracleConnection connect = new OracleConnection();
            try
            {
                // Открываем соединение с БД
                IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
                connect = conn.GetUserConnection();


                // Устанавливаем роль
                OracleCommand cmdSetRole = connect.CreateCommand();
                cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
                cmdSetRole.ExecuteNonQuery();

                if (BankType.GetCurrentBank() == BANKTYPE.PRVX ||
                         BankType.GetCurrentBank() == BANKTYPE.SBER)
                {
                    Decimal sur_type = 1;
                    OracleCommand cmdGetSurType = connect.CreateCommand();
                    cmdGetSurType.CommandText = "select cust_survey.get_survey_id('SURVPENY') from dual";
                    sur_type = Convert.ToDecimal(cmdGetSurType.ExecuteScalar());

                    OracleCommand cmdCheckSurvey = connect.CreateCommand();
                    cmdCheckSurvey.CommandText = "select cust_survey.fill_up_survey(:rnk,:sur_type) from dual";
                    cmdCheckSurvey.Parameters.Add("rnk", OracleDbType.Decimal, dpt.Client.ID, ParameterDirection.Input);
                    cmdCheckSurvey.Parameters.Add("sur_type", OracleDbType.Decimal, sur_type, ParameterDirection.Input);

                    String res_sur = Convert.ToString(cmdCheckSurvey.ExecuteScalar());
                    if (res_sur != "1")
                        btSurvey.Visible = false;
                    else
                    {
                        btSurvey.Visible = true;
                    }
                }
                ///  Без анкет
                else
                    btSurvey.Visible = false;

                if ((BankType.GetCurrentBank() == BANKTYPE.UPB) && getShtraf && (dpt.EndDate != DateTime.MinValue))
                {
                    OracleCommand ckPercent = connect.CreateCommand();
                    ckPercent.CommandText = "SELECT * FROM OPLDOK o,DPT_DEPOSIT d, INT_ACCN I WHERE D.DEPOSIT_ID = :DPT_ID AND D.ACC = I.ACC AND O.ACC = I.ACRA AND O.SOS NOT IN (-1,5)";
                    ckPercent.Parameters.Clear();
                    ckPercent.Parameters.Add("DPT_ID", OracleDbType.Decimal, dpt.ID, ParameterDirection.Input);

                    OracleDataReader upb2_rdr = ckPercent.ExecuteReader();

                    if (upb2_rdr.Read())
                    {
                        throw new DepositException("По рахунку відсотків депозиту №" + dpt.ID.ToString()
                            + " є незавізовані проводки!  Довізуйте проводки та повторіть операцію.");
                    }

                    upb2_rdr.Close(); upb2_rdr.Dispose();
                }

                dpf_oper.Value = BankType.GetDpfOper(dpt.ID);

                DepositType.Text = dpt.TypeName;
                PercentRate.ValueDecimal = dpt.RealIntRate;
                Kv.Value = dpt.Currency.ToString();
                textClientName.Text = dpt.Client.Name;
                textClientPasp.Text = dpt.Client.DocTypeName + " " + dpt.Client.DocSerial + " " + 
                    dpt.Client.DocNumber + " " + dpt.Client.DocOrg;
                DateR.Text = dpt.Client.BirthDate.ToString("dd/MM/yyyy");

                if (Request["rnk_tr"] != null)
                {
                    DBLogger.Info("Договор расторгать(делать частичное снятие) пришло довереное лицо." +
                        "РНК = " + Convert.ToString(Request["rnk_tr"]), "deposit");

                    rnk.Value = Convert.ToString(Request["rnk_tr"]);
                }
                else
                    rnk.Value = Convert.ToString(dpt.Client.ID);

              //  SetPayAccounts(dpt);//перенесено в кінець процедури(в залежності від суми рахунок може бути каса або поточний)

                DepositSum.Value = dpt.dpt_f_sum;
                dptCurrency.Text = dpt.CurrencyISO;
                denom.Value = dpt.Sum_denom.ToString();
                PercentSum.Value = dpt.perc_f_sum;
                Nls_A.Value = dpt.dpt_nls;
                Decimal percent_acc = dpt.perc_acc;
                p_nls.Value = dpt.perc_nls;

                if (dpt.Sum_denom == 1000)
                {
                    DepositSum.MinDecimalPlaces = Infragistics.WebUI.WebDataInput.MinDecimalPlaces.Three;
                    PercentSum.MinDecimalPlaces = Infragistics.WebUI.WebDataInput.MinDecimalPlaces.Three;
                    allPercentSum.MinDecimalPlaces = Infragistics.WebUI.WebDataInput.MinDecimalPlaces.Three;
                    ShtrafPercentSum.MinDecimalPlaces = Infragistics.WebUI.WebDataInput.MinDecimalPlaces.Three;
                    ShtrafSum.MinDecimalPlaces = Infragistics.WebUI.WebDataInput.MinDecimalPlaces.Three;
                    MaxSum.MinDecimalPlaces = Infragistics.WebUI.WebDataInput.MinDecimalPlaces.Three;
                    SumToPay.MinDecimalPlaces = Infragistics.WebUI.WebDataInput.MinDecimalPlaces.Three;
                }

                cmdSetRole.ExecuteNonQuery();

                if ((Request["agr_id"] != null || dpt.EndDate == DateTime.MinValue) && getShtraf)
                    MaxSum.ValueDecimal = DepositSum.ValueDecimal;

                //if (Request["agr_id"] != null && getShtraf)
                //    MaxSum.ValueDecimal = DepositSum.ValueDecimal - dpt.GetViddMinSum() / denom;

                if (Request["agr_id"] == null && getShtraf && dpt.EndDate != DateTime.MinValue)
                {
                    MaxSum.ValueDecimal = DepositSum.ValueDecimal;

                    // Decimal p_int = Decimal.MinValue;

                    String addition = String.Empty;

                    if (BankType.GetCurrentBank() == BANKTYPE.PRVX || BankType.GetCurrentBank() == BANKTYPE.SBER)
                        addition = "	SELECT bankdate, bars_context.extract_mfo(a.BRANCH), a.BRANCH, ";
                    else if (BankType.GetCurrentBank() == BANKTYPE.UPB)
                        addition = "	SELECT bankdate, f_ourmfo, null, ";

                    OracleCommand cmdGetShtrafRate = connect.CreateCommand();
                    cmdGetShtrafRate.CommandText = "select nvl(dpt.f_shtraf_rate(:dpt_id,bankdate),0) from dual";
                    cmdGetShtrafRate.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt.ID, ParameterDirection.Input);

                    ShtrafRate.ValueDecimal = Convert.ToDecimal(cmdGetShtrafRate.ExecuteScalar());

                    PercentSum.ValueDecimal = dpt.perc_f_sum;

                    OracleCommand cmdGetShtrafInfo = connect.CreateCommand();
                    cmdGetShtrafInfo.CommandText = "begin " +
                        "dpt_web.global_penalty (:p_dptid, bankdate, :p_fullpay, null, 'RO', " +
                        ":p_penalty, :p_commiss, :p_commiss2, :p_dptrest, :p_intrest, :p_int2pay_ing); " +
                    "end;";

                    /// Сума штрафу
                    Decimal p_penalty = Decimal.MinValue;
                    /// Сума комісії за РКО
                    Decimal p_commiss = Decimal.MinValue;
                    /// Сума комісії за прийом вітхих купюр
                    Decimal p_commiss2 = Decimal.MinValue;
                    /// Сума депозиту до виплати
                    Decimal p_dptrest = Decimal.MinValue;
                    /// Сума відсотків до виплати
                    Decimal p_intrest = Decimal.MinValue;

                    cmdGetShtrafInfo.Parameters.Add("p_dptid", OracleDbType.Decimal, dpt.ID, ParameterDirection.Input);
                    cmdGetShtrafInfo.Parameters.Add("p_fullpay", OracleDbType.Decimal,
                        (Request["agr_id"] == null ? 1 : 0), ParameterDirection.Input);
                    cmdGetShtrafInfo.Parameters.Add("p_penalty", OracleDbType.Decimal, p_penalty, ParameterDirection.Output);
                    cmdGetShtrafInfo.Parameters.Add("p_commiss", OracleDbType.Decimal, p_commiss, ParameterDirection.Output);
                    cmdGetShtrafInfo.Parameters.Add("p_commiss2", OracleDbType.Decimal, p_commiss2, ParameterDirection.Output);
                    cmdGetShtrafInfo.Parameters.Add("p_dptrest", OracleDbType.Decimal, p_dptrest, ParameterDirection.Output);
                    cmdGetShtrafInfo.Parameters.Add("p_intrest", OracleDbType.Decimal, p_intrest, ParameterDirection.Output);
                    cmdGetShtrafInfo.Parameters.Add("p_int2pay_ing", OracleDbType.Decimal, p_int2pay_ing, ParameterDirection.Output);

                    cmdGetShtrafInfo.ExecuteNonQuery();
	
		        //  DBLogger.Info(Convert.ToString(cmdGetShtrafInfo.Parameters["p_int2pay_ing"].Value));

                    if (String.IsNullOrEmpty(Convert.ToString(cmdGetShtrafInfo.Parameters["p_int2pay_ing"].Value)) ||
                        Convert.ToString(cmdGetShtrafInfo.Parameters["p_int2pay_ing"].Value) == "null")
                        p_int2pay_ing = 0;
                    else
                    {
                        try
                        {
                            p_int2pay_ing= ((OracleDecimal)cmdGetShtrafInfo.Parameters["p_int2pay_ing"].Value).Value / dpt.Sum_denom;
                        }
                        catch (InvalidCastException)
                        {
                            p_int2pay_ing= 0;
                        }
                    }


                    if (String.IsNullOrEmpty(Convert.ToString(cmdGetShtrafInfo.Parameters["p_penalty"].Value)) ||
                        Convert.ToString(cmdGetShtrafInfo.Parameters["p_penalty"].Value) == "null")
                        p_penalty = 0;
                    else
                    {
                        try
                        {
                            p_penalty = ((OracleDecimal)cmdGetShtrafInfo.Parameters["p_penalty"].Value).Value / dpt.Sum_denom;
                        }
                        catch (InvalidCastException)
                        {
                            p_penalty = 0;
                        }
                    }
                    if (String.IsNullOrEmpty(Convert.ToString(cmdGetShtrafInfo.Parameters["p_commiss"].Value)) ||
                        Convert.ToString(cmdGetShtrafInfo.Parameters["p_commiss"].Value) == "null")
                        p_commiss = 0;
                    else
                    {
                        try
                        {
                            p_commiss = ((OracleDecimal)cmdGetShtrafInfo.Parameters["p_commiss"].Value).Value / dpt.Sum_denom;
                        }
                        catch (InvalidCastException)
                        {
                            p_commiss = 0;
                        }
                    }
                    if (String.IsNullOrEmpty(Convert.ToString(cmdGetShtrafInfo.Parameters["p_commiss2"].Value)) ||
                        Convert.ToString(cmdGetShtrafInfo.Parameters["p_commiss2"].Value) == "null")
                        p_commiss2 = 0;
                    else
                    {
                        try
                        {
                            p_commiss2 = ((OracleDecimal)cmdGetShtrafInfo.Parameters["p_commiss2"].Value).Value / dpt.Sum_denom;
                        }
                        catch (InvalidCastException)
                        {
                            p_commiss2 = 0;
                        }
                    }
                    if (String.IsNullOrEmpty(Convert.ToString(cmdGetShtrafInfo.Parameters["p_dptrest"].Value)) ||
                        Convert.ToString(cmdGetShtrafInfo.Parameters["p_dptrest"].Value) == "null")
                        p_dptrest = 0;
                    else
                    {
                        try
                        {
                            p_dptrest = ((OracleDecimal)cmdGetShtrafInfo.Parameters["p_dptrest"].Value).Value / dpt.Sum_denom;
                        }
                        catch (InvalidCastException)
                        {
                            p_dptrest = 0;
                        }
                    }
                    if (String.IsNullOrEmpty(Convert.ToString(cmdGetShtrafInfo.Parameters["p_intrest"].Value)) ||
                        Convert.ToString(cmdGetShtrafInfo.Parameters["p_intrest"].Value) == "null")
                        p_intrest = 0;
                    else
                    {
                        try
                        {
                            p_intrest = ((OracleDecimal)cmdGetShtrafInfo.Parameters["p_intrest"].Value).Value / dpt.Sum_denom;
                        }
                        catch (InvalidCastException)
                        {
                            p_intrest = 0;
                        }
                    }

                    ShtrafSum.ValueDecimal = p_penalty - p_int2pay_ing;
                    ShtrafPercentSum.ValueDecimal = p_int2pay_ing;

                    allPercentSum.ValueDecimal = p_penalty + p_intrest;
                    KomissionSum.ValueDecimal = p_commiss;
                    InCassoSum.Value = p_commiss2;
                    MaxSum.ValueDecimal = p_dptrest;
                }

                if (Request["agr_id"] == null)
                {
                    ckFullPay.Checked = true;
                    ckFullPay.Enabled = false;
                    SumToPay.Enabled = false;

                    // Збочення для Ощадбанку (виплата часки суми депозиту при достроковому поверненні)
                    if (Deposit.AccountIsCash(textNLS.Text, Kv.Value) == "1")
                    {
                        ckFullPay.Checked = false;
                        SumToPay.Enabled = true;
                    }

                    if (dpt.EndDate == DateTime.MinValue)
                    {
                        tbShtraf.Visible = false;
                        btShtraf.Disabled = true;
                        btPay.Disabled = false;
                    }
                }

                SumToPay.ValueDecimal = MaxSum.ValueDecimal;

                //встановлення рахунків виплати
                SetPayAccounts(dpt);
                ISCASH.Value = Deposit.AccountIsCash(textNLS.Text, dpt.Currency.ToString());
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                { connect.Close(); connect.Dispose(); }
            }
        }
        // Виклик після постбеку
        else if (sum2pay >= 0)
        {
            SumToPay.Enabled = false;
            SumToPay.ValueDecimal = sum2pay / dpt.Sum_denom;
            MaxSum.ValueDecimal = SumToPay.ValueDecimal;
            ShtrafPercentSum.ValueDecimal = perc2pay / dpt.Sum_denom;
	    allPercentSum.ValueDecimal = p_int2pay_ing/ dpt.Sum_denom;
        }

        if (Request["inherit_id"] != null)
        {
            perc_dpt_acc.Value = dpt.perc_acc.ToString();
            rnk.Value = Convert.ToString(Request["inherit_id"]);

            if (Convert.ToString(Request["dest"]) != "closep")
            {
                //Decimal? tax_value = Deposit.InheritTax(dpt.ID.ToString(),
                //    Convert.ToString(Request["inherit_id"]), dpt.Sum_denom);

                MaxSum.ValueDecimal = Deposit.InheritRest(dpt.ID.ToString(),
                    Convert.ToString(Request["inherit_id"]), dpt.dpt_acc.ToString(), dpt.Sum_denom);
                //    - (tax_value.HasValue ? tax_value.Value : 0);


                SumToPay.ValueDecimal = MaxSum.ValueDecimal;
            }
            else
            {
                MaxSum.ValueDecimal = 0;
                SumToPay.ValueDecimal = 0;
            }
        }
    }
    /// <summary>
    /// Установка счетов выплаты
    /// </summary>
    private void SetPayAccounts(Deposit dpt)
    {
        int result = CkTTS(dpt);
        
        if (Request["dest"] == null)
        {
            if ( result != 1 && (dpt.RestReceiverAccount != string.Empty || dpt.RestReceiverMFO != string.Empty))
            {
                if (Deposit.CheckTT((Decimal)DPT_OP.OP_25, Convert.ToString(Request["tt"]), dpt.ID))
                {
                    if (Deposit.AccountIsCard(dpt.RestReceiverMFO, dpt.RestReceiverAccount))
                    {
                        textNLS.Text = dpt.RestReceiverAccount;
                        textMFO.Text = dpt.RestReceiverMFO;
                        textNMK.Text = dpt.RestReceiverName;
                        textOKPO.Text = dpt.RestReceiverOKPO;
                        textNLS.Enabled = false;
                        textMFO.Enabled = false;
                        textNMK.Enabled = false;
                        textOKPO.Enabled = false;
                    }
                    else
                    {
                        textNLS.Text = String.Empty;
                        textMFO.Text = String.Empty;
                        textOKPO.Text = String.Empty;
                        textNMK.Text = String.Empty;
                    }
                }
                else if (Deposit.CheckTT((Decimal)DPT_OP.OP_23, Convert.ToString(Request["tt"]), dpt.ID))
                {
                    if (!Deposit.AccountIsCard(dpt.RestReceiverMFO, dpt.RestReceiverAccount))
                    {
                        textNLS.Text = dpt.RestReceiverAccount;
                        textMFO.Text = dpt.RestReceiverMFO;
                        textNMK.Text = dpt.RestReceiverName;
                        textOKPO.Text = dpt.RestReceiverOKPO;
                        textNLS.Enabled = false;
                        textMFO.Enabled = false;
                        textNMK.Enabled = false;
                        textOKPO.Enabled = false;
                    }
                    else
                    {
                        textNLS.Text = String.Empty;
                        textMFO.Text = String.Empty;
                        textOKPO.Text = String.Empty;
                        textNMK.Text = String.Empty;
                    }
                }
                
            }
            else if (Deposit.CheckTT((Decimal)DPT_OP.OP_35, Convert.ToString(Request["tt"]), dpt.ID))
            {
               
               if (get_nls(SumToPay.ValueDecimal, dpt.Currency))
                {
                    textNLS.Enabled = false;
                    textMFO.Enabled = false;
                    textNMK.Enabled = false;
                    textOKPO.Enabled = false;
                }
                else
                {
                    textNLS.Text = String.Empty;
                    textMFO.Text = String.Empty;
                    textOKPO.Text = String.Empty;
                    textNMK.Text = String.Empty;

                }
            }
            else
            {
                MFO.Value = BankType.GetOurMfo();

                if (!textMFO.Enabled)
                    textMFO.Text = MFO.Value;
            }
        }
        else
        {
            if (result != 1 && (dpt.IntReceiverAccount != string.Empty || dpt.IntReceiverMFO != string.Empty))
            {
                if (Deposit.CheckTT((Decimal)DPT_OP.OP_45, Convert.ToString(Request["tt"]), dpt.ID))
                {
                    if (Deposit.AccountIsCard(dpt.IntReceiverMFO, dpt.IntReceiverAccount))
                    {
                        textNLS.Text = dpt.IntReceiverAccount;
                        textMFO.Text = dpt.IntReceiverMFO;
                        textOKPO.Text = dpt.IntReceiverOKPO;
                        textNMK.Text = dpt.IntReceiverName;
                        textNLS.Enabled = false;
                        textMFO.Enabled = false;
                        textOKPO.Enabled = false;
                        textNMK.Enabled = false;
                    }
                    else
                    {
                        textNLS.Text = String.Empty;
                        textMFO.Text = String.Empty;
                        textOKPO.Text = String.Empty;
                        textNMK.Text = String.Empty;
                    }
                }
                else if (Deposit.CheckTT((Decimal)DPT_OP.OP_43, Convert.ToString(Request["tt"]), dpt.ID))
                {
                    if (!Deposit.AccountIsCard(dpt.IntReceiverMFO, dpt.IntReceiverAccount))
                    {
                        textNLS.Text = dpt.IntReceiverAccount;
                        textMFO.Text = dpt.IntReceiverMFO;
                        textOKPO.Text = dpt.IntReceiverOKPO;
                        textNMK.Text = dpt.IntReceiverName;
                        textNLS.Enabled = false;
                        textMFO.Enabled = false;
                        textOKPO.Enabled = false;
                        textNMK.Enabled = false;
                    }
                    else
                    {
                        textNLS.Text = String.Empty;
                        textMFO.Text = String.Empty;
                        textOKPO.Text = String.Empty;
                        textNMK.Text = String.Empty;
                    }
                }
            }
        }
    }
    /// <summary>
    /// Нажатие кнопки "Выплатить вклад"
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
       private void btPay_ServerClick(object sender, System.EventArgs e)
    {
        DBLogger.Info("Пользователь нажал на кнопку \"Выплатить вклад\" на странице выплаты депозита до завершения. Номер депозита " + Convert.ToString(Request["dpt_id"]),
            "deposit");

        /*if (BankType.GetCurrentBank() == BANKTYPE.PRVX ||
                     BankType.GetCurrentBank() == BANKTYPE.SBER)
        {
	    
            if (Request["agr_id"] == null && ShtrafPercentSum.ValueDecimal <= 0)
		{
		DBLogger.Info("fffff4 " + ShtrafPercentSum.ToString());
                Response.Redirect("DepositCloseComplete.aspx?dpt_id=" + Convert.ToString(Request["dpt_id"]));
		}

            string url = "depositselecttt.aspx?dpt_id=" + Convert.ToString(Request["dpt_id"]);
            if (Request["agr_id"] != null)
                url += "&agr_id=" + Convert.ToString(Request["agr_id"]);
            if (Request["next"] != null)
                url += "&next=" + Convert.ToString(Request["next"]);
            if (Request["template"] != null)
                url += "&template=" + Convert.ToString(Request["template"]);
            if (Request["rnk_tr"] != String.Empty)
                url += "&rnk_tr=" + Convert.ToString(Request["rnk_tr"]);
            if (Request["inherit_id"] != null)
                url += "&inherit_id=" + Convert.ToString(Request["inherit_id"]);

            url += "&dest=closep";

            Response.Redirect(url);

            //btPay.Disabled = true;
            //btPayPercent.Enabled = true;
            //btCancel.Enabled = false;
            //SumToPay.Enabled = false;
            //ckFullPay.Enabled = false;
        }
        else */if (PercentSum.ValueDecimal + allPercentSum.ValueDecimal > 0)
        {
	    DBLogger.Info("Переход на выбор операции по выплате процентов");
            btPay.Disabled = true;
            btPayPercent.Enabled = true;
            btCancel.Enabled = false;
            SumToPay.Enabled = false;
            ckFullPay.Enabled = false;

		string url = "depositselecttt.aspx?dpt_id=" + Convert.ToString(Request["dpt_id"]);
            if (Request["agr_id"] != null)
                url += "&agr_id=" + Convert.ToString(Request["agr_id"]);
            if (Request["next"] != null)
                url += "&next=" + Convert.ToString(Request["next"]);
            if (Request["template"] != null)
                url += "&template=" + Convert.ToString(Request["template"]);
            if (Request["rnk_tr"] != String.Empty)
                url += "&rnk_tr=" + Convert.ToString(Request["rnk_tr"]);
            if (Request["inherit_id"] != null)
                url += "&inherit_id=" + Convert.ToString(Request["inherit_id"]);

            url += "&dest=closep";

            Response.Redirect(url);
        }
        else
	{
	    DBLogger.Info("Выход, сумма процентов к выплате нуль");
            Response.Redirect("DepositCloseComplete.aspx?dpt_id=" + Convert.ToString(Request["dpt_id"]));
	}
    }
    /// <summary>
    /// Для УПБ - снятие без штрафования
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void btNoShtraf_Click(object sender, System.EventArgs e)
    {
        DBLogger.Info("ВНИМАНИЕ!!!Пользователь выбрал расторжение депозитного договора №" +
            Convert.ToString(Request["dpt_id"]) + " БЕЗ штрафования!",
            "deposit");

        btCancel.Enabled = false;
        btNoShtraf.Enabled = false;
        btShtraf.Disabled = true;
        btPay.Disabled = false;
    }
    /// <summary>
    /// Нажатие кнопки "Штрафовать"
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void btShtraf_ServerClick(object sender, System.EventArgs e)
    {
        DBLogger.Info("Пользователь нажал кнопку \"Штрафовать\" на странице выплаты депозита до завершения. Номер депозита " + Convert.ToString(Request["dpt_id"]),
            "deposit");

        btCancel.Enabled = false;
        btShtraf.Disabled = true;
        btNoShtraf.Enabled = false;
        btPay.Disabled = false;

        if (Request["dpt_id"] == null)
            Response.Redirect("DepositSearch.aspx?action=close&extended=1");

        Decimal dpt_id = Convert.ToDecimal(Request["dpt_id"].ToString());
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdShtraf = connect.CreateCommand();
            cmdShtraf.CommandText = "begin dpt_web.penalty_payment(:dpt_id,:sum, :dpt_rest, :perc_rest, :p_int2pay_ing); end;";

            cmdShtraf.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
            cmdShtraf.Parameters.Add("sum", OracleDbType.Decimal, ShtrafSum.ValueDecimal * 
                (ShtrafSum.MinDecimalPlaces == Infragistics.WebUI.WebDataInput.MinDecimalPlaces.Three ? 1000 : 100),
                ParameterDirection.Input);
            
            Decimal sum2pay = Decimal.MinValue;
            Decimal perc2pay = Decimal.MinValue;
	    Decimal p_int2pay_ing = Decimal.MinValue;
            cmdShtraf.Parameters.Add("dpt_rest", OracleDbType.Decimal, sum2pay, ParameterDirection.Output);
            cmdShtraf.Parameters.Add("perc_rest", OracleDbType.Decimal, perc2pay, ParameterDirection.Output);
            cmdShtraf.Parameters.Add("p_int2pay_ing", OracleDbType.Decimal, p_int2pay_ing, ParameterDirection.Output);


            if (textDtEnd.Value != String.Empty)
                cmdShtraf.ExecuteNonQuery();

            String str_tmp = Convert.ToString(cmdShtraf.Parameters["dpt_rest"].Value);
            if (String.IsNullOrEmpty(str_tmp) || str_tmp.ToUpper() == "NULL")
                sum2pay = -1;
            else
                sum2pay = Convert.ToDecimal(
                    Convert.ToString(cmdShtraf.Parameters["dpt_rest"].Value));

            str_tmp = Convert.ToString(cmdShtraf.Parameters["perc_rest"].Value);
            if (String.IsNullOrEmpty(str_tmp) || str_tmp.ToUpper() == "NULL")
                perc2pay = -1;
            else
                perc2pay = Convert.ToDecimal(
                    Convert.ToString(cmdShtraf.Parameters["perc_rest"].Value));

	    str_tmp = Convert.ToString(cmdShtraf.Parameters["p_int2pay_ing"].Value);
            if (String.IsNullOrEmpty(str_tmp) || str_tmp.ToUpper() == "NULL")
                p_int2pay_ing= -1;
            else
                p_int2pay_ing= Convert.ToDecimal(
                    Convert.ToString(cmdShtraf.Parameters["p_int2pay_ing"].Value));

            FillControls(false, sum2pay, perc2pay, p_int2pay_ing);

            // Збочення для Ощадбанку (виплата часки суми депозиту при достроковому поверненні)
            if (Deposit.AccountIsCash(textNLS.Text, Kv.Value) == "1")
            {
                SumToPay.Enabled = true;
            }
            else
            {
                SumToPay.Enabled = false;
            }

            //Random r = new Random();
            //String dop_rec = "&RNK=" + Convert.ToString(rnk.Value) +
            //    "&Code=" + Convert.ToString(r.Next());

            ////String dop_rec = "&FIO=" + Convert.ToString(NMK.Value) +
            ////    "&PASP=" + Convert.ToString(PASP.Value) + "&PASPN=" + Convert.ToString(PASPN.Value) +
            ////    "&ATRT=" + Convert.ToString(ATRT.Value) + "&ADRES=" + Convert.ToString(ADRES.Value) +
            ////    "&DT_R=" + Convert.ToString(DT_R.Value);

            //String url = "\"/barsroot/DocInput/DocInput.aspx?tt=K08&nd=" + dpt_id
            //    + "&SumC_t=" + Math.Round(KomissionSum.ValueDecimal * 100).ToString() + dop_rec + 
            //    "&APROC=" + OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE") +
            //     "@" + "begin dpt_web.fill_dpt_payments(" + dpt_id + ",:REF);end;" + "\"";

            //String script = "<script>window.showModalDialog(encodeURI(" + url + "),null," +
            //    "'dialogWidth:700px; dialogHeight:800px; center:yes; status:no');</script>";

            //if (BankType.GetCurrentBank() == BANKTYPE.PRVX)
            //{
            //    Response.Write(script);
            //    Response.Flush();
            //}
        btPrint.Disabled = true; // Inga Pavlenko 16/06/2014
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
    /// <param name="kv"></param>
    /// <param name="sum"></param>
    /// <returns></returns>
    private Decimal ckDPF(Decimal kv, Decimal sum)
    {
        if (dpf_oper.Value == String.Empty)
            return 0;

        if (kv == 980)
            return 0;
        
        if (kv == 978)
            return sum % 500;
        
        if (kv == 840)
            return sum % 100;

        if (kv == 643)
            return sum % 500;

        // золото - викуп унцій до 20 гр.зливка (0.643 або 0.64 унції)
        if (kv == 959)
        {
            if (denom.Value == "1000")
                return sum % 643;
            else
                return sum % 64;
        }

        // срібло - викуп унцій до 100 гр. зливку (3.215 або 3.22 унції)
        else if (kv == 961)
        {
            if (denom.Value == "1000")
                return sum % 3215;
            else
                return sum % 322;
        }

        if (denom.Value == "1000")
            return sum % 1000;

        return 0;
    }
    /// <summary>
    /// Виплата відсотків
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void btPayPercent_Click(object sender, System.EventArgs e)
    {
        btPay.Disabled = true;
        btPayPercent.Enabled = false;
        btCancel.Enabled = false;
        SumToPay.Enabled = false;
        ckFullPay.Enabled = false;
        textNLS.Enabled = false;
        textNMK.Enabled = false;
        textOKPO.Enabled = false;
        textMFO.Enabled = false;

        Decimal dpt_id = Convert.ToDecimal(Request["dpt_id"]);
        
        Deposit dpt;

        if (BankType.GetCurrentBank() == BANKTYPE.UPB)
        {
            Boolean other = ((Convert.ToString(Request["other"]) == "Y") ? true : false);

            dpt = new Deposit(dpt_id, other);
        }
        else
        {
            dpt = new Deposit(dpt_id);
        }

        if (Request["agr_id"] != null)
        {
            Decimal agr_id = Convert.ToDecimal(Request["agr_id"]);
            Decimal PercentToPay = Decimal.MinValue;

            string dest = "'DepositAgreementPrint.aspx?dpt_id=" + dpt_id +
                "&agr_id=" + Request["agr_id"].ToString() +
                "&template=" + Request["template"];
            if (Request["rnk_tr"] != null)
                dest += "&rnk_tr=" + Convert.ToString(Request["rnk_tr"]);
            dest += "'";

            OracleConnection connect = new OracleConnection();
            try
            {
                DBLogger.Info("Пользователь выплатил проценты при частичном снятии со вклада на странице выплаты депозита до завершения. Номер депозита " + Convert.ToString(Request["dpt_id"]),
                    "deposit");

                // Открываем соединение с БД
                IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
                connect = conn.GetUserConnection();
                

                // Устанавливаем роль
                OracleCommand cmdSetRole = connect.CreateCommand();
                cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
                cmdSetRole.ExecuteNonQuery();

                OracleCommand cmd = connect.CreateCommand();
                cmd.CommandText = @"select amount_interest 
                    from dpt_agreements
                    where DPT_ID = :dpt_id and AGRMNT_TYPE = :agr_type
                    order by AGRMNT_NUM desc ";
                cmd.Parameters.Add("DPT_ID", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
                cmd.Parameters.Add("agr_type", OracleDbType.Decimal, Convert.ToString(Request["agr_id"]), ParameterDirection.Input);

                String result = Convert.ToString(cmd.ExecuteScalar());

                if (result == String.Empty)
                {
                    Response.Write("<script>alert('" + Resources.Deposit.GlobalResources.al17 + "');</script>");
                    //Response.Write("<script>alert('Оплатите операцию!');</script>");
                    btPay.Disabled = false;
                    Response.Flush();
                    return;
                }

                PercentToPay = Convert.ToDecimal(result);

                if (PercentToPay > 0)
                {
                    String sum_str = Convert.ToString(PercentToPay);

                    Random r = new Random();
                    String dop_rec = "&RNK=" + Convert.ToString(rnk.Value) +
                        "&Code=" + Convert.ToString(r.Next());

                    String url = String.Empty;

                    url = "\"/barsroot/DocInput/DocInput.aspx?tt=" + Convert.ToString(Request["tt"]) +
                    "&nd=" + dpt_id +
                    "&Kv_A=" + Convert.ToString(Kv.Value) +
                    "&Nls_A=" + Convert.ToString(p_nls.Value) +
                    "&Nls_B=" + textNLS.Text +
                    "&Mfo_B=" + textMFO.Text +
                    "&Id_B=" + textOKPO.Text +
                    "&Nam_B=\" + escape('" + textNMK.Text + "') + \"&SumC_t=" + sum_str + dop_rec + 
                    "&APROC=" + OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE") +
                    "@" + "begin dpt_web.fill_dpt_payments(" + dpt_id + ",:REF); end;" + "\"";

                    string script = "<script>window.showModalDialog(encodeURI(" + url + "),null," +
                        "'dialogWidth:700px; dialogHeight:800px; center:yes; status:no');";

                    if (Deposit.AccountIsCash(textNLS.Text,Kv.Value) == "1")
                    {
                        if ((PercentToPay = ckDPF(Convert.ToDecimal(Kv.Value), PercentToPay)) > 0)
                        {
                            sum_str = Convert.ToString(PercentToPay);

                            string url_new = "\"/barsroot/DocInput/DocInput.aspx?tt=" + Convert.ToString(dpf_oper.Value) +
                                "&nd=" + dpt_id +
                                "&Kv_A=" + Convert.ToString(Kv.Value) + "&Kv_B=980&SumA_t=" + sum_str + dop_rec +
                                "&APROC=" + OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE") +
                                "@" + "begin dpt_web.fill_dpt_payments(" + dpt_id + ",:REF); end;" + "\"";
                            
                            script += "window.showModalDialog(encodeURI(" + url_new + "),null," +
                                "'dialogWidth:700px; dialogHeight:800px; center:yes; status:no');";
                        }
                    }

                    script += "location.replace(" + dest + ");";

                    script += "</script>";
                    Response.Write(script);
                    Response.Flush();
                }
                else
                {
                    //String msg = "По сумме снятия процентов начислено не было!";
                    String script = "<script>alert('" + Resources.Deposit.GlobalResources.al18 + "');location.replace(" + dest + ");";

                    script += "</script>";
                    Response.Write(script);
                    Response.Flush();
                }
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                { connect.Close(); connect.Dispose(); }
            }
        }
        else
        {
            String dest = "'DepositCloseComplete.aspx?dpt_id=" + Convert.ToString(Request["dpt_id"]) + "'";
            String script = "<script>";
            Decimal mSum = Decimal.MinValue;

            if (tbShtraf.Visible == true)
            {
                mSum = dpt.perc_p_sum * dpt.Sum_denom;
            }
            else
                mSum = Math.Round(PercentSum.ValueDecimal * dpt.Sum_denom);


            if (Request["inherit_id"] != null)
            {
                mSum = Deposit.InheritRest(Convert.ToString(Request["dpt_id"]),
                    Convert.ToString(Request["inherit_id"]), perc_dpt_acc.Value, dpt.Sum_denom) * dpt.Sum_denom;
            }

            if (mSum > 0)
            {
                DBLogger.Info("Пользователь выплатил проценты при досрочном расторжении вклада на странице выплаты депозита до завершения. Номер депозита " + 
                    Request.QueryString["dpt_id"], "deposit");

                String sum_str = Convert.ToString(mSum);

                Random r = new Random();
                String dop_rec = "&RNK=" + Convert.ToString(rnk.Value) + "&Code=" + Convert.ToString(r.Next());

                String url = String.Empty;

                url = "\"/barsroot/DocInput/DocInput.aspx?tt=" + Convert.ToString(Request["tt"]) +
                "&nd=" + dpt_id.ToString() +
                "&Kv_A=" + Convert.ToString(Kv.Value) +
                "&Nls_A=" + Convert.ToString(p_nls.Value) +
                "&Nls_B=" + textNLS.Text +
                "&Mfo_B=" + textMFO.Text +
                "&Id_B=" + textOKPO.Text +
                "&Nam_B=\" +'" + textNMK.Text +
                "' + \"&SumC_t=" + sum_str + dop_rec + 
                "&APROC=" + OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE") +
                "@ begin dpt_web.fill_dpt_payments(" + dpt_id + ", :REF); end;" + "\"";

                //if (Request["inherit_id"] != null)
                //    url += "&BPROC=" +  Uri.EscapeDataString(OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE") +
                //    "@" + "declare l_ref oper.ref%type := :REF; l_taxref oper.ref%type := null; begin dpt_web.inherit_payment ( " + Request["dpt_id"] + ", " + Request["inherit_id"] + ", l_taxref); UPDATE oper SET refl = l_taxref WHERE ref = l_ref; end;");

                script += "window.showModalDialog(encodeURI(" + url + "),null," +
                    "'dialogWidth:700px; dialogHeight:800px; center:yes; status:no');";

                Decimal dpf = Decimal.MinValue;
                if (Deposit.AccountIsCash(textNLS.Text, Kv.Value) == "1")
                {
                    if ((dpf = ckDPF(Convert.ToDecimal(Kv.Value), mSum)) > 0)
                    {
                        sum_str = Convert.ToString(dpf);

                        string url_new = "\"/barsroot/DocInput/DocInput.aspx?tt=" + Convert.ToString(dpf_oper.Value)
                            + "&nd=" + dpt_id
                            + "&Kv_A=" + Convert.ToString(Kv.Value) + "&Kv_B=980&SumA_t=" + sum_str + dop_rec +
                            "&APROC=" + OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE") +
                            "@" + "begin dpt_web.fill_dpt_payments(" + dpt_id + ",:REF);end;" + "\"";

                        script += "window.showModalDialog(encodeURI(" + url_new + "),null," +
                            "'dialogWidth:700px; dialogHeight:800px; center:yes; status:no');";
                    }
                }
            }
            /// Ексклюзивно для Маршавіної нікуди не переходимо
            if ((BankType.GetCurrentBank() != BANKTYPE.UPB) && (Request["inherit_id"] == null))
                script += "location.replace(" + dest + ");";

            script += "</script>";
            Response.Write(script);
            Response.Flush();
        }
    }
    /// <summary>
    /// Перевірка операції виплати відсотків
    /// </summary>
    /// <returns>
    /// 1 - касова
    /// 2 - міжбанк
    /// 3 - внутрібанк
    /// </returns>
    public int CkTTS(Deposit dpt)
    {
        string tt_name = Convert.ToString(Request["tt"]);

        OracleConnection connect = new OracleConnection();

        try
        {
            // Открываем соединение с БД
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            
            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdSearch = connect.CreateCommand();
            cmdSearch.CommandText = "select nlsb, fli, flv, kv, kvk, dk, substr(flags,60,1), mfob from tts where tt=:tt";
            cmdSearch.Parameters.Add("tt", OracleDbType.Varchar2, tt_name, ParameterDirection.Input);

            OracleDataReader rdr = cmdSearch.ExecuteReader();

            if (!rdr.Read())
            {
                throw new DepositException("Недопустима операція: " + tt_name);
            }

            String nlsb = String.Empty;
            Decimal fli_t = Decimal.Zero;
            Decimal flv_t = Decimal.Zero;
            String dk = String.Empty;
            String convert = String.Empty;
            String mfob = String.Empty;

            if (!rdr.IsDBNull(0))
                nlsb = Convert.ToString(rdr.GetOracleString(0).Value);
            if (!rdr.IsDBNull(1))
                fli_t = Convert.ToDecimal(rdr.GetOracleDecimal(1).Value);
            if (!rdr.IsDBNull(2))
                flv_t = Convert.ToDecimal(rdr.GetOracleDecimal(2).Value);
            if (!rdr.IsDBNull(3))
                Kv.Value = Convert.ToString(rdr.GetOracleDecimal(3).Value);
            if (!rdr.IsDBNull(4))
                kvk.Value = Convert.ToString(rdr.GetOracleDecimal(4).Value);
            if (!rdr.IsDBNull(5))
                dk = Convert.ToString(rdr.GetOracleDecimal(5).Value);
            if (!rdr.IsDBNull(6))
                convert = Convert.ToString(rdr.GetOracleString(6).Value);
            if (!rdr.IsDBNull(7))
                mfob = Convert.ToString(rdr.GetOracleString(7).Value);

            rdr.Close();

            cmdSearch.Parameters.Clear();
            cmdSearch.CommandText = "select '20'||to_char(bankdate,'yyMMdd') from dual";
            String bDate = Convert.ToString(cmdSearch.ExecuteScalar());

            if (string.Empty != kvk.Value && string.Empty != Kv.Value)
            {
                string[] rates = GetXRate(Kv.Value, kvk.Value, bDate);
                if (convert == "1")
                {
                    if ("0" == dk || "2" == dk)
                        CrossRat.Value = rates[2];
                    else
                        CrossRat.Value = rates[1];
                }
                else
                    CrossRat.Value = rates[0];

                CrossRat.Value = Convert.ToString(Convert.ToDecimal(CrossRat.Value));
            }

            nlsb = EvalAcc(nlsb);

            if (nlsb != String.Empty)
            {
                textNLS.Text = nlsb;

                if (Deposit.AccountIsCard(nlsb))
                {
                    textNLS.Text = dpt.IntReceiverAccount;
                    textMFO.Text = dpt.IntReceiverMFO;
                    textNMK.Text = dpt.IntReceiverName;
                    textOKPO.Text = dpt.IntReceiverOKPO;
                }
                else if (fli_t == 1)
                {
                    textMFO.Text = mfob;
                    textNMK.Text = dpt.Client.Name;
                    textOKPO.Text = dpt.Client.Code;
                }
                else
                {
                    OracleCommand cmdAccInfo = connect.CreateCommand();
                    cmdAccInfo.CommandText = "select s.kf,c.okpo,c.nmk from accounts s,customer c,cust_acc ca where s.acc=ca.acc and ca.rnk = c.rnk and s.nls = :nls";
                    cmdAccInfo.Parameters.Add("nls", OracleDbType.Varchar2, nlsb, ParameterDirection.Input);
                    OracleDataReader accRdr = cmdAccInfo.ExecuteReader();

                    if (!accRdr.Read())
                        throw new DepositException("Інформація про рахунок " + nlsb + " не знайдена!");

                    if (!accRdr.IsDBNull(0))
                        textMFO.Text = accRdr.GetOracleString(0).Value;
                    if (!accRdr.IsDBNull(1))
                        textOKPO.Text = accRdr.GetOracleString(1).Value;
                    if (!accRdr.IsDBNull(2))
                        textNMK.Text = accRdr.GetOracleString(2).Value;

                    accRdr.Close();
                    accRdr.Dispose();
                }
            }

            fli.Value = Convert.ToString(fli_t);
            flv.Value = Convert.ToString(flv_t);

            if (Deposit.AccountIsCash(nlsb, dpt.Currency.ToString()) == "1")
                return 1;
            else if (fli_t == 1)
                return 2;
            else
                return 3;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }

    private bool get_nls(Decimal i_Sum, Decimal i_kv)
    {
        Decimal dpt_id = Convert.ToDecimal(Request.QueryString["dpt_id"]);

        OracleConnection connect = new OracleConnection();
        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdSearch = connect.CreateCommand();
            cmdSearch.CommandText = "select GL.P_ICURVAL(:p_kv,:p_sum,gl.bd()) from dual";
            cmdSearch.Parameters.Add("p_kv", OracleDbType.Decimal, i_kv, ParameterDirection.Input);
            cmdSearch.Parameters.Add("p_sum", OracleDbType.Decimal, i_Sum, ParameterDirection.Input);

            OracleDataReader rdr = cmdSearch.ExecuteReader();

            if (!rdr.Read())
            {
                return false;
            }
            Decimal sum_980 = Decimal.MinValue;
            if (!rdr.IsDBNull(0))
                sum_980 = Convert.ToDecimal(rdr.GetOracleDecimal(0).Value);

            //DBLogger.Info("nlsb = " + sum_980.ToString() , "deposit");

            rdr.Close();

            cmdSearch.Parameters.Clear();

            if (sum_980 > 150000)
            {
                btSetAcc.Disabled = false;//даємо можливіть вибору рахунку
                cmdSearch.CommandText = "select nls,nmk,mfo,okpo " +
                        " from (  " +
                        " SELECT T2.NLS, T3.NMK, substr(T2.BRANCH,2,6) as mfo, T3.OKPO  " +
                        "  FROM dpt_deposit t1, accounts t2, customer t3  " +
                        " WHERE t1.deposit_id = :dpt_id AND t1.rnk = t2.rnk and t2.nbs in (2620,2625) and T2.KV = 980 and T2.DAZS is null and t1.rnk = t3.rnk and t2.BRANCH = sys_context('bars_context','user_branch')) " +
                        " where rownum=1";
                cmdSearch.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
            }
            else
            {
                //btSetAcc.Disabled = false;
                cmdSearch.CommandText = "select t1.nls, t2.nmk, substr(T1.BRANCH,2,6), T2.OKPO  " +
                 "from accounts t1, customer t2   " +
                 "where t1.nls = (select BRANCH_USR.GET_BRANCH_PARAM2('CASH',0) from dual) and t1.kv = 980 and t2.rnk = t1.rnk";
            }

            rdr = cmdSearch.ExecuteReader();

            if (!rdr.Read())
            {
                return false;
            }

            String nlsb = String.Empty;
            String mfob = String.Empty;
            String nmk = String.Empty;
            String okpo = String.Empty;
            if (!rdr.IsDBNull(0))
                nlsb = Convert.ToString(rdr.GetOracleString(0).Value);
            if (!rdr.IsDBNull(1))
                nmk = Convert.ToString(rdr.GetOracleString(1).Value);
            if (!rdr.IsDBNull(2))
                mfob = Convert.ToString(rdr.GetOracleString(2).Value);
            if (!rdr.IsDBNull(3))
                okpo = Convert.ToString(rdr.GetOracleString(3).Value);

            //    DBLogger.Info("nlsb = " + nlsb, "deposit");

            textMFO.Text = mfob;
            textNMK.Text = nmk;
            textOKPO.Text = okpo;
            textNLS.Text = nlsb;
            rdr.Close();

            return true;
        }
        catch (Exception ex)
        {
            DBLogger.Info("Exception nlsb=" + ex.Message, "deposit");
        }
        finally
        {
            // rdr.Close();
            // rdr.Dispose();
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }

        return false;
    }
    
    /// <summary>
    /// Обчислення рахунків, заданих формулами
    /// </summary>
    /// <param name="NLS">Формула</param>
    /// <returns>Результат</returns>
    private String EvalAcc(String NLS)
    {
        OracleConnection con = new OracleConnection();
        IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
        string result = String.Empty;

        try
        {
            con = conn.GetUserConnection(Context);

            OracleCommand cmd = con.CreateCommand();

            cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
            cmd.ExecuteNonQuery();

            string formula = string.Empty;
            string text = string.Empty;

            cmd.CommandText = "begin doc_strans(:text_,:res_);end;";

            if (NLS.StartsWith("#"))
            {
                formula = NLS.Remove(0, 1);

                text = "select " + formula + " from dual";

                cmd.Parameters.Add("text_", OracleDbType.Varchar2, text, ParameterDirection.Input);
                cmd.Parameters.Add("res_", OracleDbType.Decimal, null, ParameterDirection.Output);

                cmd.ExecuteNonQuery();

                result = Convert.ToString(cmd.Parameters["res_"].Value);
            }
            else
                result = NLS;
        }
        finally
        {
            con.Close();
        }

        return result;
    }
    /// <summary>
    /// Крос-курс
    /// </summary>
    /// <param name="kv1">Валюта А</param>
    /// <param name="kv2">Валюта Б</param>
    /// <returns></returns>
    private string[] GetXRate(string kv1, string kv2, string bdate)
    {
        string[] result = new string[3];

        try
        {
            cDocHandler.CrossRate rates = new cDocHandler.CrossRate(Context, kv1, kv2, bdate);
            result[0] = rates.RatO;
            result[1] = rates.RatB;
            result[2] = rates.RatS;
        }
        catch
        {
            result[0] = "0";
            result[1] = "0";
            result[2] = "0";
        }

        return result;
    }
    /// <summary>
    /// 
    /// </summary>
    private void CheckIfEnabled()
    {
        Decimal dpt_id = Convert.ToDecimal(Request.QueryString["dpt_id"]);

        OracleConnection connect = new OracleConnection();
        OracleDataReader rdr = null;
        try
        {
            // Открываем соединение с БД
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();            

            // Устанавливаем роль
            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdInfo = connect.CreateCommand();
            cmdInfo.CommandText = "SELECT to_char(d.dat_end,'dd/mm/yyyy'),v.br_wd, NVL(v.min_summ*t.denom,0),to_char(bankdate,'dd/mm/yyyy'), t.denom " +
                "  FROM dpt_deposit d, dpt_vidd v, tabval t " + 
                " WHERE d.deposit_id = :dpt_id AND d.vidd = v.vidd and d.kv = t.kv";
            cmdInfo.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);

            rdr = cmdInfo.ExecuteReader();

            if (!rdr.Read())
                throw new ApplicationException("Не найдена информация о вкладе! Номер вклада " + Convert.ToString(dpt_id));

            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            DateTime dtEnd = DateTime.MinValue;
            Decimal BR_WD = Decimal.MinValue;
            Decimal MIN_SUM = Decimal.MinValue;
            DateTime dtBd = DateTime.MinValue;
            Decimal denom = 100;

            if (!rdr.IsDBNull(0))
                dtEnd = Convert.ToDateTime(rdr.GetOracleString(0).Value, cinfo);
            if (!rdr.IsDBNull(1))
                BR_WD = rdr.GetOracleDecimal(1).Value;
            if (!rdr.IsDBNull(2))
                MIN_SUM = rdr.GetOracleDecimal(2).Value;
            if (!rdr.IsDBNull(3))
                dtBd = Convert.ToDateTime(rdr.GetOracleString(3).Value, cinfo);
            if (!rdr.IsDBNull(4))
                denom = rdr.GetOracleDecimal(4).Value;

            if (dtEnd != DateTime.MinValue)
                textDtEnd.Value = "1";
            else
                textDtEnd.Value = "";

            if (BR_WD == Decimal.MinValue && dtEnd != DateTime.MinValue && Request["agr_id"] != null)
                throw new ApplicationException("Процедура частичного снятия вклада №" + dpt_id + " не предусмотрена!");

            if (dtEnd < dtBd && dtEnd != DateTime.MinValue)
                throw new ApplicationException("Срок вклада №" + dpt_id + " истек!\nВоспользуйтесь операцией выплаты вклада по завершению.");

            if (MIN_SUM > 0 && Request["agr_id"] != null)
            {
                MaxSum.ValueDecimal -= MIN_SUM / denom;
                SumToPay.ValueDecimal = MaxSum.ValueDecimal;
            }

            if (Request["agr_id"] == null)
            {
                /// Якщо дострокове розторгнення - перевіряємо чи вже не штрафували
                OracleCommand cmdGetShtraf = connect.CreateCommand();

                cmdGetShtraf.CommandText = "SELECT count(deposit_id) " +
                    "FROM dpt_deposit_clos c, oper o " +
                    "WHERE c.action_id = 5 AND c.ref_dps IS NOT NULL and c.deposit_id = :dpt_id " +
                    "and c.ref_dps = o.ref and o.sos >= 0";
                
                cmdGetShtraf.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);

                Decimal res = Convert.ToDecimal(cmdGetShtraf.ExecuteScalar());

                if (res > 0)
                {
                    /// Договір вже штрафували
                    btCancel.Enabled = false;
                    btShtraf.Disabled = true;
                    btNoShtraf.Enabled = false;
                    btPay.Disabled = false;
                    SumToPay.Enabled = false;

                    // ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "info", "alert('" + "PercentSum = " + PercentSum.ValueDecimal.ToString() + "');", true);

                    Deposit dpt = new Deposit(dpt_id);

                    // Якщо залишилися не виплачені %%
                    if ((dpt.dpt_f_sum == 0) && (dpt.perc_f_sum > 0))
                    {
                        btPay.Disabled = true;
                        btPayPercent.Enabled = true;
                    }

                    // Збочення для Ощадбанку (виплата часки суми депозиту при достроковому поверненні)
                    if (Deposit.AccountIsCash(textNLS.Text, Kv.Value) == "1")
                    {
                        SumToPay.Enabled = true;
                    }
                    else
                    {
                        SumToPay.Enabled = false;
                    }
                }
            }
        }
        finally
        {
            rdr.Close();
            rdr.Dispose();
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    private void RegisterEventScript()
    {
        String script = String.Empty;

        if (BankType.GetCurrentBank() == BANKTYPE.PRVX ||
                     BankType.GetCurrentBank() == BANKTYPE.SBER)
        {
            script = @"<script language='javascript'>
			document.getElementById('textNLS').attachEvent('onkeydown',doNumAlpha);			
			document.getElementById('textMFO').attachEvent('onkeydown',doNum);
			document.getElementById('textOKPO').attachEvent('onkeydown',doNum);
			</script>";
        }
        else
        {
            script = @"<script language='javascript'>
			document.getElementById('textNLS').attachEvent('onkeydown',doNum);			
			document.getElementById('textMFO').attachEvent('onkeydown',doNum);
			document.getElementById('textOKPO').attachEvent('onkeydown',doNum);
			</script>";
        }
        ClientScript.RegisterStartupScript(this.GetType(), ID + "Script_CK", script);
    }
    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    private bool NoShtrafEnabled()
    {
        Decimal dpt_id = Convert.ToDecimal(Convert.ToString(Request["dpt_id"]));

        OracleConnection connect = new OracleConnection();
        try
        {
            // Открываем соединение с БД
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();            

            // Устанавливаем роль
            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdInfo = connect.CreateCommand();
            cmdInfo.CommandText = "select value from v_dpt_depositw where dpt_id=:dpt_id";
            cmdInfo.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
            String result = Convert.ToString(cmdInfo.ExecuteScalar());

            if (connect.State != ConnectionState.Closed)
            {
                connect.Close();
                connect.Dispose();
            }

            if (result != "1")
            {
                DBLogger.Info("Досрочное расторжение без штрафования для депозитного договора №" +
                    dpt_id.ToString() + " РАЗРЕШЕНО!", "deposit");
                
                return false;
            }
            else
            {
                DBLogger.Info("Досрочное расторжение без штрафования для депозитного договора №" +
                    dpt_id.ToString() + " ЗАПРЕЩЕНО!", "deposit");

                return true;
            }
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
}
