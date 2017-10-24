using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
//using CrystalDecisions.Shared;
//using CrystalDecisions.CrystalReports.Engine;

public partial class crystalreports_ViewReport : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        BindGraph_Ussr1();
    }
    private void BindGraph_Ussr1()
    {
        /*try
        {
            ReportClass oRpt = new ReportClass();
            string reportFile = Server.MapPath("Reports/rptUssr1.rpt");
            oRpt.FileName = reportFile;
            oRpt.Load();

            InitOraConnection();
            SetRole("wr_creports");

            DataSet ds = SQL_SELECT_dataset(@"select * from v_ussr_reg_totals order by name");

            ds.Tables[0].TableName = "ussr1";
            oRpt.SetDataSource(ds.Tables[0]);

            crViewer.ReportSource = oRpt;
            crViewer.DataBind();
        }
        finally
        {
            DisposeOraConnection();
        }*/
    }
}
