using System;
using System.Data;
using System.IO;
using System.Text;
using System.Web.UI;
//using CrystalDecisions.CrystalReports.Engine;
//using CrystalDecisions.Shared;

namespace BarsWeb.BasicFunctions.Reports
{
	/// <summary>
	/// Summary description for PrintReport.
	/// </summary>
	public partial class PrintReport : Page
	{
		private void Page_Load(object sender, EventArgs e)
		{
			BindReport_AcrInt();
		}
		
		/*private void BuldReport(ReportClass oRpt,DataSet ds)
		{
			int format = (Request.Params.Get("format") == null)?(0):(Convert.ToInt32(Request.Params.Get("format")));
			oRpt.SetDataSource(ds.Tables[0]);
			
			bool inline = (Request.Params.Get("disposition") == null || Request.Params.Get("disposition") == "inline")?(true):(false);
			string ContentDisposition = (inline)?("inline"):("attachment");

			string tempDir = Path.GetTempPath(); 
			string tempFileName = "rpt_"+DateTime.Now.ToString("dd_MM_yyyy_HH_mm_ss_fffffff");
			string tempFileNameUsed = "";

			DiskFileDestinationOptions crDiskFileDestinationOptions = new DiskFileDestinationOptions();
			ExportOptions crExportOptions = oRpt.ExportOptions;
			crExportOptions.ExportDestinationType = ExportDestinationType.DiskFile;
			StreamReader sr = null;
			
			Response.ClearContent();
			Response.ClearHeaders();
			Response.Charset = "windows-1251";
			Response.ContentEncoding = Encoding.GetEncoding("windows-1251");
			switch (format)
			{
				case 0: tempFileName += ".htm";
					HTMLFormatOptions htmlFormatOptions = new HTMLFormatOptions();
					crExportOptions.ExportFormatType = ExportFormatType.HTML40;
					htmlFormatOptions.HTMLBaseFolderName = tempDir;
					htmlFormatOptions.HTMLFileName = tempFileName;
					htmlFormatOptions.HTMLEnableSeparatedPages = false;
					htmlFormatOptions.HTMLHasPageNavigator = false;
					htmlFormatOptions.FirstPageNumber = 1;
					htmlFormatOptions.LastPageNumber = 1;
					crExportOptions.FormatOptions = htmlFormatOptions;
					Response.ContentType = "text/html";
					break;
				case 1: tempFileName += ".doc";
					tempFileNameUsed = tempDir+"\\"+tempFileName;
					crDiskFileDestinationOptions.DiskFileName = tempFileNameUsed; 
					crExportOptions.ExportFormatType = ExportFormatType.WordForWindows;
					crExportOptions.DestinationOptions = crDiskFileDestinationOptions;
					Response.ContentType = "application/msword";
					Response.AppendHeader("content-disposition",ContentDisposition+";filename=ticket.rtf");
					break;
				case 2: tempFileName += ".pdf";
					tempFileNameUsed = tempDir+"\\"+tempFileName;
					crDiskFileDestinationOptions.DiskFileName = tempFileNameUsed; 
					crExportOptions.ExportFormatType = ExportFormatType.PortableDocFormat;
					crExportOptions.DestinationOptions = crDiskFileDestinationOptions;
					Response.ContentType = "application/pdf";
					Response.AppendHeader("content-disposition",ContentDisposition+";filename=ticket.pdf");
					break;
				case 3: tempFileName += ".xls";
					tempFileNameUsed = tempDir+"\\"+tempFileName;
					crDiskFileDestinationOptions.DiskFileName = tempFileNameUsed; 
					crExportOptions.ExportFormatType = ExportFormatType.Excel;
					crExportOptions.DestinationOptions = crDiskFileDestinationOptions;
					Response.ContentType = "application/vnd.ms-excel";
					Response.AppendHeader("content-disposition",ContentDisposition+";filename=ticket.xls");
					break;
			}
			
			oRpt.Export();

			if(format == 0)
			{
				string[] fp = oRpt.FilePath.Split("\\".ToCharArray()); 
				string leafDir = fp[fp.Length-1]; 
				leafDir = leafDir.Substring(0, leafDir.Length - 4);
				tempFileNameUsed = string.Format("{0}{1}\\{2}", tempDir, leafDir, tempFileName); 
				sr = new StreamReader(tempFileNameUsed,Encoding.GetEncoding("utf-8")); 
				Response.Write(sr.ReadToEnd());
			}
			else
				Response.WriteFile(tempFileNameUsed);

			Response.Flush();			
			Response.End();
			try
			{
				File.Delete(tempFileNameUsed);
				File.Delete(oRpt.FilePath);
			}
			catch{}
		}*/
		/// <summary>
		/// Начисление процентов
		/// </summary>
		private void BindReport_AcrInt()
		{
			/*Reports.rptAcrIntU oRpt = new Reports.rptAcrIntU();
			string key = Request.Params.Get("key");
			object[] obj = (object[])AppDomain.CurrentDomain.GetData(key);
			DataSet ds = (DataSet)obj[0];
			oRpt.SetParameterValue("paramMFO",obj[1]);
			oRpt.SetParameterValue("paramNB",obj[2]);
			oRpt.SetParameterValue("paramBoss",obj[3]);
			oRpt.SetParameterValue("paramReportData",obj[4]);
			oRpt.SetParameterValue("paramVyk",obj[5]);
			oRpt.SetParameterValue("paramBoss1",obj[6]);
			oRpt.SetParameterValue("paramBoss2",obj[7]);
			BuldReport(oRpt,ds);
			AppDomain.CurrentDomain.SetData(key,null);*/
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
