using System;
using Oracle.DataAccess.Client;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Classes;

public partial class swi_Search : Bars.BarsPage
{
    private void FillData()
    {
        dsMain.DataBind();
        gvMain.DataBind();
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        dsMain.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        String SelectCommand = @"select swref, io_ind, mt, trn, sender, receiver,
              currency, amount/100 amount, date_rec, date_pay, vdate, ref from v_sw_searchmsg ";
        if (String.IsNullOrEmpty(tbText.Text))
        {
            SelectCommand += " where 1=0 ";
        }
        else
        {
            SelectCommand += " where 1=1 and bars_swift.get_message_condition(swref, '"+ tbText.Text + "') = 1 and vdate>=sysdate-200";
        }
        dsMain.SelectCommand = SelectCommand;

    }
    protected void btRefresh_Click(object sender, EventArgs e)
    {
        dsMain.DataBind();
        gvMain.DataBind();
    }
}