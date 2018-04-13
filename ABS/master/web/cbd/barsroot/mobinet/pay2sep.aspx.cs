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

namespace mobinet
{
	/// <summary>
	/// Summary description for Pay2SEP.
	/// </summary>
    public partial class Pay2SEP : Bars.BarsPage
	{
        private void InitHiddenFields()
        {
            this.InitOraConnection();
            try
            {
                this.SetRole("mobinet_admin");
                this.hd_signtype.Value = Convert.ToString(this.SQL_SELECT_scalar(
                    "SELECT val FROM params WHERE par='SIGNTYPE'"));
                this.hd_bankdate.Value = Convert.ToString(this.SQL_SELECT_scalar(
                    "select to_char(web_utl.get_bankdate, 'yyyy/MM/dd hh:mm:ss') from dual"));
                this.hd_regncode.Value = Convert.ToString(this.SQL_SELECT_scalar(
                    "SELECT nvl(val,'00') FROM params WHERE par='REGNCODE'"));
            }
            finally
            {
                this.DisposeOraConnection();
            }
        }

		private void Page_Load(object sender, System.EventArgs e)
		{
            if (!this.IsPostBack)
            {
                InitHiddenFields();
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
			this.date1.Load += new System.EventHandler(this.date1_Load);
			this.date2.Load += new System.EventHandler(this.date2_Load);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void date2_Load(object sender, System.EventArgs e)
		{			
			date2.Value = DateTime.Now.AddDays(-1);
		}
		private void date1_Load(object sender, System.EventArgs e)
		{
			date1.Value = DateTime.Now.AddDays(-15);
		}
	}
}
