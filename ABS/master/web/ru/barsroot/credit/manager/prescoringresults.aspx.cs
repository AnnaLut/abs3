using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Oracle;
using FastReport.Cloud;
using Oracle.DataAccess.Client;
using credit;

public partial class inh_prescoringresults : Page
{
    public Decimal? BID_ID
    {
        get
        {
            return Convert.ToDecimal(Request.Params.Get("bid_id"));
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            bidId.InnerHtml = BID_ID.Value.ToString();
        }   
    }
    
}