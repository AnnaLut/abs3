using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

using Bars.Classes;
using Bars.UserControls;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using ibank.core;
using credit;

public partial class credit_constructor_dialogs_wcsavailablestops : Bars.BarsPage
{
    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        sds.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
    }
    protected void ibAdd_Click(object sender, ImageClickEventArgs e)
    {
        WcsPack wp = new WcsPack(new BbConnection());
        wp.SBPROD_STOP_SET(Request.Params.Get("subproduct_id"), Convert.ToString(gv.SelectedValue));

        ScriptManager.RegisterStartupScript(this, this.GetType(), "close_dialog", "CloseDialog(true);", true);
    }
    # endregion
}
