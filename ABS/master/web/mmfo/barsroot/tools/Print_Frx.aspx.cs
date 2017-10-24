using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FastReport.Web;
using FastReport.Utils;
using FastReport;
using Bars.Classes;

public partial class tools_Print_Frx : System.Web.UI.Page
{

    private WebReport webReport;

    private Report report;

    protected void Page_Load(object sender, EventArgs e)
    {
        
            FastReport.Utils.RegisteredObjects.AddConnection(typeof(FastReport.Data.OracleDataConnection));
            report = new FastReport.Report();
            report.Load(HttpContext.Current.Server.MapPath(String.Format("~/App_Data/reports/{0}.frx", Request["frt"])));


            webReport = new WebReport();
            webReport.Width = Unit.Percentage(100);
            webReport.Height = Unit.Percentage(100);
            webReport.Page = this;


            report.Report.Dictionary.Connections[0].ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
            webReport.Report = report;

            foreach (string key in Request.QueryString.AllKeys)
            {
                report.Report.SetParameterValue(key, Request[key]);
            }

            //это или баг или фича, если стейт не установить - работать не будет
            webReport.State = ReportState.Done;
            webReport.ShowToolbar = true;
            webReport.ShowExports = false;
            webReport.Height = 700;
            webReport.BorderStyle = BorderStyle.Outset;
            webReport.ToolbarStyle = ToolbarStyle.Small;
            webReport.ToolbarIconsStyle = ToolbarIconsStyle.Blue;   


            webReport.ShowPrint = false;
            webReport.ShowRefreshButton = false;

            holder.Controls.Add(webReport);
        
            webReport.Prepare();
        

    }


    private void FRX_RTD()
    {

        String DOCEXP_TYPE_ID;

        FrxParameters pars = new FrxParameters();

        foreach (string key in Request.QueryString.AllKeys)
        {
            pars.Add(new FrxParameter(key, TypeCode.String, Request[key]));
        }
     
           FrxDoc doc = new FrxDoc(
             HttpContext.Current.Server.MapPath(String.Format("~/App_Data/reports/{0}.frx", Request["frt"])),
                  pars,
                this.Page);

           DOCEXP_TYPE_ID = Dd_list.SelectedValue;

           switch (DOCEXP_TYPE_ID)
           {
               case "PDF": doc.Print(FrxExportTypes.Pdf);
                   break;
               case "RTF": doc.Print(FrxExportTypes.Rtf);
                   break;
               case "XLS": doc.Print(FrxExportTypes.Excel2007);
                   break;
               default: doc.Print(FrxExportTypes.Pdf);
                   break;
           }


    }
    protected void Bt_print_Click(object sender, EventArgs e)
    {
        FRX_RTD();
    }
}