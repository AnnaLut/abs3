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
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;


public partial class tools_Print_fin : Bars.BarsPage //System.Web.UI.Page
{

    private WebReport webReport;

    private Report report;

    protected void Page_Load(object sender, EventArgs e)
    {

             if ( Convert.ToString(Request["back"]) == "NOT" )
             {
                 Ib_back.Visible = false;
             }
             else
             {
               if (!IsPostBack)
                {
                   //  сохраняем страничку с которой перешли
                    ViewState.Add("PREV_URL", Request.UrlReferrer.PathAndQuery);
                }
               
             }

        if (!IsPostBack & !String.IsNullOrEmpty(Convert.ToString(Request["nd"])))
        {
         
               try
            {
                InitOraConnection();
                Dl_sFdat1.DataSource = SQL_SELECT_dataset("select to_char(fdat,'dd/mm/yyyy') fdat from fin_dat where nd = " + Convert.ToString(Request["nd"]) + " order by fdat desc").Tables[0];
                Dl_sFdat1.DataTextField = "fdat";
                Dl_sFdat1.DataValueField = "fdat";
                Dl_sFdat1.DataBind();
                Dl_sFdat2.DataSource = SQL_SELECT_dataset("select to_char(fdat,'dd/mm/yyyy') fdat from fin_dat where nd = " + Convert.ToString(Request["nd"]) + " order by fdat desc").Tables[0];
                Dl_sFdat2.DataTextField = "fdat";
                Dl_sFdat2.DataValueField = "fdat";
                Dl_sFdat2.DataBind();
            }
               finally
               {
                   DisposeOraConnection();
               }


            foreach (string key in Request.QueryString.AllKeys)
            {
                if (key == "sfdat1")
                { Dl_sFdat1.SelectedValue = Request[key]; Dl_sFdat1.Visible = true; Lb1.Visible = true; Bt_run.Visible = true; }
                else if (key == "sfdat2")
                { Dl_sFdat2.SelectedValue = Request[key]; Dl_sFdat2.Visible = true; Lb2.Visible = true; Bt_run.Visible = true; }
                
            }

            

        }

         if (!IsPostBack)  FRT_WINDOW();

       }


    private void FRT_WINDOW()
    {
        FastReport.Utils.RegisteredObjects.AddConnection(typeof(FastReport.Data.OracleDataConnection));
        report = new FastReport.Report();
        //report.Load(HttpContext.Current.Server.MapPath(String.Format("~/App_Data/reports/{0}.frx", Request["frt"])));
        report.Load(HttpContext.Current.Server.MapPath(String.Format("/Template.rpt/{0}.frx", Request["frt"])));


        webReport = new WebReport();
        webReport.Width = Unit.Percentage(100);
        webReport.Height = Unit.Percentage(100);
        webReport.Page = this;


        report.Report.Dictionary.Connections[0].ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        webReport.Report = report;

        foreach (string key in Request.QueryString.AllKeys)
        {
            if (key == "sfdat1")
            { report.Report.SetParameterValue("sfdat1", Dl_sFdat1.SelectedValue); }
            else if (key == "sfdat2")
            { report.Report.SetParameterValue("sfdat2", Dl_sFdat2.SelectedValue); }
            else { report.Report.SetParameterValue(key, Request[key]); }
        }

        //это или баг или фича, если стейт не установить - работать не будет
        webReport.State = ReportState.Done;
        webReport.ShowToolbar = true;
        webReport.ShowExports = false;
        webReport.Height = 600;
        webReport.BorderStyle = BorderStyle.Outset;
        webReport.ToolbarStyle = ToolbarStyle.Small;
        webReport.ToolbarIconsStyle = ToolbarIconsStyle.Green;


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
            if (key == "sfdat1")
            { pars.Add(new FrxParameter("sfdat1", TypeCode.String, Dl_sFdat1.SelectedValue)); }
            else if (key == "sfdat2")
            { pars.Add(new FrxParameter("sfdat2", TypeCode.String, Dl_sFdat2.SelectedValue)); }
            else
            {
                pars.Add(new FrxParameter(key, TypeCode.String, Request[key]));
            }
        }
     
           FrxDoc doc = new FrxDoc(
             HttpContext.Current.Server.MapPath(String.Format("/Template.rpt/{0}.frx", Request["frt"])),
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

           holder.Controls.Clear();
           FRT_WINDOW();
    }

    protected void Bt_print_Click(object sender, EventArgs e)
    {
        FRX_RTD();
    }
    protected void Bt_run_Click(object sender, ImageClickEventArgs e)
    {
        holder.Controls.Clear();
        FRT_WINDOW();
    }

    protected void Bt_Back_Click(object sender, ImageClickEventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_success", "location.replace('" + (String)ViewState["PREV_URL"] + "')", true);
    }
}