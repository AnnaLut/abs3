using System;
using System.Collections;
using System.Globalization;
using System.Web.UI.WebControls;
using Bars;
using Oracle.DataAccess.Types;

namespace DocInput
{
	/// <summary>
	/// Summary description for SetRates.
	/// </summary>
	public partial class SetRates : BarsPage
	{
	
		CultureInfo cinfo;
		private string[] valuts = new string[3] {"840","978","643"};
		
		protected void Page_Load(object sender, EventArgs e)
		{
			cinfo = CultureInfo.CreateSpecificCulture("en-GB");
			cinfo.NumberFormat.CurrencyDecimalSeparator = ".";
			if(!IsPostBack)
				FillData();
		}
		private void  FillData()
		{
			try
			{
				if(Convert.ToString(Request.Params.Get("readonly")) == "1")
				{
					Rate1_B.ReadOnly = true;
					Rate2_B.ReadOnly = true;
					Rate3_B.ReadOnly = true;
					Rate1_S.ReadOnly = true;
					Rate2_S.ReadOnly = true;
					Rate3_S.ReadOnly = true;
					btSave.Disabled = true;
					lbTitle.Text = "Просмотр курса валют";
				}
				InitOraConnection();
				
				SetRole("WR_DOC_INPUT");
				string baseVal =  Convert.ToString(SQL_SELECT_scalar("SELECT val FROM params WHERE par='BASEVAL'"));
				
				string kv_name_query = "SELECT name||'('||lcv||')' from tabval where kv=:kv";
				SetParameters("kv",DB_TYPE.Decimal, baseVal, DIRECTION.Input);
				lbBaseVal.Text += " "+Convert.ToString(SQL_SELECT_scalar(kv_name_query));
					
				string rates_query = "select RATE_B,RATE_S from v_tobo_currates where kv=:kv";
				for(int i = 0;i < valuts.Length; i++)
				{
					ClearParameters();
					SetParameters("kv", DB_TYPE.Decimal, valuts[i], DIRECTION.Input);
					string val_name = Convert.ToString(SQL_SELECT_scalar(kv_name_query));
					string rate_b = string.Empty;
					string rate_s = string.Empty;
					decimal bsum = 0;
	
					SQL_Reader_Exec(rates_query);
					if(SQL_Reader_Read())
					{ 
						ArrayList rdr = SQL_Reader_GetValues();
						rate_b =  Convert.ToString(rdr[0]);
						rate_s = Convert.ToString(rdr[1]);
					}
                    SQL_Reader_Close();
					bsum = Convert.ToDecimal(SQL_SELECT_scalar("select nominal from tabval where kv=:kv"));
					
					ClearParameters();
					SetParameters("rat_o",DB_TYPE.Decimal, 0, DIRECTION.Output);
					SetParameters("rat_b",DB_TYPE.Decimal, 0, DIRECTION.Output);
					SetParameters("rat_s",DB_TYPE.Decimal, 0, DIRECTION.Output);
					SetParameters("kv1_",DB_TYPE.Decimal, valuts[i], DIRECTION.Input);
					SetParameters("kv2_",DB_TYPE.Decimal, baseVal, DIRECTION.Input);
					
					SQL_NONQUERY("begin GL.x_rat(:rat_o,:rat_b, :rat_s, :kv1_, :kv2_, web_utl.get_bankdate); end;");
					
				 	//string rat_go = Convert.ToString(GetParameter("rat_o")).ToString("F");
                    OracleDecimal rat_o = (OracleDecimal)GetParameter("rat_o");
                    FillBoxes(i, val_name, rate_b, rate_s, bsum, Convert.ToDecimal(rat_o.Value, cinfo));
				}
			}
			finally
			{
				DisposeOraConnection();
			}		
		}

		private void FillBoxes(int index,string val_name,string rate_b,string rate_s,decimal bsum,decimal rat_go)
		{
			decimal r_go = rat_go*bsum;
			switch(index + 1) 
			{
				case 1 : 
					lbKv1.Text = val_name;
					Rate1_B.Text = rate_b;
					Rate1_S.Text = rate_s;
					BSum1.Text =  Convert.ToInt32(bsum).ToString();
					Rate1_GO.Text = r_go.ToString("F");
					break;
				case 2 : 
					lbKv2.Text = val_name;
					Rate2_B.Text = rate_b;
					Rate2_S.Text = rate_s;
					BSum2.Text = Convert.ToInt32(bsum).ToString();
					Rate2_GO.Text = r_go.ToString("F");
					break;
				case 3 : 
					lbKv3.Text = val_name;
					Rate3_B.Text = rate_b;
					Rate3_S.Text = rate_s;
					BSum3.Text = Convert.ToInt32(bsum).ToString();
					Rate3_GO.Text = r_go.ToString("F");
					break;
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

		}
		#endregion
	}
}
