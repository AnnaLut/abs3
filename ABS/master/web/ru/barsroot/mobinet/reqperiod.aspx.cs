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
using System.Globalization;

namespace mobinet
{
	/// <summary>
	/// Summary description for ReqPeriod.
	/// </summary>
    public partial class ReqPeriod : Bars.BarsPage
	{
		private void Page_Load(object sender, System.EventArgs e)
		{
			string strAct = Request.Params["act"];
			if(null==strAct) throw new Exception("Параметр act не задан");
			int act = int.Parse(strAct);
			if(act!=1 && act!=3) throw new Exception("Недопустимое значение параметра act. Укажите 1 или 3.");

			if(!this.IsPostBack)
			{				
				this.dt_start.Value  = System.DateTime.Now.AddDays(-3);
				this.dt_finish.Value = System.DateTime.Now;
				this.dt_start.Date  = System.DateTime.Now.AddDays(-3);
				this.dt_finish.Date = System.DateTime.Now;
			}
			else
			{
				CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
				cinfo.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";
				cinfo.DateTimeFormat.DateSeparator = ".";								
				DateTime dt1 = this.dt_start.Date;
				DateTime dt2;
				if(1==dt_finish.Date.Day && 1==dt_finish.Date.Month && 1==dt_finish.Date.Year)
					dt2 = DateTime.Now;
				else
					dt2 = this.dt_finish.Date;
				string str_dt1 = dt1.ToString("d", cinfo.DateTimeFormat);
				string str_dt2 = dt2.ToString("d", cinfo.DateTimeFormat);
				string strUrl = "/barsroot/mobinet/mytrans.aspx?act="+strAct+"&start="+str_dt1+"&finish="+str_dt2;
				Response.Redirect(strUrl);
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
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion
	}
}
