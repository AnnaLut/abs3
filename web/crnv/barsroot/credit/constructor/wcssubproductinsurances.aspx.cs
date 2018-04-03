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

public partial class credit_constructor_wcssubproductinsurances : Bars.BarsPage
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
    protected void ibNew_Click(object sender, ImageClickEventArgs e)
    {
        lb.SelectedIndex = -1;

        INSURANCE_ID.SelectedValue = (String)null;
        IS_REQUIRED.Value = (Decimal?)null;

        INSURANCE_ID.Enabled = true;
        INSURANCE_ID.Focus();
    }
    protected void idDelete_Click(object sender, ImageClickEventArgs e)
    {
        if (lb.SelectedIndex != -1)
        {
            WcsPack wp = new WcsPack(new BbConnection());
            wp.SBP_INSURANCE_DEL(Master.SUBPRODUCT_ID, INSURANCE_ID.SelectedValue);

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
            wp.SBP_INSURANCE_SET(Master.SUBPRODUCT_ID, INSURANCE_ID.SelectedValue, IS_REQUIRED.Value);

            lb.DataBind();
            lb.SelectedIndex = Idx;
            lb_DataBound(lb, null);
        }
        else
        {
            // создаем
            WcsPack wp = new WcsPack(new BbConnection());
            wp.SBP_INSURANCE_SET(Master.SUBPRODUCT_ID, INSURANCE_ID.SelectedValue, IS_REQUIRED.Value);

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
            VWcsSubproductInsurancesRecord SelectedItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsSubproductInsurancesRecord>)[lb.SelectedIndex];
            VWcsSubproductInsurancesRecord UpItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsSubproductInsurancesRecord>)[lb.SelectedIndex - 1];

            WcsPack wp = new WcsPack(new BbConnection());
            wp.SBP_INSURANCE_MOVE(Master.SUBPRODUCT_ID, SelectedItem.INSURANCE_ID, UpItem.INSURANCE_ID);

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
            VWcsSubproductInsurancesRecord SelectedItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsSubproductInsurancesRecord>)[lb.SelectedIndex];
            VWcsSubproductInsurancesRecord DownItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsSubproductInsurancesRecord>)[lb.SelectedIndex + 1];

            WcsPack wp = new WcsPack(new BbConnection());
            wp.SBP_INSURANCE_MOVE(Master.SUBPRODUCT_ID, SelectedItem.INSURANCE_ID, DownItem.INSURANCE_ID);

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
            VWcsSubproductInsurancesRecord SelectedItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsSubproductInsurancesRecord>)[lb.SelectedIndex];

            INSURANCE_ID.SelectedValue = SelectedItem.INSURANCE_ID;
            IS_REQUIRED.Value = SelectedItem.IS_REQUIRED;

            INSURANCE_ID.Enabled = false;
        }
        else
        {
            INSURANCE_ID.SelectedValue = (String)null;
            IS_REQUIRED.Value = (Decimal?)null;

            INSURANCE_ID.Enabled = true;
        }
    }
    protected void lb_SelectedIndexChanged(object sender, EventArgs e)
    {
        lb_DataBound(sender, null);
    }
    # endregion
}
