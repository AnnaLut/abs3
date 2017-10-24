using System;
using Bars.Classes;

public partial class ussr_joblist : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        dsJobs.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
    }
}
