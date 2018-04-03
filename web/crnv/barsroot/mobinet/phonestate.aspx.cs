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

namespace mobinet
{
	/// <summary>
	/// Summary description for PhoneState.
	/// </summary>
	public partial class PhoneState : Bars.BarsPage
	{
		private void Page_Load(object sender, System.EventArgs e)
		{
			label_phone.Text	 = this.Request.Params["phone"];
			label_account.Text	 = this.Request.Params["account"];
			label_name.Text		 = this.Request.Params["name"];
			label_balance.Text   = this.Request.Params["balance"]+" грн.";
			label_timestamp.Text = this.Request.Params["time_stamp"];
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
