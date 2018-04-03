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

namespace BarsWeb.CheckInner
{
	public partial class StornoReason : Bars.BarsPage
	{
	
		protected void Page_Load(object sender, System.EventArgs e)
		{
			AppPars Params = new AppPars(Request.Params.Get("type"));

			DataTable dt = new DataTable();

			try
			{
				InitOraConnection(Context);

				SetRole(Params.Role);

				dt = SQL_SELECT_dataset("SELECT ID, REASON FROM BP_REASON ORDER BY ID").Tables[0];
			}
			finally
			{
				DisposeOraConnection();
			}

			for(int i=0; i<dt.Rows.Count; i++)
			{
				System.Web.UI.HtmlControls.HtmlTableRow row = new HtmlTableRow();

				System.Web.UI.HtmlControls.HtmlTableCell cell0 = new HtmlTableCell();
				cell0.Style.Add("PADDING-RIGHT","3px");
				cell0.Style.Add("PADDING-LEFT","3px");
				System.Web.UI.HtmlControls.HtmlTableCell cell1 = new HtmlTableCell();
				cell1.Style.Add("PADDING-RIGHT","3px");
				cell1.Style.Add("PADDING-LEFT","3px");
					
				cell0.InnerHtml = "<a href=# onclick='PutVal("+dt.Rows[i].ItemArray.GetValue(0).ToString().Trim()+")'>" + dt.Rows[i].ItemArray.GetValue(0).ToString().Trim() + "</a>";
				cell1.InnerHtml = "<a href=# onclick='PutVal("+dt.Rows[i].ItemArray.GetValue(0).ToString().Trim()+")'>" + dt.Rows[i].ItemArray.GetValue(1).ToString().Trim() + "</a>";
				
				row.Cells.Add(cell0);
				row.Cells.Add(cell1);

				Reason.Rows.Add(row);
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
