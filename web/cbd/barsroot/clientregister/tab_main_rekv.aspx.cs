using System;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace clientregister
{
	/// <summary>
	/// Закладка основные реквизиты
	/// </summary>
	public partial class tab_main_rekv : Bars.BarsPage
	{
		//наполнение признака инсайдера к060
		static private ListItemCollection PRINSIDER_Source = null;
		//наполнение вида выписки
		static private ListItemCollection STMT_Source = null;
		//наполнение TOBO
		static private ListItemCollection TOBO_Source = null;

	    /// <summary>
	    /// Правильное наполнение дропдаунов
	    /// </summary>
	    /// <param name="itemsList">Чем наполнять</param>
	    /// <param name="target">Что наполнять</param>
	    /// <param name="selectedValue">Выбраное значение по умолчанию</param>
	    private void MyDataBind(ListItemCollection itemsList, HtmlSelect target)
		{
			target.Items.Clear();
			for(int i=0; i<itemsList.Count; i++)
			{
				ListItem tmp = new ListItem(itemsList[i].Text,itemsList[i].Value);
				target.Items.Add(tmp);
			}
		}
		protected void Page_Load(object sender, System.EventArgs e)
		{
			if(!IsPostBack)
			{	
				//признак инсайдера к060
				PRINSIDER_Source = Client.GetLists.GetPrinsiderList(Context);
				MyDataBind(PRINSIDER_Source,ddl_PRINSIDER);
				//вид выписки
				STMT_Source = Client.GetLists.GetStmtList(Context);
				MyDataBind(STMT_Source,ddl_STMT);
				//страны наполняются на странице
				//TOBO
				TOBO_Source = Client.GetLists.GetTOBOList(Context);
				MyDataBind(TOBO_Source,ddl_TOBO);
				ed_TOBOCd.Value = ddl_TOBO.Items[ddl_TOBO.SelectedIndex].Value;
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
