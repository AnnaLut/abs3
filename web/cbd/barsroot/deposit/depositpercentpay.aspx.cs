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
using Bars.DocHand;
using Bars.Exception;
using Bars.Classes;

/// <summary>
/// Summary description for DepositPercentPay.
/// </summary>
public partial class DepositPercentPay : Bars.BarsPage
{
	/// <summary>
	/// Загрузка страницы
	/// </summary>
	private void Page_Load(object sender, System.EventArgs e)
	{
        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositPercentPay;

		if (Request["dpt_id"] == null)
			Response.Redirect("DepositSearch.aspx?action=percent&extended=1");

		if (Request["tt"] == null)
			Response.Redirect("DepositSelectTT.aspx?dpt_id=" + Convert.ToString(Request["dpt_id"]) + "&dest=percent");

		if (Request["fp"]!=null)
			textSum.ReadOnly = true;
						
		tt.Value = Convert.ToString(Request["tt"]);

        Deposit dpt;

        if (BankType.GetCurrentBank() == BANKTYPE.UPB)
        {
            Boolean other = ((Convert.ToString(Request["other"]) == "Y") ? true : false);

            dpt = new Deposit(Convert.ToDecimal(Request.QueryString["dpt_id"]), other);
        }
        else
        {
            dpt = new Deposit(Convert.ToDecimal(Request.QueryString["dpt_id"]));
        }

        if (Deposit.InheritedDeal(dpt.ID.ToString()) && (Request["inherit_id"] == null))
            throw new DepositException("Дана функція заблокована. По депозитному договору є зареєстровані спадкоємці. Скористайтесь функцією \"Реєстрація свідоцтв про право на спадок\".");

        /// Процедура реєстрації документа за вкладом
        String bpp = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE") +
            "@" + "begin dpt_web.fill_dpt_payments(" + Request["dpt_id"] + ",:REF);end;";
        AfterPay.Value = bpp;
        bpp_4_cent.Value = bpp;

        //if (Deposit.InheritedDeal(dpt.ID.ToString()))
        //    BeforePay.Value = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE") +
        //    "@" + "declare l_ref oper.ref%type := :REF; l_taxref oper.ref%type := null; begin dpt_web.inherit_payment ( " + Request["dpt_id"] + ", " + Request["inherit_id"] + ", l_taxref); UPDATE oper SET refl = l_taxref WHERE ref = l_ref; end;";

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
		else 
		{
			RegisterEventScript();			
			textNLS.Attributes["onblur"]	 = "javascript:doValueCheck(\"textNLS\");";
			textMFO.Attributes["onblur"]	 = "javascript:doValueCheck(\"textMFO\");";
			textOKPO.Attributes["onblur"]	 = "javascript:doValueCheck(\"textOKPO\");";

			// Міжбанк
			if (result == 2)
				textNLS.Attributes["onblur"]	+= "javascript:chkAccount(\"textNLS\",\"textMFO\");";
			// Внутрібанк
			else
			{
				textMFO.Enabled = false;
				textNLS.Attributes["onblur"]	+= "javascript:chkAccount(\"textNLS\",\"textMFO\");";
			}
		}

        /// Виплата не через касу заборонена
        if ((result != 1) && (Request["inherit_id"] != null))
            throw new DepositException("Виплата не через касу заборонена!");

        btPay.Attributes["onclick"]		 = "javascript:if (CheckSum('textPercentSum','textSum',false) && Valid(1))";

        if (!IsPostBack)
        {
            if (dpt.fl_int_payoff != 1)
                throw new DepositException("Не наступив термін виплати відсотків по вкладу №" + dpt.Number);

            if (dpt.fl_int_payoff == 1 && dpt.fl_avans_payoff == 1)
            {
                Deposit.MakeAvans(dpt.ID);
                dpt.ReadFromDatabase();
            }

            FillControlsFromClass(dpt);

            /// Заповнюємо рахунки виплати якщо потрібно 
            CheckPayOffAccounts(result, dpt);
        }

        ISCASH.Value = Deposit.AccountIsCash(textNLS.Text, dpt.Currency.ToString());
	}
    /// <summary>
    /// Локализация Infra
    /// </summary>
    protected override void OnPreRender(EventArgs evt)
    {
        DateR.ToolTip = Resources.Deposit.GlobalResources.tb22;
        textDptRate.ToolTip = Resources.Deposit.GlobalResources.tb23;
        dtStartContract.ToolTip = Resources.Deposit.GlobalResources.tb24;
        textPercentSum.ToolTip = Resources.Deposit.GlobalResources.tb25;
        dtEndContract.ToolTip = Resources.Deposit.GlobalResources.tb26;
    }
	/// <summary>
	/// Заполнение контролов
	/// </summary>
	/// <param name="dpt">депозит</param>
	private void FillControlsFromClass(Deposit dpt)
	{
		// Заполняем элементы
		textDepositNumber.Text		= dpt.Number.ToString();
        dpt_id.Value                = dpt.ID.ToString();
		textClientName.Text			= dpt.Client.Name;
		textClientPasp.Text			= dpt.Client.DocSerial + " " + dpt.Client.DocNumber 
										+ " " + dpt.Client.DocOrg;
		DateR.Date					= dpt.Client.BirthDate;
		
		if (Request["rnk_tr"] != null)
            RNK.Value = Convert.ToString(Request["rnk_tr"]);
		else
            RNK.Value                   = Convert.ToString(dpt.Client.ID);

		textDptType.Text			= dpt.TypeName;
		textDptCur.Text				= dpt.CurrencyName;
		textDptRate.ValueDecimal	= dpt.RealIntRate;
		textPercentCur.Text			= dpt.CurrencyISO;
		textSumCur.Text				= dpt.CurrencyISO;
		dtEndContract.Date			= dpt.EndDate;
		dtStartContract.Date		= dpt.BeginDate;

        textPercentSum.ValueDecimal = dpt.perc_p_sum;
        PercentNls.Value = dpt.perc_nls;
        PercentKV.Value = dpt.CurrencyISO;
        Kv.Value = dpt.Currency.ToString();
        denom.Value = dpt.Sum_denom.ToString();

        if (dpt.Sum_denom == 1000)
        {
            textPercentSum.MinDecimalPlaces = Infragistics.WebUI.WebDataInput.MinDecimalPlaces.Three;
            textSum.MinDecimalPlaces = Infragistics.WebUI.WebDataInput.MinDecimalPlaces.Three;
        }

        if (Request["inherit_id"] != null)
        {
            inherit_row.Visible = true;
            InheritSum.ValueDecimal = Deposit.InheritRest(dpt.ID.ToString(),
                Convert.ToString(Request["inherit_id"]), dpt.perc_acc.ToString(), dpt.Sum_denom);
            textSum.ValueDecimal = InheritSum.ValueDecimal;
            btPay.Attributes["onclick"] = "javascript:if (CheckSum('InheritSum','textSum',false) && Valid(1))";
            RNK.Value = Convert.ToString(Request["inherit_id"]);
        }
        else
        {
            inherit_row.Visible = false;
            textSum.ValueDecimal = textPercentSum.ValueDecimal;
        }
		
		OracleConnection connect = new OracleConnection();
		try
		{
			IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

			OracleCommand cmd	= connect.CreateCommand();
			cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
			cmd.ExecuteNonQuery();

			OracleCommand cmdGetKasa = new OracleCommand();
			cmdGetKasa.Connection = connect;
			cmdGetKasa.CommandText = "select val from params where par='MFO'";
			cmdGetKasa.Parameters.Clear();
			
			MFO.Value	= Convert.ToString(cmdGetKasa.ExecuteScalar());

			if (!textMFO.Enabled)
				textMFO.Text	= MFO.Value;

			dpf_oper.Value = BankType.GetDpfOper(dpt.ID);

            // Донарахування %%
            Deposit.ChargeInterest(dpt.ID);
			
			dpt.ReadFromDatabase();

            //cmd.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            //cmd.ExecuteNonQuery();

            //cmd.CommandText = "begin dpt_web.get_intpayoff_amount(:p_dptid, :p_amount); end;";
            //cmd.Parameters.Add("p_dptid", OracleDbType.Decimal, dpt.ID, ParameterDirection.Input);
            //cmd.Parameters.Add("p_amount", OracleDbType.Decimal, dpt.perc_p_sum * dpt.Sum_denom, ParameterDirection.InputOutput);
            //cmd.ExecuteNonQuery();

            //textPercentSum.ValueDecimal = Convert.ToDecimal(Convert.ToString(cmd.Parameters[1].Value)) / dpt.Sum_denom;
            //textSum.ValueDecimal = textPercentSum.ValueDecimal;
	      textPercentSum.ValueDecimal = dpt.perc_f_sum;
		}
		finally	
		{
			if (connect.State != ConnectionState.Closed)
				{connect.Close();connect.Dispose();}
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
		this.btPay.ServerClick += new System.EventHandler(this.btPay_ServerClick);
		;

	}
	#endregion
	/// <summary>
	/// Нажатие кнопки "Выплата"
	/// </summary>
	private void btPay_ServerClick(object sender, System.EventArgs e)
	{
		if (Request["dpt_id"] == null)
			Response.Redirect("DepositSearch.aspx?action=percent&extended=1");

		DBLogger.Info("Пользователь нажал на кнопку \"Выплата\" (процентов) на странице выплаты процентов по договору.  Номер договора " + 
            Convert.ToString(Request["dpt_id"]),"deposit");

		Decimal dpt_id = Convert.ToDecimal(Convert.ToString(Request["dpt_id"]));

        Session["PROLONG"] = null;

		if (Request["fp"]!=null)
			Response.Redirect("DepositContractInfo.aspx?dpt_id="+ dpt_id);
        else if ((BankType.GetCurrentBank() == BANKTYPE.UPB) || (Request["inherit_id"] != null))
        {
            textSum.Enabled = false;
            textNLS.Enabled = false;
            textNMK.Enabled = false;
            textOKPO.Enabled = false;
            textMFO.Enabled = false;
            btPay.Disabled = true;
        }
        else
            Response.Redirect("DepositPercentPayComplete.aspx?dptid=" + dpt_id);

	}
	/// <summary>
	/// Проверка счетов выплаты
	/// если они есть - нельзя выплачивать проценты вручную
	/// </summary>
	private void CheckPayOffAccounts(int op_type, Deposit dpt)
	{
        if (BankType.GetCurrentBank() == BANKTYPE.PRVX)
        {
            /// Якщо вказані рахунки виплати + вибрана не касова операція
            /// це не останій день депозиту (для пролонгації)

            if (!String.IsNullOrEmpty(dpt.IntReceiverAccount) && op_type != 1 &&
                dpt.EndDate.ToString("dd/MM/yyyy") != BankType.GetBankDate()
               )
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
	/// Перевірка операції 
	/// виплати відсотків
	/// </summary>
	/// <returns>1 - касова 2 - міжбанк 3 - внутрібанк</returns>
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


            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdSearch = connect.CreateCommand();
            cmdSearch.CommandText = "select nlsb,fli,flv,kv,kvk,dk,substr(flags,60,1),mfob from tts where tt=:tt";
            cmdSearch.Parameters.Add("tt", OracleDbType.Varchar2, tt_name, ParameterDirection.Input);

            rdr = cmdSearch.ExecuteReader();

            if (!rdr.Read())
            {
                throw new DepositException("Недопустима операція виплати відсотків: " + tt_name);
            }

            String nlsb = String.Empty;
            String mfob = String.Empty;
            Decimal fli_t = Decimal.Zero;
            Decimal flv_t = Decimal.Zero;
            String dk = String.Empty;
            String convert = String.Empty;

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

            if ((nlsb != String.Empty))
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
                        throw new DepositException("Інформація про рахунок " +
                            nlsb + " не знайдена!");


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
            { connect.Close(); connect.Dispose(); }
        }
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
}
