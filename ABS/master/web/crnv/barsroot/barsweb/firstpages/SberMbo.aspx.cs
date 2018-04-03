using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Exception;
using Bars.Oracle;
using Oracle.DataAccess.Client;

namespace barsweb
{
	/// <summary>
	/// Summary description for Welcome.
	/// </summary>
	public partial class SberMbo : Page
	{
		protected Label labelUseTopMenu;
	
		protected void Page_Load(object sender, EventArgs e)
		{
			// проверка: открыт ли банковский день
			IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
			OracleConnection connect;
			try
			{
				connect = conn.GetUserConnection(Context);
				connect.Close();
			}
			catch(BankdateClosedException bde)
			{
				this.labelBankdateClosed.Text = bde.Message;
			}
		}
		public void Transfer(string Path)
		{
			Server.Transfer(Path);
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
