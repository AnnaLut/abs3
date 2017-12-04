using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
using Oracle.DataAccess.Client;
using System.Data;
using Bars.Classes;
using Bars.Oracle;
using Oracle.DataAccess.Types;
using System.Globalization;
using Bars.UserControls;
using Bars.Oracle;
using Bars.Classes;
using System.Web.Services;
using Pir;


public partial class pir_history : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        gvReqHistory.AutoGenerateCheckBoxColumn = false;
        gvReqHistory.ShowFooter = false;
        gvReqHistory.ShowPageSizeBox = false;

        if (!IsPostBack)
        {
            FillGrid();
        }
    }

    private void FillGrid()
    {
        decimal? req_id = Convert.ToDecimal(Request["req_id"]);
        string url = "";

        InitOraConnection();

        try
        {
            object[] l_res = SQL_SELECT_reader("select VAL from params where par = 'PIR_SERVICE'");
            if (null != l_res)
            {
                url = Convert.ToString(l_res[0]);
            }
        }

        finally
        {
            DisposeOraConnection();
        }

        ServicePointManager.ServerCertificateValidationCallback = delegate(object s, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors) { return true; };

        PirService service = new Pir.PirService();

        service.Url = url;

        PirResponseReqHistory res = service.GetReqHistory(req_id);

        var k = res.Kind;
        var r = res.Errors;

        lbTitle.Text += req_id.ToString(); 
        gvReqHistory.DataSource = res.PirReqHistoryData;
        gvReqHistory.DataBind();
    }

    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }
}