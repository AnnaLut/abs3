using System;
using System.Web.UI.WebControls;
using Bars;

namespace barsroot.udeposit
{
  // ver. 22.07.2015
  public partial class DptDealParams : BarsPage
	{
	
		protected void Page_Load(object sender, EventArgs e)
		{
            if (!IsPostBack)
            {
                try
                {
                    InitOraConnection();
                    ddProduct.DataSource = SQL_SELECT_dataset("select TYPE_ID, TYPE_NAME from DPU_TYPES where FL_ACTIVE = 1 order by SORT_ORD");
                    ddProduct.DataBind();
                    ddProduct.Items.Add(new ListItem("","",true));
                    ddProduct.SelectedValue = "";

                    ddKv.DataSource = SQL_SELECT_dataset("select kv, name from tabval where d_close is null and kv in (select distinct kv from dpu_vidd)");
                    ddKv.DataBind();
                    ddKv.Items.Add(new ListItem("", "", true));
                    ddKv.SelectedValue = "";
                }
                finally
                {
                    DisposeOraConnection();
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
