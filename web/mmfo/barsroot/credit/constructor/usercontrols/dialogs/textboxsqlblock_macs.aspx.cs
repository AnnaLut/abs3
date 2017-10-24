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

using Oracle.DataAccess.Types;
using Bars.Classes;
using ibank.core;
using credit;

public partial class credit_usercontrols_dialogs_textboxsqlblock_macs : Bars.BarsPage
{
    # region Приватные свойства
    private String _ResultMask = ":#{0}%T-M#";
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {        
    }
    protected void ibAdd_Click(object sender, ImageClickEventArgs e)
    {
        String MAC_ID = (String)gv.SelectedValue;
        ClientScript.RegisterStartupScript(typeof(string), "close_dialog", "CloseDialog('" + String.Format(_ResultMask, MAC_ID) + "');", true);
    }
    # endregion
}