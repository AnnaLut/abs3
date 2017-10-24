using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class customerlist_dlg_date : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            tbDat1.Value = DateTime.Today;
            tbDat2.Value = DateTime.Today;
        }

    }

    protected void btApply_Click(object sender, EventArgs e)
    {
        string date1 = Convert.ToDateTime(tbDat1.Value).ToString("dd.MM.yyyy");
        string date2 = Convert.ToDateTime(tbDat2.Value).ToString("dd.MM.yyyy");
        Response.Redirect(String.Format("/barsroot/customerlist/custacc.aspx?type=8&Dat1={0}&Dat2={1}&rnk={2}", date1, date2, Request["rnk"]));
        ScriptManager.RegisterStartupScript(this, this.GetType(), "close", "window.close();", true);
    }
}