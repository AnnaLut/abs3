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

namespace clientregister
{
	/// <summary>
	/// Summary description for organdoclist.
	/// </summary>
	public partial class organdoclist : Bars.BarsPage
	{
	
		protected void Page_Load(object sender, System.EventArgs e)
		{
			InitOraConnection();
            SetRole("WR_CUSTREG");
			DataSet ds = new DataSet();

			try
			{
				ds = SQL_SELECT_dataset("SELECT NAME FROM ORGANDOK ORDER BY ID");
			}
			catch
			{
				DisposeOraConnection();
			}
			tbl_organdoclist.Rows.Clear();
			for(int i=0; i<ds.Tables[0].Rows.Count; i++)
			{
				System.Web.UI.HtmlControls.HtmlTableRow row = new HtmlTableRow();
				System.Web.UI.HtmlControls.HtmlTableCell cell = new HtmlTableCell();
				cell.InnerHtml = "<a href=# onclick=\"PutValue('"+ds.Tables[0].Rows[i].ItemArray.GetValue(0).ToString().Replace("'","\\'")+"')\">"+ds.Tables[0].Rows[i].ItemArray.GetValue(0).ToString()+"</a>";
				cell.Align = "left";
				cell.Style.Add("PADDING-LEFT","20px");
				row.Cells.Add(cell);
				tbl_organdoclist.Rows.Add(row);
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
