using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace clientregister
{
	/// <summary>
	/// Доп. информация
	/// </summary>
	public partial class tab_dop_inf : Bars.BarsPage
	{

		// Класс заемщика
		static private ListItemCollection CRisk_Source = null;
		// Принадлежность малому бизнесу
		static private ListItemCollection K140_Source = null;

		/// <summary>
		/// Правильное наполнение дропдаунов
		/// </summary>
		/// <param name="ItemsList">Чем наполнять</param>
		/// <param name="Target">Что наполнять</param>
		private void MyDataBind(ListItemCollection ItemsList, HtmlSelect Target)
		{
			Target.Items.Clear();
			for(int i=0; i<ItemsList.Count; i++)
			{
				ListItem tmp = new ListItem(ItemsList[i].Text,ItemsList[i].Value);
				Target.Items.Add(tmp);
			}
		}
		protected void Page_Load(object sender, System.EventArgs e)
		{
			if(!IsPostBack)
			{
				// Класс заемщика
				CRisk_Source = Client.GetLists.GetCRiskList(Context);
				MyDataBind(CRisk_Source, ddl_CRISK);
				// Принадлежность малому бизнесу
				K140_Source = Client.GetLists.GetK140List(Context);
				MyDataBind(K140_Source, ddl_MB);
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
