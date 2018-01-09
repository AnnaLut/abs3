using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Classes;
using UnityBars.XmlForms.Engine;
using UnityBars.XmlForms.Classes;
using FastReport.Web;
using FastReport.Utils;
using FastReport;
using System.Collections.Specialized;


public partial class barsweb_dynmodal : System.Web.UI.Page
{

    private WebReport webReport;

    private Report report;

    protected void Page_Load(object sender, EventArgs e)
    {
        //это у нас так показываются отчеты fastreport
        if (Request["form"] == "fr")
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

            holder.Controls.Add(webReport);
            webReport.Prepare();

            //webReport.ExportPdf();

        }
        else
        {
            object form = Request["form"];
            if (form == null) return;
            String cs = OraConnector.Handler.IOraConnection.GetUserConnectionString();
            String providerName = "barsroot.core";
            XmlFormBuilder.ModalFormSrc = XmlModalFormSrc.AppRoot;
            holder.Controls.Add(XmlFormBuilder.BuildForm(form.ToString(), Page, cs, XmlFormPlaces.AppData, providerName));
        }
    }

}
