using System;
using System.Web.UI;
using Bars.Web.Report;

namespace ViewAccounts
{
	public partial class Print : Bars.BarsPage
	{
		private void Page_Load(object sender, EventArgs e)
		{
			//Application["OracleConnectClass"] = AppDomain.CurrentDomain.GetData("OracleConnectClass");
			RtfReporter rep = new RtfReporter(Context);
			rep.RoleList = "reporter,cc_doc";
			rep.ContractNumber = Convert.ToInt64(Request.Params["acc"]);
			rep.TemplateID = Request.Params["ID"];
			try
			{  
				rep.Generate();
				Response.ClearContent();
				Response.ClearHeaders();
				//Response.ContentType = "application/octet-stream";
				//Response.AddHeader( "Content-Disposition","attachment;filename=DOCUMENT.rtf" );
                Response.ContentType = "text/html";
                Response.AddHeader("Content-Disposition", "inline;filename=contract.html");
				Response.WriteFile(rep.ReportFile);
				Response.Flush();
				Response.End();
			}
			finally
			{
				rep.DeleteReportFiles();
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
			this.Load += new EventHandler(this.Page_Load);

		}
		#endregion
	}
}
