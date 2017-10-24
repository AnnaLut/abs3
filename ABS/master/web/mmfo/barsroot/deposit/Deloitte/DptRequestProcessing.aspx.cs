using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Classes;

public partial class deposit_DptRequestProcessing : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
         FillGrid();
    }

    private void FillGrid()
    {
        dsRequests.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        string strQuery = @"select r.REQ_ID, r.REQ_CRDATE, r.REQ_BRANCH, r.TRUSTEE_NAME, 
                                   r.TRUSTEE_TYPE_ID, r.TRUSTEE_TYPE_NAME
                              from V_DPT_ACCESS_REQUESTS r
                             where r.REQ_BDATE = bankdate
                               and r.REQ_STATE = 0
                             order by r.REQ_CRDATE";
        
        dsRequests.SelectCommand = strQuery;
        gvRequests.DataBind();
    }
}