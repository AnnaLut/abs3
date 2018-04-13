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

using Bars.DataComponents;
using Bars.UserControls;
using Bars.Classes;
using credit;
using ibank.core;
using System.Collections.Generic;

public partial class credit_constructor_wcssubproductgarantees : Bars.BarsPage
{
    # region Приватные свойства
    # endregion

    # region Публичные методы
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.SetPageTitle(this.Title + " субпродукту \"" + Master.SUBPRODUCT_NAME + "\"", true);
    }
    protected void ibNew_Click(object sender, ImageClickEventArgs e)
    {
        lb.SelectedIndex = -1;

        GARANTEE_ID.SelectedValue = (String)null;
        IS_REQUIRED.Value = (Decimal?)null;

        GARANTEE_ID.Enabled = true;
        GARANTEE_ID.Focus();
    }
    protected void idDelete_Click(object sender, ImageClickEventArgs e)
    {
        if (lb.SelectedIndex != -1)
        {
            WcsPack wp = new WcsPack(new BbConnection());
            wp.SBP_GARANTEE_DEL(Master.SUBPRODUCT_ID, GARANTEE_ID.SelectedValue);

            lb.DataBind();
        }
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        int Idx = lb.SelectedIndex;
        if (Idx != -1)
        {
            // обновляем
            WcsPack wp = new WcsPack(new BbConnection());
            wp.SBP_GARANTEE_SET(Master.SUBPRODUCT_ID, GARANTEE_ID.SelectedValue, IS_REQUIRED.Value);

            lb.DataBind();
            lb.SelectedIndex = Idx;
            lb_DataBound(lb, null);
        }
        else
        {
            // создаем
            WcsPack wp = new WcsPack(new BbConnection());
            wp.SBP_GARANTEE_SET(Master.SUBPRODUCT_ID, GARANTEE_ID.SelectedValue, IS_REQUIRED.Value);

            lb.DataBind();
            lb.SelectedIndex = lb.Items.Count - 1;
            lb_DataBound(lb, null);
        }
    }
    protected void ibUp_Click(object sender, ImageClickEventArgs e)
    {
        int Idx = lb.SelectedIndex;
        if (Idx != -1 && Idx != 0)
        {
            VWcsSubproductGaranteesRecord SelectedItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsSubproductGaranteesRecord>)[lb.SelectedIndex];
            VWcsSubproductGaranteesRecord UpItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsSubproductGaranteesRecord>)[lb.SelectedIndex - 1];

            WcsPack wp = new WcsPack(new BbConnection());
            wp.SBP_GARANTEE_MOVE(Master.SUBPRODUCT_ID, SelectedItem.GARANTEE_ID, UpItem.GARANTEE_ID);

            lb.DataBind();
            lb.SelectedIndex = Idx - 1;
            lb_DataBound(lb, null);
        }
    }
    protected void ibDown_Click(object sender, ImageClickEventArgs e)
    {
        int Idx = lb.SelectedIndex;
        if (Idx != -1 && Idx != lb.Items.Count - 1)
        {
            VWcsSubproductGaranteesRecord SelectedItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsSubproductGaranteesRecord>)[lb.SelectedIndex];
            VWcsSubproductGaranteesRecord DownItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsSubproductGaranteesRecord>)[lb.SelectedIndex + 1];

            WcsPack wp = new WcsPack(new BbConnection());
            wp.SBP_GARANTEE_MOVE(Master.SUBPRODUCT_ID, SelectedItem.GARANTEE_ID, DownItem.GARANTEE_ID);

            lb.DataBind();
            lb.SelectedIndex = Idx + 1;
            lb_DataBound(lb, null);
        }
    }
    protected void lb_DataBound(object sender, EventArgs e)
    {
        if (lb.Items.Count > 0 && lb.SelectedIndex == -1)
            lb.SelectedIndex = 0;

        if (lb.SelectedIndex != -1)
        {
            VWcsSubproductGaranteesRecord SelectedItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsSubproductGaranteesRecord>)[lb.SelectedIndex];

            GARANTEE_ID.SelectedValue = SelectedItem.GARANTEE_ID;
            IS_REQUIRED.Value = SelectedItem.IS_REQUIRED;

            GARANTEE_ID.Enabled = false;
        }
        else
        {
            GARANTEE_ID.SelectedValue = (String)null;
            IS_REQUIRED.Value = (Decimal?)null;

            GARANTEE_ID.Enabled = true;
        }
    }
    protected void lb_SelectedIndexChanged(object sender, EventArgs e)
    {
        lb_DataBound(sender, null);
    }
    # endregion
}
