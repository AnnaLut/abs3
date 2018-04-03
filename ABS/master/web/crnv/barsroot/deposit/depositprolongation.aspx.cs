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
using Bars.Oracle;
using Bars.Logger;
using Oracle.DataAccess.Client;
using System.Globalization;
using Oracle.DataAccess.Types;
using Bars.Exception;
using Bars.Classes;

/// <summary>
/// Summary description for DepositProlongation.
/// </summary>
public partial class DepositProlongation : Bars.BarsPage
{
	/// <summary>
	/// 
	/// </summary>
	/// <param name="sender"></param>
	/// <param name="e"></param>
	private void Page_Load(object sender, System.EventArgs e)
	{
        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositProlongation;
		if (Request["dpt_id"]==null)
			Response.Redirect("DepositSearch.aspx?action=prolongation");
		btProlongate.Attributes["onclick"] = "javascript:GetTemplates();";

		if (!IsPostBack)
		{
            if (Deposit.InheritedDeal(Convert.ToString(Request["dpt_id"])))
                throw new DepositException("По депозитному договору є зареєстровані спадкоємці. Дана функція заблокована.");

			FillControls();		
		}			
	}
    /// <summary>
    /// Локализация Infra
    /// </summary>
    protected override void OnPreRender(EventArgs evt)
    {
        // Локализация infrag
        clientBirthDay.ToolTip = Resources.Deposit.GlobalResources.tb79;
        textDptSum.ToolTip = Resources.Deposit.GlobalResources.tb80;
        textPercentSum.ToolTip = Resources.Deposit.GlobalResources.tb81;
        textDptStartDate.ToolTip = Resources.Deposit.GlobalResources.tb82;
        textRate.ToolTip = Resources.Deposit.GlobalResources.tb83;
        textDptEndDate.ToolTip = Resources.Deposit.GlobalResources.tb84;
        textNewDptStartDate.ToolTip = Resources.Deposit.GlobalResources.tb85;
        textNewDptEndDate.ToolTip = Resources.Deposit.GlobalResources.tb86;

        lbTitle.Text = lbTitle.Text.Replace("%S", Convert.ToString(Session["DPT_NUM"]));
    }
	/// <summary>
	/// 
	/// </summary>
	private void FillControls()
	{
		Deposit dpt = new Deposit(Convert.ToDecimal(Convert.ToString(Request["dpt_id"])));
		vidd.Value = dpt.Type.ToString();

		textClientName.Text			= dpt.Client.Name;
		textClientPasp.Text			= dpt.Client.DocTypeName + " " + dpt.Client.DocSerial +
			" " + dpt.Client.DocNumber + " " + dpt.Client.DocOrg;
		clientBirthDay.Date			= dpt.Client.BirthDate;

		textDptType.Text			= dpt.TypeName;
		textDptCur.Text				= dpt.CurrencyISO;
		textDptStartDate.Date		= dpt.BeginDate;
		textDptEndDate.Date			= dpt.EndDate;
		textRate.ValueDecimal		= dpt.RealIntRate;

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
			
			Decimal p_int = Deposit.ChargeInterest(dpt.ID);

			OracleCommand cmdGetAccInfo = connect.CreateCommand();
			cmdGetAccInfo.CommandText = 
				"select a1.ostc/100,a2.ostc/100"						+
				"from dpt_deposit d, saldo a1,int_accn i,saldo a2 "		+
				"where d.deposit_id = :dpt_id and d.acc = a1.acc "		+
				"and d.acc = i.acc and i.acra = a2.acc";
			cmdGetAccInfo.Parameters.Add("dpt_id",OracleDbType.Decimal,dpt.ID,ParameterDirection.Input);

			OracleDataReader rdr = cmdGetAccInfo.ExecuteReader();

			if (!rdr.Read())
			{
                throw new DepositException("Інформація про депозитний договір №" +
                    dpt.ID.ToString() + " та його рахунки не знайдена!");
			}
	
			if (!rdr.IsDBNull(0))
				textDptSum.ValueDecimal		= rdr.GetOracleDecimal(0).Value;
			if (!rdr.IsDBNull(1))
				textPercentSum.ValueDecimal	= rdr.GetOracleDecimal(1).Value;

			if (!rdr.IsClosed) 
				rdr.Close();

			cmdGetAccInfo.Dispose();

			OracleCommand cmdGetNewDates = connect.CreateCommand();
			cmdGetNewDates.CommandText = "select to_char(dat_begin_new,'dd/mm/yyyy'),to_char(dat_end_new,'dd/mm/yyyy') from dpt_auto_extend where dpt_id = :dpt_id";
			cmdGetNewDates.Parameters.Add("dpt_id",OracleDbType.Decimal,dpt.ID,ParameterDirection.Input);

			OracleDataReader drdr = cmdGetNewDates.ExecuteReader();

			CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
			cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
			cinfo.DateTimeFormat.DateSeparator = "/";

			if (!drdr.Read())
			{
				throw new DepositException("Інформація про дати продовження депозитного договору №" + 
                    dpt.ID.ToString() + " не знайдена!");
			}
	
			if (!drdr.IsDBNull(0))
				textNewDptStartDate.Date = Convert.ToDateTime(drdr.GetOracleString(0).Value,cinfo);
			if (!drdr.IsDBNull(1))
				textNewDptEndDate.Date = Convert.ToDateTime(drdr.GetOracleString(1).Value,cinfo);

			if (!drdr.IsClosed)
				drdr.Close();

			cmdGetNewDates.Dispose();
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
		this.btProlongate.ServerClick += new System.EventHandler(this.btProlongate_ServerClick);
		;

	}
	#endregion
	/// <summary>
	/// 
	/// </summary>
	/// <param name="sender"></param>
	/// <param name="e"></param>
	private void btProlongate_ServerClick(object sender, System.EventArgs e)
	{
        Session["PROLONG"] = "true";
		String[]_templates;
		String rb_checked = Convert.ToString(rb.Value);
		if (Templates.Value == String.Empty)
		{
            Response.Write("<script>alert('" + Resources.Deposit.GlobalResources.ora01 + "');</script>");
            //Response.Write("<script>alert('Не выбран ни один шаблон!');</script>");
			return;
		}
		else
		{
			String val = Templates.Value;
			_templates = val.Split(';');
		}

		String script = String.Empty; 
		String dpt_id = Convert.ToString(Request["dpt_id"]);
		Decimal overallsum = Decimal.MinValue;
		String sum_str = String.Empty;
		String nls_p = String.Empty;
		String nls_d = String.Empty;

		Deposit dpt = new Deposit(Convert.ToDecimal(dpt_id));

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

			OracleCommand cmdProlongate = connect.CreateCommand();
			cmdProlongate.CommandText = "select a2.ostc,a1.nls,a2.nls " +
				"from dpt_deposit d, saldo a1,int_accn i,saldo a2 " +
				"where d.deposit_id = :dpt_id and d.acc = a1.acc and d.acc = i.acc and i.acra = a2.acc";
			cmdProlongate.Parameters.Add("dpt_id",OracleDbType.Decimal,dpt_id,ParameterDirection.Input);
				
			OracleDataReader rdr = cmdProlongate.ExecuteReader();

			if (!rdr.Read())
                throw new DepositException("Рахунки депозитного договору №" + 
                    dpt_id + " не знайдені!");

			if (!rdr.IsDBNull(0))
				sum_str = Convert.ToString(rdr.GetOracleDecimal(0).Value);
			if (!rdr.IsDBNull(1))
				nls_d = Convert.ToString(rdr.GetOracleString(1).Value);
			if (!rdr.IsDBNull(2))
				nls_p = Convert.ToString(rdr.GetOracleString(2).Value);

			rdr.Close();
			rdr.Dispose();
				
			cmdProlongate.Dispose();

			if (rb_checked == "1")
			{
				OracleCommand cmdGetSum = connect.CreateCommand();
				cmdGetSum.CommandText = "select nvl(a1.ostc + a2.ostc,0) " +
					"from dpt_deposit d, saldo a1,int_accn i,saldo a2 " + 
					"where d.deposit_id = :dpt_id and d.acc = a1.acc and d.acc = i.acc and i.acra = a2.acc";
				cmdGetSum.Parameters.Add("dpt_id",OracleDbType.Decimal,dpt_id,ParameterDirection.Input);
				overallsum = Convert.ToDecimal(Convert.ToString(cmdGetSum.ExecuteScalar()));
				
				cmdGetSum.Dispose();
			}
			else if (rb_checked == "2")
			{
				OracleCommand cmdGetSum = connect.CreateCommand();
				cmdGetSum.CommandText = "select nvl(a1.ostc,0) " +
					"from dpt_deposit d, saldo a1 where d.deposit_id = :dpt_id and d.acc = a1.acc";
				cmdGetSum.Parameters.Add("dpt_id",OracleDbType.Decimal,dpt_id,ParameterDirection.Input);
				overallsum = Convert.ToDecimal(Convert.ToString(cmdGetSum.ExecuteScalar()));
			
				cmdGetSum.Dispose();
			}
			else 
			{
                throw new DepositException("При пролонгації депозитного договору №" +
					dpt.ID.ToString() + " не вибрано дії з відсотками!");
			}
		}
		finally	
		{
			if (connect.State != ConnectionState.Closed)
			{connect.Close();connect.Dispose();}
		}
		
