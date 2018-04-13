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
using System.Globalization;
using Bars.DocHand;
using Bars.Exception;
using Bars.Logger;
using Bars.Oracle;
using Bars.Classes;
using Bars.Requests;
using Oracle.DataAccess.Client;

/// <summary>
/// 
/// </summary>
public partial class DepositReturn : Bars.BarsPage
{
	/// <summary>
	/// Загрузка страницы
	/// </summary>
	/// <param name="sender"></param>
	/// <param name="e"></param>
	private void Page_Load(object sender, System.EventArgs e)
	{
        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositReturn;
		
		if (Request["dpt_id"] == null)
            Response.Redirect("/barsroot/deposit/DepositSearch.aspx?action=deposit&extended=0");

		if (Request["tt"] == null)
            Response.Redirect("/barsroot/deposit/deloitte/DepositSelectTT.aspx?dpt_id=" + 
                Convert.ToString(Request["dpt_id"]) + "&dest=return");

        if (Deposit.InheritedDeal(Convert.ToString(Request["dpt_id"])) && (Request["inherit_id"] == null))
            throw new DepositException("Дана функція заблокована. По депозитному договору є зареєстровані спадкоємці.");

        tt.Value = Convert.ToString(Request["tt"]);

        Deposit dpt = new Deposit(Convert.ToDecimal(Request.QueryString["dpt_id"]), true);

        // DELOITTE -> авторизація виплати по БПК
        // if (Request.QueryString["scheme"] == "DELOITTE")
        if ((Tools.get_EADocID(dpt.ID) > 0) && (DepositRequest.HasActive(dpt.Client.ID, dpt.ID) == false))
        {
            btNalPay.Visible = false;
            btPayPercent.Visible = false;
        }
        else
        {
            btAuthorizationByBPK.Visible = false;
            btNalPay.Attributes["onclick"] = "javascript:if (CheckSum('dptSum','dptDepositToPay',false) && Valid(3))";
            btPayPercent.Attributes["onclick"] = "javascript:if (CheckSum('dptPercentSum','dptPercentToPay',false) && Valid(4))";
        }

		RegisterEventScript();

        /// Процедура реєстрації документа за вкладом
        String bpp = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE") +
            "@" + "begin dpt_web.fill_dpt_payments(" + Request["dpt_id"] + ",:REF);end;";
        AfterPay.Value = bpp;
        bpp_4_cent.Value = bpp;

        Deposit.CheckCardPayoff("D", dpt.perc_nls, dpt.Currency, dpt.ID, tt.Value);

        Deposit.VerifyReturn(dpt.ID);

        /// Перевірка операції
		int result = CkTTS(dpt);

		/// Через касу
		if (result == 1)
		{
			textNLS.Enabled		= false;
			textMFO.Enabled		= false;
			textOKPO.Enabled	= false;
			textNMK.Enabled		= false;
		}
		// Міжбанк
		else if (result == 2)
		{
			RegisterScript();
			textNLS.Attributes["onblur"]	 = "javascript:doValueCheck(\"textNLS\");";
			textMFO.Attributes["onblur"]	 = "javascript:doValueCheck(\"textMFO\");";
			textOKPO.Attributes["onblur"]	 = "javascript:doValueCheck(\"textOKPO\");";

			textNLS.Attributes["onblur"]	+= "javascript:chkAccount(\"textNLS\",\"textMFO\");";
		}
		// Внутрібанк
		else
		{
			RegisterScript();
			textNLS.Attributes["onblur"]	 = "javascript:doValueCheck(\"textNLS\");";
			textMFO.Attributes["onblur"]	 = "javascript:doValueCheck(\"textMFO\");";
			textOKPO.Attributes["onblur"]	 = "javascript:doValueCheck(\"textOKPO\");";
			textMFO.Enabled = false;

			textNLS.Attributes["onblur"]	+= "javascript:chkAccount(\"textNLS\",\"textMFO\");";
		}
        
        /// Виплата не через касу заборонена
        //if ((result != 1) && (Request["inherit_id"] != null))
        //    throw new DepositException("Виплата не через касу заборонена!");
				
		if (!IsPostBack)
		{
            /// Виплачуємо депозит
			if (Convert.ToString(Request["per"]) != "cent")
			{
				CheckDeposit(dpt);

                if (Deposit.InheritedDeal(dpt.ID.ToString()))
                {
                    AfterPay.Value = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE") +
                    "@" + "declare l_ref oper.ref%type := :REF; begin dpt_web.fill_dpt_payments(" + Request["dpt_id"] + ",l_ref); end;";
                }
			}
            /// Виплачуємо відсотки
			else
			{
				btNalPay.Disabled = true;
				btPayPercent.Disabled = false;
			}

            FillControlsFromClass(dpt);
		}
        /// Перевірка рахунків виплати
        CheckPayOffAccounts(result, dpt);

        ISCASH.Value = Deposit.AccountIsCash(textNLS.Text, dpt.Currency.ToString());
	}
    /// <summary>
    /// Локализация DataGrid
    /// </summary>
    protected override void OnPreRender(EventArgs evt)
    {
        // Локализируем infrag
        DateR.ToolTip = Resources.Deposit.GlobalResources.tb33;
        dptRate.ToolTip = Resources.Deposit.GlobalResources.tb34;
        dptStartDate.ToolTip = Resources.Deposit.GlobalResources.tb35;
        dptDepositToPay.ToolTip = Resources.Deposit.GlobalResources.tb36;
        dptSum.ToolTip = Resources.Deposit.GlobalResources.tb37;
        dptPercentSum.ToolTip = Resources.Deposit.GlobalResources.tb38;
        dptEndDate.ToolTip = Resources.Deposit.GlobalResources.tb39;
        dptPercentToPay.ToolTip = Resources.Deposit.GlobalResources.tb40;
    }
	/// <summary>
	/// Инициализация контролов из класса депозита
	/// </summary>
	/// <param name="dpt"></param>
	private void FillControlsFromClass(Deposit dpt)
	{
		// Заповнюємо контроли на формі
		textDepositNumber.Text	= dpt.Number.ToString();
        dpt_id.Value            = dpt.ID.ToString();
		textClientName.Text		= dpt.Client.Name;
		textClientPasp.Text		= dpt.Client.DocTypeName + " " + dpt.Client.DocSerial + " " + 
            dpt.Client.DocNumber + " " + dpt.Client.DocOrg;
		DateR.Date				= dpt.Client.BirthDate;
		textDptType.Text		= dpt.TypeName;
		textDptCur.Text			= dpt.CurrencyName;
		dptRate.Value			= dpt.RealIntRate;
		dptStartDate.Date		= dpt.BeginDate;
		dptEndDate.Date			= dpt.EndDate;
        denom.Value             = dpt.Sum_denom.ToString();

        rnk.Value = Convert.ToString(dpt.Client.ID);
					
		dpf_oper.Value = BankType.GetDpfOper(dpt.ID);

        // Донарахування %% при виплаті
		Decimal p_int = Deposit.ChargeInterest(dpt.ID,1);

        dpt.ReadFromDatabaseExt(true, false, true);

        dptSum.ValueDecimal = dpt.dpt_f_sum;
        textDptCurISO.Text = dpt.CurrencyISO;

        dptPercentSum.ValueDecimal = dpt.perc_p_sum;
        textPercentCurISO.Text = dpt.CurrencyISO;

        Kv.Value = dpt.Currency.ToString();
        Nls_A.Value = dpt.dpt_nls;
        Nls_A1.Value = dpt.perc_nls;

		dptDepositToPay.ValueDecimal = Convert.ToDecimal(Convert.ToString(dptSum.Value));
		dptPercentToPay.ValueDecimal = Convert.ToDecimal(Convert.ToString(dptPercentSum.Value));

        if (dpt.Sum_denom == 1000)
        {
            dptSum.MinDecimalPlaces = Infragistics.WebUI.WebDataInput.MinDecimalPlaces.Three;
            dptPercentSum.MinDecimalPlaces = Infragistics.WebUI.WebDataInput.MinDecimalPlaces.Three;
            dptDepositToPay.MinDecimalPlaces = Infragistics.WebUI.WebDataInput.MinDecimalPlaces.Three;
            dptPercentToPay.MinDecimalPlaces = Infragistics.WebUI.WebDataInput.MinDecimalPlaces.Three;
        }
			
		MFO.Value = BankType.GetOurMfo();

        if (!textMFO.Enabled)
        {
            textMFO.Text = MFO.Value;
        }

        if ((Request["inherit_id"] == null) && (Request["rnk_tr"] == null))
        {
            inherit_row_d.Visible = false;
            inherit_row_p.Visible = false;
        }
        else
        {
            inherit_row_d.Visible = true;
            inherit_row_p.Visible = true;

            btNalPay.Attributes["onclick"] = "javascript:if (CheckSum('InheritDeposit','dptDepositToPay',false) && Valid(3))";
            btPayPercent.Attributes["onclick"] = "javascript:if (CheckSum('InheritPercent','dptPercentToPay',false) && Valid(4))";

            // Виплата спадкоємцю
            if (Request["inherit_id"] != null)
            {
                rnk.Value = Request.QueryString["inherit_id"];

                /// Якщо виплачуємо вже відсотки - депозит не треба перераховувати
                if (Request["per"] == null)
                {
                    InheritDeposit.ValueDecimal = Deposit.InheritRest(dpt.ID.ToString(), rnk.Value, dpt.dpt_acc.ToString(), dpt.Sum_denom);
                }
                
                InheritPercent.ValueDecimal = Deposit.InheritRest(dpt.ID.ToString(), rnk.Value, dpt.perc_acc.ToString(), dpt.Sum_denom);
            }

            // Виплата довіреній ососбі
            if (Request["rnk_tr"] != null)
            {
                rnk.Value = Request.QueryString["rnk_tr"];

                lbInheritSum.Text = "Сума депозиту доступна довіреній особі";
                lbInheritSumP.Text = "Сума відсотків доступна довіреній особі";

                // Сума дозволена для отримання довіреною особою 
                Decimal AllowedAmount = DepositAgreement.GetAllowedAmount(dpt.ID, Convert.ToDecimal(rnk.Value));

                // якщо сума депозиту перевищує дозволену до зняття
                if (dpt.dpt_f_sum > AllowedAmount)
                {
                    InheritDeposit.ValueDecimal = AllowedAmount;
                    InheritPercent.ValueDecimal = 0;
                }
            }

            dptDepositToPay.ValueDecimal = InheritDeposit.ValueDecimal;
            dptPercentToPay.ValueDecimal = InheritPercent.ValueDecimal;
        }
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
		this.btNalPay.ServerClick += new System.EventHandler(this.btNalPay_ServerClick);
		this.btPayPercent.ServerClick += new System.EventHandler(this.btPayPercent_ServerClick);
	}
	#endregion
	/// <summary>
	/// Проверка на срок действия депозита
	/// </summary>
	/// <param name="dpt">депозит</param>
	private void CheckDeposit(Deposit dpt)
	{
        CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
		cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
		cinfo.DateTimeFormat.DateSeparator = "/";

		DateTime bankDate = Convert.ToDateTime(BankType.GetBankDate(),cinfo);

		if (bankDate < dpt.EndDate)
		{
            throw new DepositException("Термін дії депозитного договору №" + 
                dpt.ID.ToString() + " ще не закінчився.  Операція зняття недоступна!");
		}               
		
		DBLogger.Debug("Проверка депозита на срок завершения на странице возврата депозита по завершению прошла успешно. Номер договора " + 
            Convert.ToString(Request["dpt_id"]),"deposit");
	}
	/// <summary>
	/// Нажатие кнопки "Выплата депозита"
	/// </summary>
	/// <param name="sender"></param>
	/// <param name="e"></param>
	private void btNalPay_ServerClick(object sender, System.EventArgs e)
	{
        dptDepositToPay.Enabled = false;				
		
		DBLogger.Info("Пользователь нажал на кнопку \"Выплата вклада\" на странице возврата депозита по завершению.  Номер договора " + Convert.ToString(Request["dpt_id"]),
			"deposit");

        String urlp = "/barsroot/deposit/deloitte/DepositSelectTT.aspx?dpt_id=" + Convert.ToString(Request["dpt_id"]) + 
            "&dest=returnp";

		if (Request["rnk_tr"] != null)
			urlp += "&rnk_tr=" + Convert.ToString(Request["rnk_tr"]);

        if (Request["inherit_id"] != null)
        {
            //urlp  = "DepositReturn.aspx?dpt_id=" + dpt_id.Value + "&tt=DP4&per=cent";
            urlp += "&inherit_id=" + Convert.ToString(Request["inherit_id"]);
        }

        Response.Redirect(urlp);
	}

