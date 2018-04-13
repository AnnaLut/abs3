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
using Oracle.DataAccess.Client;
using Bars.Oracle;
using Bars.Logger;

namespace mobinet
{
	/// <summary>
	/// Главная страница пополнения счета Киевстар
	/// </summary>
    public partial class Default : Bars.BarsPage
	{
		private int flagValDate = 0;
	
		private void Page_Load(object sender, System.EventArgs e)
		{
			if(null!=Request.Params["valdate"])
				flagValDate = int.Parse(Request.Params["valdate"]);
		}

		private void FillInputCash()
		{
            OracleConnection con = Bars.Classes.OraConnector.Handler.UserConnection;
			try
			{
				OracleCommand cmd = new OracleCommand();
				cmd.Connection = con;
				cmd.CommandText = "set role basic_info,mobinet";
				cmd.ExecuteNonQuery();
				cmd.CommandText = @"select mobi.GetUserCash,
					GetUserCashNms,
					to_char(mobi.GetCurBankDate, 'DD.MM.YYYY'),
					to_char(mobi.GetNextBankDate,'DD.MM.YYYY')
				from dual";
				OracleDataReader rdr = cmd.ExecuteReader();
				if(!rdr.Read()) throw new Exception("Запрос не вернул строк.");
				if(rdr.IsDBNull(0)) throw new Exception("Счет кассы не задан!");
				inputCash.Text = rdr.GetOracleString(0).Value;
				if(!rdr.IsDBNull(1)) inputCash.ToolTip = rdr.GetOracleString(1).Value;
				else inputCash.ToolTip = "";
				if(1==flagValDate) inputValDate.Text = rdr.GetOracleString(3).Value;
				else			   inputValDate.Text = rdr.GetOracleString(2).Value;
				rdr.Close();
			}
			finally
			{
				con.Close();
				con.Dispose();
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
			this.inputCash.Load += new System.EventHandler(this.inputCash_Load);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void inputCash_Load(object sender, System.EventArgs e)
		{
			FillInputCash();
		}
	}
}