		if (rb_checked == "1")
		{
			String NMK = String.Empty;
			String OKPO = String.Empty;
			String PASP = String.Empty;
			String PASPN = String.Empty;
			String ATRT = String.Empty;
			String DT_R = String.Empty;
			String ADRES = String.Empty;

            String rnk = String.Empty;

			if (Request["rnk_tr"] != null)
			{
				DBLogger.Info("Договор расторгать(делать частичное снятие) пришло довереное лицо." +
					"РНК = " + Convert.ToString(Request["rnk_tr"])
					,"deposit");

				Client tr = new Client();
				tr.ID = Convert.ToDecimal(Convert.ToString(Request["rnk_tr"]));
				tr.ReadFromDatabase();

				NMK		= tr.Name;
				OKPO	= tr.ID.ToString();
				PASP	= tr.DocTypeName;
				PASPN	= tr.DocSerial + " " + tr.DocNumber;
				ATRT	= tr.DocOrg  + " " + tr.DocDate.ToString("dd/MM/yyyy");;;
				DT_R	= tr.BirthDate.ToString("dd/MM/yyyy");
				ADRES	= tr.Address;

                rnk = Convert.ToString(tr.ID);
			}
			else
			{
				NMK		= dpt.Client.Name;
				PASP	= dpt.Client.DocTypeName;
				PASPN	= dpt.Client.DocSerial + " " + dpt.Client.DocNumber;
				ATRT	= dpt.Client.DocOrg + " " + dpt.Client.DocDate.ToString("dd/MM/yyyy");
				DT_R	= dpt.Client.BirthDate.ToString("dd/MM/yyyy");
				ADRES	= dpt.Client.Address;
                
                rnk = Convert.ToString(dpt.Client.ID);
			}

            //String dop_rec = "&FIO=" + NMK + "&PASP=" + PASP + "&PASPN=" + PASPN + 
            //                "&ATRT=" + ATRT + "&ADRES=" + ADRES + "&DT_R=" + DT_R;
            Random r = new Random();
            String dop_rec = "&RNK=" + rnk +
                "&Code=" + Convert.ToString(r.Next());
			
			if (OKPO != String.Empty)
				dop_rec += "&OKPO=" + OKPO;

			String dest = "DepositContractInfo.aspx?pro=long&dpt_id=" + dpt_id;

            string url = "\"/barsroot/DocInput/DocInput.aspx?tt=" + dpt.GetTT(DPT_OP.OP_43,CASH.NO) + "&nd=" + dpt_id + 
				"&Kv_A=" + Convert.ToString(dpt.Currency) + "&Nls_A="+ Convert.ToString(nls_p) +
				"&Kv_B=" + Convert.ToString(dpt.Currency) + "&Nls_B="+ Convert.ToString(nls_d) +
                "&SumC_t=" + sum_str + dop_rec + "&APROC=" +
                OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE") +
                "@" + "begin dpt_web.fill_dpt_payments(" + dpt_id + ",:REF);end;" + "\"";

			if (Convert.ToDecimal(sum_str) > 0)
				script = "<script>window.showModalDialog(encodeURI(" + url + "),null," +
					"'dialogWidth:700px; dialogHeight:800px; center:yes; status:no');" +
					"location.replace('" + dest + "');</script>";
			else
				script = "<script>location.replace('" + dest + "');</script>";
		}
		else if (rb_checked == "2")
		{
			script = "<script>location.replace('DepositSelectTrustee.aspx?dpt_id=" + dpt_id + "&dest=percent&fp=tr');</script>";
		}
		else
		{
            script = "<script>alert('" + Resources.Deposit.GlobalResources.ora02 + "');</script>";
            //script = "<script>alert('Не выбрана операция с процентами!');</script>";
			Response.Write(script);
			Response.Flush();
			return;
		}

