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
	/// Закладка реквизиты налогоплательщика
	/// </summary>
	public partial class tab_rekv_nalogoplat : Bars.BarsPage
	{	
	
		//наполнение Обласная НИ
		static private ListItemCollection C_reg_Source = null;
		
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
		protected void Page_Load(object sender, EventArgs e)
		{
			if(!IsPostBack)
			{
				//Обласная НИ
				C_reg_Source = Client.GetLists.GetC_regList(Context);
				MyDataBind(C_reg_Source, ddl_C_REG);

                var custmpni = GetGlobalParam("CUSTMNI", "");
                if (custmpni == "1")
                {
                    ckb_main.Disabled = true;
                    ckb_main.Checked = true;
                }
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
