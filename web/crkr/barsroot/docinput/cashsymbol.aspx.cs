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
using Bars.Oracle;
using Oracle.DataAccess.Client;


namespace DocInput
{
	/// <summary>
	/// Summary description for CashSymbol.
	/// </summary>
	public partial class CashSymbol : System.Web.UI.Page
	{
		private byte _dk;
		private void Page_Load(object sender, System.EventArgs e)
		{
			if(null==Request.Params["dk"]) 
				throw new Exception("Параметр dk не задан");
			_dk = byte.Parse(Request.Params["dk"]);

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
			this.gsk.Load += new System.EventHandler(this.gsk_Load);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void gsk_Load(object sender, System.EventArgs e)
		{
			IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
			gsk.ConnectionString = conn.GetUserConnectionString(Context);
			gsk.RoleList = "WR_DOC_INPUT";
			if(0==_dk || 2==_dk)
				gsk.SelectText = "select sk,name from sk where sk<40";
			else
				gsk.SelectText = "select sk,name from sk where sk>=40";
			gsk.InitialSortingColumn = "sk";
			gsk.InitialSortingDirection = Bars.Grid.SortOrder.Asc;
		}

	}
}
