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
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Classes;
using Bars.Logger;

public partial class ussr_dbferrview : Bars.BarsPage
{
    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        ds.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        Decimal fileId = null == Session["fileId"] ? 0 : Convert.ToDecimal(Session["fileId"]);
        ds.SelectParameters.Add(new Parameter("file_id", TypeCode.Decimal, fileId.ToString()));
    }
    protected void bntBack_Click1(object sender, EventArgs e)
    {
        Response.Redirect("dbfimp.aspx");
    }
} 
