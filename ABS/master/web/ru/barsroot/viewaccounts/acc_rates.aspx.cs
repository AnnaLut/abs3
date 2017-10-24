using System;
namespace ViewAccounts
{
	public partial class Tab6 :Bars.BarsPage
	{
		private void Page_Load(object sender, EventArgs e)
		{
            if (Request.Params.Get("accessmode") == "0")
                hintDiv.Visible = false;
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
		
		
		private void InitializeComponent()
		{    
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion
	}
}