    /// <summary>
    /// Виплата відсотків з авторизацією отримувачем за допомогою БПК
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btAuthorizationByBPK_ClientIdentified(object sender, Bars.UserControls.ClientIdentifiedEventArgs e)
    {
        if (Convert.ToInt64(rnk.Value) == e.RNK)
        {
            DBLogger.Info("Користувач виконав Авторизацію виплати депозиту за допомогою БПК клієнта (rnk=" + 
                Convert.ToString(e.RNK) + " по договору #" + Request.QueryString["dpt_id"], "deposit");
            
            /*String url = "/barsroot/deposit/deloitte/DepositContractInfo.aspx?dpt_id=" + Request.QueryString["dpt_id"] +
                 "&scheme=DELOITTE";*/
            String url = "/barsroot/deposit/deloitte/DepositAddSumComplete.aspx?dpt_id=" + Request.QueryString["dpt_id"] +
               "&scheme=DELOITTE&rnk=" + e.RNK.ToString();

            if (Request["rnk_tr"] != null)
                url += "&rnk_tr=" + Request.QueryString["rnk_tr"];

            if (Request["inherit_id"] != null)
                url += "&inherit_id=" + Request.QueryString["inherit_id"];
            
            ClientScript.RegisterStartupScript(this.GetType(), "DepositPay", "DepositPay(); location.replace('" + url + "');", true);
        }
        else
        {
            throw new DepositException("РНК отрмувача відсотків не відповідає РНК власника БПК!");
        }
    }

