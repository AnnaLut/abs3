using System;

namespace barsroot.udeposit
{
	public partial class Default : Bars.BarsPage
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if(Request.Params.Get("mode") == null)
				throw new Exception("Не задан параметр mode!");
			if(Request.Params.Get("flt") == null)
				throw new Exception("Не задан параметр flt!");

			decimal mode = Convert.ToDecimal(Request.Params.Get("mode"));
			if(mode != 0 && mode != 1 && mode != 2)
				throw new Exception("Недопустимое значение параметра mode!");
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
