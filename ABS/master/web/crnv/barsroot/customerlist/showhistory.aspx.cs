using System;
using System.Collections;
using Bars;

namespace CustomerList
{
	/// <summary>
	/// Веб-страница показывает историю счета аналогично комплексу Барс
	/// </summary>
	/// 
	public partial class ShowHistory : BarsPage
	{
		/// <summary>
		/// Роль приложения
		/// </summary>
		private string role = "";
		/// <summary>
		/// параметр страницы acc 
		/// </summary>
		private decimal acc;	
		/// <summary>
		/// перменные для передачи переода на страничку выписки по счету
		/// </summary>
		private string E, S;
		
		
		/// <summary>
		/// Проверяет коректность переданых параметров
		/// </summary>
		private void CheckPageParams()
		{
			//-- тип просмотра
			if(Request.Params.Get("type") != null)
			{
				string type = Request.Params.Get("type");
				switch (type)
				{
					case "0" : role = "wr_custlist";
						break;
					case "1" : role = "WR_USER_ACCOUNTS_LIST";
						break;
					case "2" : role = "WR_TOBO_ACCOUNTS_LIST";
						break;
					case "3" : role = "WR_ND_ACCOUNTS";
						break;
					case "4" : role = "WR_DEPOSIT_U";
						break;
					default : throw new Exception("Неверный параметр type!");
				}
			}
			else throw new Exception("Не задан параметр type!");				
			
			//-- acc счета для просмотра
			if(Request.Params.Get("acc") != null)
			{
				acc = Convert.ToDecimal(Request.Params.Get("acc"));
			}
			else throw new Exception("Не задан параметр acc!");				
		}
		/// <summary>
		/// инициализация переменных E и S
		/// </summary>
		private void GetDates()
		{
			try
			{   
				InitOraConnection(Context);
				
				SetRole("basic_info");
				hPrintFlag.Value = Convert.ToString(SQL_SELECT_scalar("select val from params where par='W_PRNVP'"));
 
				SetRole(role);

				ArrayList reader = SQL_reader("SELECT to_char(min(fdat),'dd.MM.yyyy'), to_char(bankdate,'dd.MM.yyyy') FROM fdat WHERE fdat < bankdate and fdat >= add_months(bankdate,-1)");
				if(reader.Count != 0)
				{
					S = Convert.ToString(reader[0]);
					E = Convert.ToString(reader[1]);
				}

                if (S.Trim() == "")
                {
                    System.Globalization.DateTimeFormatInfo dtf = new System.Globalization.DateTimeFormatInfo();
                    dtf.ShortDatePattern = "dd.MM.yyyy";
                    dtf.DateSeparator = ".";

                    S = Convert.ToDateTime(E, dtf).AddMonths(-1).ToString("dd.MM.yyyy", dtf);
                }
			}
			finally
			{
				DisposeOraConnection();
			}			
		}
		
		private void Page_Load(object sender, EventArgs e)
		{			
			if(!IsPostBack) 
			{
				// параметры страницы
				CheckPageParams();
				// даты
				GetDates();

				ed_strDt_TextBox.Text = S;
                ed_endDt_TextBox.Text = E;
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
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion		
	}
}