		OracleConnection new_connect = new OracleConnection();
		try
		{
			// Открываем соединение с БД
			IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
			new_connect = conn.GetUserConnection();

			// Устанавливаем роль
			OracleCommand cmdSetRole = new_connect.CreateCommand();
			cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
			cmdSetRole.ExecuteNonQuery();	

			OracleCommand cmdProlongate = new_connect.CreateCommand();
			cmdProlongate.CommandText = "begin dpt.p_dpt_extension(:dpt_id,:new_dpt_end_date); end;";
			cmdProlongate.Parameters.Add("dpt_id",OracleDbType.Decimal,dpt_id,ParameterDirection.Input);
            cmdProlongate.Parameters.Add("new_dpt_end_date", OracleDbType.Date, textNewDptEndDate.Date, ParameterDirection.Input);

			cmdProlongate.ExecuteNonQuery();

			cmdProlongate.Parameters.Clear();
			cmdProlongate.CommandText = "update dpt_deposit set limit = :mlimit where deposit_id = :dpt_id";
			cmdProlongate.Parameters.Add("dpt_id",OracleDbType.Decimal,dpt_id,ParameterDirection.Input);
			cmdProlongate.Parameters.Add("limit",OracleDbType.Decimal,overallsum,ParameterDirection.Input);

			cmdProlongate.ExecuteNonQuery();
			cmdProlongate.Dispose();

            dpt.CreateProlongateText();

			if (rb_checked == "1")
			{
				DBLogger.Info("Пользователь выполнил пролонгацию депозитного договора №" 
					+ Convert.ToString(Request["dpt_id"]) + " с капитализацией начисленных процентов.",
					"deposit");
			}
			else if (rb_checked == "2")
			{ 
				DBLogger.Info("Пользователь выполнил пролонгацию депозитного договора №" 
					+ Convert.ToString(Request["dpt_id"]) + " с выплатой начисленных процентов.",
					"deposit");
			}
			Response.Write(script);
			Response.Flush();
		}
		finally	
		{
			if (new_connect.State != ConnectionState.Closed)
			{new_connect.Close();new_connect.Dispose();}
		}
	}
}