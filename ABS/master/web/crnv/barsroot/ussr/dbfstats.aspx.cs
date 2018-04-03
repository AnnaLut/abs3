using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Globalization;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Classes;
using Bars.Logger;
using Bars.DataComponents;

public partial class ussr_dbfstats : Bars.BarsPage
{
    private string startDate = "01.01.2008";

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        dsRu.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsMfo.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsBranch.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        deTo.Date = DateTime.Now;
		CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");	
		cinfo.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";
		cinfo.DateTimeFormat.DateSeparator = ".";

        deFrom.Date = Convert.ToDateTime(startDate,cinfo);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        gv.Columns[1].Visible = !rbRU.Checked;
        gv.Columns[2].Visible = !rbRU.Checked;
        //если не указать кол-во, результат обрезается до 11 записей
        dsBranch.MaximumRows = 8000;
        dsRu.MaximumRows = 8000;
        dsMfo.MaximumRows = 8000;
    }
    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);
        BarsSqlDataSource ds = getDs();
        ds.SelectParameters.Add(new Parameter("ddat1", TypeCode.DateTime, deFrom.Date.ToString()));
        ds.SelectParameters.Add(new Parameter("ddat2", TypeCode.DateTime, deTo.Date.ToString()));
        gv.DataSourceID = ds.ID;
        gv.DataBind();
        
    }
    private BarsSqlDataSource getDs()
    {
        return rbRU.Checked ? dsRu : (rbMfo.Checked ? dsMfo : (rbTvbv.Checked ? dsBranch : null));
    }
}