	/// <summary>
	/// Нажатие кнопки "Выплата процентов"
	/// </summary>
	/// <param name="sender"></param>
	/// <param name="e"></param>
	private void btPayPercent_ServerClick(object sender, System.EventArgs e)
	{
		Decimal dpt_id = Convert.ToDecimal(Convert.ToString(Request["dpt_id"]));

		DBLogger.Info("Пользователь нажал на кнопку \"Выплата процентов\" на странице возврата депозита по завершению.  Номер договора " + Convert.ToString(Request["dpt_id"]),
			"deposit");

        //if ((BankType.GetCurrentBank() == BANKTYPE.UPB) || (Request["inherit_id"] != null))
        //{
        //    textNLS.Enabled = false;
        //    textNMK.Enabled = false;
        //    textOKPO.Enabled = false;
        //    textMFO.Enabled = false;

        //    dptDepositToPay.Enabled = false;
        //    dptPercentToPay.Enabled = false;
        //    btNalPay.Disabled = true;
        //    btPayPercent.Disabled = true;
        //}
        //else
            Response.Redirect("/barsroot/deposit/deloitte/DepositReturnComplete.aspx?dptid=" + dpt_id.ToString());
	}
	/// <summary>
	/// Проверка счетов выплаты
	/// если они есть - нельзя выплачивать проценты вручную
	/// </summary>
	private void CheckPayOffAccounts(int op_type,Deposit dpt)
	{
        if (BankType.GetCurrentBank() == BANKTYPE.SBER)
        {             
            /// Виплачуємо відсотки
            if (Convert.ToString(Request["per"]) == "cent")
            {
                if (!String.IsNullOrEmpty(dpt.IntReceiverAccount))
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
            }
            /// Виплачуємо депозит
            else
            {
                /// Якщо вказані рахунки виплати
                if (!String.IsNullOrEmpty(dpt.RestReceiverAccount))
                {
                    textNLS.Text = dpt.RestReceiverAccount;
                    textMFO.Text = dpt.RestReceiverMFO;
                    textOKPO.Text = dpt.RestReceiverOKPO;
                    textNMK.Text = dpt.RestReceiverName;
                    textNLS.Enabled = false;
                    textMFO.Enabled = false;
                    textOKPO.Enabled = false;
                    textNMK.Enabled = false;
                }
            }                
        }
        else if (BankType.GetCurrentBank() == BANKTYPE.PRVX)
        {
            if (op_type != 1)
            {
                /// Виплачуємо відсотки
                if (Convert.ToString(Request["per"]) == "cent")
                {
                    if (!String.IsNullOrEmpty(dpt.IntReceiverAccount))
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
                /// Виплачуємо депозит
                else
                {
                    /// Якщо вказані рахунки виплати
                    if (!String.IsNullOrEmpty(dpt.RestReceiverAccount))
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
                }
            }
        }
	}		
	/// <summary>
	/// Перевірка операції 
	/// виплати відсотків
	/// </summary>
	/// <returns>
	/// 1 - касова
	/// 2 - міжбанк
	/// 3 - внутрібанк
	/// </returns>
	private int	 CkTTS(Deposit dpt)
	{
		string tt_name = Convert.ToString(Request["tt"]);

		OracleConnection connect = new OracleConnection();
        OracleDataReader rdr = null;
		try
		{
			// Открываем соединение с БД
			IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
			connect = conn.GetUserConnection();
			

			OracleCommand cmdSetRole = new OracleCommand();
			cmdSetRole.Connection = connect;
			cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
			cmdSetRole.ExecuteNonQuery();

			OracleCommand cmdSearch = new OracleCommand();
			cmdSearch.Connection = connect;	
			cmdSearch.CommandText = "select nlsb,fli,flv,kv,kvk,dk,substr(flags,60,1),mfob from tts where tt=:tt";
			cmdSearch.Parameters.Add("tt",OracleDbType.Varchar2,tt_name,ParameterDirection.Input);

			rdr = cmdSearch.ExecuteReader();

			if (!rdr.Read()) 
			{
                throw new DepositException("Недопустима операція при поверненні депозиту та нарахованих відсотків: " 
                    + tt_name);
			}
            
			String  nlsb  = String.Empty;
			Decimal fli_t = Decimal.Zero;
			Decimal flv_t = Decimal.Zero;
			String  dk	  = String.Empty;
			String  convert = String.Empty;
            String  mfob    = String.Empty;

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

			cmdSearch.Parameters.Clear();
			cmdSearch.CommandText = "select '20'||to_char(bankdate,'yyMMdd') from dual";
			String bDate = Convert.ToString(cmdSearch.ExecuteScalar());
		
			if(string.Empty != kvk.Value && string.Empty != Kv.Value)
			{
				string[] rates = GetXRate(Kv.Value,kvk.Value,bDate);
				if (convert =="1")
				{
					if("0"==dk || "2"==dk)
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
            rdr.Close();
            rdr.Dispose();
			if (connect.State != ConnectionState.Closed)
				{connect.Close();connect.Dispose();}
		}
	}	
	/// <summary>
	/// 
	/// </summary>
	private void RegisterScript()
	{
		string script = @"<script language='javascript'>
		document.getElementById('textNLS').attachEvent('onkeydown',doNumAlpha);
		document.getElementById('textMFO').attachEvent('onkeydown',doNum);
		document.getElementById('textOKPO').attachEvent('onkeydown',doNum);
		</script>";
		ClientScript.RegisterStartupScript(this.GetType(), ID+"Script",script ) ;
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
		string result	= String.Empty;

		try
		{				
			con = conn.GetUserConnection(Context);

			OracleCommand cmd = con.CreateCommand();
		
			cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
			cmd.ExecuteNonQuery();			

			string formula	= string.Empty;
			string text		= string.Empty;
			
			cmd.CommandText = "begin doc_strans(:text_,:res_);end;";

			if (NLS.StartsWith("#"))
			{
				formula = NLS.Remove(0,1);
			
				text = "select " + formula + " from dual";

				cmd.Parameters.Add("text_",OracleDbType.Varchar2,text,ParameterDirection.Input);
				cmd.Parameters.Add("res_", OracleDbType.Decimal, null,ParameterDirection.Output);
				
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
	private string[] GetXRate ( string kv1, string kv2, string bdate)
	{
		string[] result = new string[3];
							
		try
		{
			cDocHandler.CrossRate rates = new cDocHandler.CrossRate(Context,kv1,kv2,bdate);
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
        ClientScript.RegisterStartupScript(this.GetType(), ID + "ScriptCk", script);
	}
}