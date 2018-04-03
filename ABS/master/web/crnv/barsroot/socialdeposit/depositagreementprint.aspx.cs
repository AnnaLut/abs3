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

/// <summary>
/// Summary description for DepositAgreementPrint.
/// </summary>
public partial class DepositAgreementPrint : Bars.BarsPage
{
	/// <summary>
	/// 
	/// </summary>
	/// <param name="sender"></param>
	/// <param name="e"></param>
	private void Page_Load(object sender, System.EventArgs e)
	{
		OracleConnection connect = new OracleConnection();

		if (!IsPostBack)
			btPrint.Disabled = true;

		EnablePrint();

		try
		{
			if (Request["dpt_id"] == null)
				Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");
			if (Request["agr_id"] == null)
				Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");
			if (Request["template"] == null)
				Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");

			Decimal dpt_id		= Convert.ToDecimal(Request["dpt_id"]);
			Decimal agr_id		= Convert.ToDecimal(Request["agr_id"]);
			String  t_id		= Convert.ToString(Request["template"]);
			template.Value = t_id;
			textAgrId.Value		= agr_id.ToString();
			textDptNum.Text		= Convert.ToString(Session["DPT_NUM"]);
            textDptId.Value     = Convert.ToString(dpt_id);

			// Открываем соединение с БД
			IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
			connect = conn.GetUserConnection();
			

			OracleCommand cmdSetRole = connect.CreateCommand();
			cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
			cmdSetRole.ExecuteNonQuery();

			OracleCommand cmdSearch = connect.CreateCommand();			
			cmdSearch.CommandText = "select name from dpt_vidd_flags where id = :id";
			cmdSearch.Parameters.Add("id",OracleDbType.Decimal,agr_id,ParameterDirection.Input);

            textAgrType.Text = Convert.ToString(cmdSearch.ExecuteScalar());
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
		this.btForm.Click += new System.EventHandler(this.btForm_Click);
		this.btNextAgr.Click += new System.EventHandler(this.btNextAgrSameType_Click);
		this.Load += new System.EventHandler(this.Page_Load);

	}
	#endregion
	private void btForm_Click(object sender, System.EventArgs e)
	{
		OracleConnection connect = new OracleConnection();

		SocialDeposit dpt = new SocialDeposit();
		dpt.ID = Convert.ToDecimal(Request["dpt_id"]);
		dpt.ReadFromDatabase(Context);

		try
		{
			// Открываем соединение с БД
			IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
			connect = conn.GetUserConnection();
			

			OracleCommand cmdSetRole = connect.CreateCommand();
			cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
			cmdSetRole.ExecuteNonQuery();

			String t_id = Convert.ToString(template.Value);
			Decimal dpt_id = dpt.ID;
			Decimal agr_id = Convert.ToDecimal(textAgrId.Value);
			Decimal agr_num = Decimal.MinValue;
			Decimal rnk = Convert.ToDecimal(Convert.ToString(Request["rnk"]));

			/// Потрібно зареєструвати клієнта як довірену особу
			/// або відмінити дод. угоду
			if (Request["rnk"]!=null)
			{
                Decimal trust_id = Decimal.MinValue;

                OracleCommand cmdRegister = connect.CreateCommand();
                cmdRegister.CommandText = "begin dpt_social.p_supplementary_agreement(:contract_id,:flag_id,:trust_rnk,:trust_id);end;";

                cmdRegister.Parameters.Add("contract_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
                cmdRegister.Parameters.Add("flag_id", OracleDbType.Decimal, agr_id, ParameterDirection.Input);
                cmdRegister.Parameters.Add("trust_rnk", OracleDbType.Decimal, rnk, ParameterDirection.Input);
                cmdRegister.Parameters.Add("trust_id", OracleDbType.Decimal, trust_id, ParameterDirection.Output);
			
				cmdRegister.ExecuteNonQuery();
                
                String[] _params = new String[1];
                _params[0] = Convert.ToString(cmdRegister.Parameters["trust_id"].Value);
                agr_num = dpt.WriteAddAgreement(Context, _params);
			}
        				 
			textAgrNum.Value = agr_num.ToString();

			OracleCommand cmdSearch = new OracleCommand();
			cmdSearch.Connection = connect;			
			cmdSearch.CommandText = "select to_char(c.version,'dd/mm/yyyy') from cc_docs c " +
				"where c.id=:template and c.nd = :dpt_id and c.adds = :agr_num ";

			cmdSearch.Parameters.Add("template",OracleDbType.Varchar2,t_id,ParameterDirection.Input);
			cmdSearch.Parameters.Add("dpt_id", OracleDbType.Decimal,dpt_id,ParameterDirection.Input);
			cmdSearch.Parameters.Add("agr_num",OracleDbType.Decimal,agr_num,ParameterDirection.Input);
	
			CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
			cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
			cinfo.DateTimeFormat.DateSeparator = "/";

			String dt = Convert.ToString(cmdSearch.ExecuteScalar());
			dtDate.Date = Convert.ToDateTime(dt,cinfo);

			btPrint.Disabled = false;
			btForm.Enabled   = false;
			
			if (BankType.GetCurrentBank() == BANKTYPE.PRVX)
				btNextAgr.Visible = true;

			DBLogger.Info("Текст доп соглашения № " + agr_num.ToString() +
				" по депозитному договору №" + dpt.ID.ToString() + " успешно сформирован и записан в базу.",
				"SocialDeposit");
		}
		finally	
		{
			if (connect.State != ConnectionState.Closed)
				{connect.Close();connect.Dispose();}
		}
	}
	/// <summary>
	/// 
	/// </summary>
	/// <param name="sender"></param>
	/// <param name="e"></param>
	private void btNextAgrSameType_Click(object sender, System.EventArgs e)
	{
		if (Request["dpt_id"] == null)
			Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");
		if (Request["agr_id"] == null)
			Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");
		
		Decimal dpt_id = Convert.ToDecimal(Convert.ToString(Request["dpt_id"]));
		
		Response.Redirect("DepositSelectTrustee.aspx?dpt_id=" + dpt_id.ToString() + "&dest=agreement");
	}
	/// <summary>
	/// 
	/// </summary>
	private void EnablePrint()
	{
		OracleConnection connect = new OracleConnection();
		try
		{
			// Открываем соединение с БД
			IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
			connect = conn.GetUserConnection();
			

			OracleCommand cmd = connect.CreateCommand();
			cmd.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
			cmd.ExecuteNonQuery();

			cmd.CommandText = "SELECT VAL FROM PARAMS WHERE PAR='C_FORMAT'";
			string result = Convert.ToString(cmd.ExecuteScalar());

			if (result == "HTML")
				btPrint.Attributes["onclick"] = "javascript:AddAgreementPrint();";
            else if (result == "RTF")
                btPrint.Attributes["onclick"] = "javascript:AddAgreementPrint_rtf();";
            else
            {
                btPrint.Attributes["onclick"] = "javascript:alert('Формат документов не поддерживается');";
            }
        }
		finally	
		{
			if (connect.State != ConnectionState.Closed)
			{connect.Close();connect.Dispose();}
		}

	}
}
