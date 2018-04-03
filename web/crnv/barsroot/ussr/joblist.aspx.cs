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
using Bars.Classes;
using Bars.Logger;
using Bars.Configuration;

public partial class ussr_joblist : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        dsJobs.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
    }
}
