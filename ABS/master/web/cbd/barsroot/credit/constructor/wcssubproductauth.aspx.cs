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

using Bars.UserControls;
using Bars.Classes;
using credit;
using ibank.core;
using System.Collections.Generic;

public partial class credit_constructor_wcssubproductauth : Bars.BarsPage
{
    # region Приватные свойства
    # endregion

    # region Публичные методы
    # endregion

    # region События
    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        sds.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.SetPageTitle(this.Title + " субпродукту \"" + Master.SUBPRODUCT_NAME + "\"", true);
    }
    protected void ibAdd_Click(object sender, ImageClickEventArgs e)
    {
        if (lb.SelectedIndex != -1)
        {
            WcsPack wp = new WcsPack(new BbConnection());
            wp.SBPROD_AUTH_SET(Master.SUBPRODUCT_ID, lb.SelectedValue);

            lb.DataBind();
        }
    }
    protected void btDelete_Click(object sender, EventArgs e)
    {
        WcsPack wp = new WcsPack(new BbConnection());
        wp.SBPROD_AUTH_DEL(Master.SUBPRODUCT_ID);

        lb.DataBind();
    }
    protected void lb_DataBound(object sender, EventArgs e)
    {
        if (lb.SelectedIndex == -1 && lb.Items.Count > 0)
            lb.SelectedIndex = 0;

        List<VWcsSubproductAuthsRecord> lst = (new VWcsSubproductAuths()).SelectSubproductAuths(Master.SUBPRODUCT_ID);
        if (lst.Count > 0)
        {
            VWcsSubproductAuthsRecord rec = lst[0];

            AUTH_IDTextBox.Value = rec.AUTH_ID;
            AUTH_NAMETextBox.Value = rec.AUTH_NAME;
            QUEST_CNTTextBox.Value = rec.QUEST_CNT;
        }
        else
        {
            AUTH_IDTextBox.Value = (String)null;
            AUTH_NAMETextBox.Value = (String)null;
            QUEST_CNTTextBox.Value = (Decimal?)null;
        }
    }
    # endregion
}
