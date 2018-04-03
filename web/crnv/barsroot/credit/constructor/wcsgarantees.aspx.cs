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

public partial class credit_constructor_wcsgarantees : Bars.BarsPage
{
    # region Приватные свойства
    # endregion

    # region События
    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        sds.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        sdsAVGaranteeTemplates.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
    }
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void fv_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        gv.DataBind();
    }
    
    protected void ibNew_Click(object sender, ImageClickEventArgs e)
    {
        if (fv.CurrentMode == FormViewMode.Edit)
        {
            ListBox lb = fv.FindControl("lb") as ListBox;

            DDLList INSURANCE_ID = fv.FindControl("INSURANCE_ID") as DDLList;
            RBLFlag IS_REQUIRED = fv.FindControl("IS_REQUIRED") as RBLFlag;

            lb.SelectedIndex = -1;

            INSURANCE_ID.SelectedValue = (String)null;
            IS_REQUIRED.Value = (Decimal?)null;

            INSURANCE_ID.Enabled = true;
            INSURANCE_ID.Focus();
        }
    }
    protected void ibDelete_Click(object sender, ImageClickEventArgs e)
    {
        if (fv.CurrentMode == FormViewMode.Edit)
        {
            ListBox lb = fv.FindControl("lb") as ListBox;

            DDLList INSURANCE_ID = fv.FindControl("INSURANCE_ID") as DDLList;

            if (lb.SelectedIndex != -1)
            {
                WcsPack wp = new WcsPack(new BbConnection());
                wp.GARANTEE_INSURANCE_DEL((String)gv.SelectedValue, INSURANCE_ID.SelectedValue);

                lb.DataBind();
            }
        }
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        if (fv.CurrentMode == FormViewMode.Edit)
        {
            ListBox lb = fv.FindControl("lb") as ListBox;

            DDLList INSURANCE_ID = fv.FindControl("INSURANCE_ID") as DDLList;
            RBLFlag IS_REQUIRED = fv.FindControl("IS_REQUIRED") as RBLFlag;

            int Idx = lb.SelectedIndex;
            if (Idx != -1)
            {
                // обновляем
                WcsPack wp = new WcsPack(new BbConnection());
                wp.GARANTEE_INSURANCE_SET((String)gv.SelectedValue, INSURANCE_ID.SelectedValue, IS_REQUIRED.Value);

                lb.DataBind();
                lb.SelectedIndex = Idx;
                lb_DataBound(lb, null);
            }
            else
            {
                // создаем
                WcsPack wp = new WcsPack(new BbConnection());
                wp.GARANTEE_INSURANCE_SET((String)gv.SelectedValue, INSURANCE_ID.SelectedValue, IS_REQUIRED.Value);

                lb.DataBind();
                lb.SelectedIndex = lb.Items.Count - 1;
                lb_DataBound(lb, null);
            }
        }
    }
    protected void ibUp_Click(object sender, ImageClickEventArgs e)
    {
        if (fv.CurrentMode == FormViewMode.Edit)
        {
            ListBox lb = fv.FindControl("lb") as ListBox;

            int Idx = lb.SelectedIndex;
            if (Idx != -1 && Idx != 0)
            {
                VWcsGaranteeInsurancesRecord SelectedItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsGaranteeInsurancesRecord>)[lb.SelectedIndex];
                VWcsGaranteeInsurancesRecord UpItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsGaranteeInsurancesRecord>)[lb.SelectedIndex - 1];

                WcsPack wp = new WcsPack(new BbConnection());
                wp.GARANTEE_INSURANCE_MOVE((String)gv.SelectedValue, SelectedItem.INSURANCE_ID, UpItem.INSURANCE_ID);

                lb.DataBind();
                lb.SelectedIndex = Idx - 1;
                lb_DataBound(lb, null);
            }
        }
    }
    protected void ibDown_Click(object sender, ImageClickEventArgs e)
    {
        if (fv.CurrentMode == FormViewMode.Edit)
        {
            ListBox lb = fv.FindControl("lb") as ListBox;
            int Idx = lb.SelectedIndex;
            if (Idx != -1 && Idx != lb.Items.Count - 1)
            {
                VWcsGaranteeInsurancesRecord SelectedItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsGaranteeInsurancesRecord>)[lb.SelectedIndex];
                VWcsGaranteeInsurancesRecord DownItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsGaranteeInsurancesRecord>)[lb.SelectedIndex + 1];

                WcsPack wp = new WcsPack(new BbConnection());
                wp.GARANTEE_INSURANCE_MOVE((String)gv.SelectedValue, SelectedItem.INSURANCE_ID, DownItem.INSURANCE_ID);

                lb.DataBind();
                lb.SelectedIndex = Idx + 1;
                lb_DataBound(lb, null);
            }
        }
    }
    protected void lb_DataBound(object sender, EventArgs e)
    {
        if (fv.CurrentMode == FormViewMode.Edit || fv.CurrentMode == FormViewMode.ReadOnly)
        {
            ListBox lb = sender as ListBox;

            DDLList INSURANCE_ID = fv.FindControl("INSURANCE_ID") as DDLList;
            RBLFlag IS_REQUIRED = fv.FindControl("IS_REQUIRED") as RBLFlag;

            if (lb.Items.Count > 0 && lb.SelectedIndex == -1)
                lb.SelectedIndex = 0;

            if (lb.SelectedIndex != -1)
            {
                VWcsGaranteeInsurancesRecord SelectedItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsGaranteeInsurancesRecord>)[lb.SelectedIndex];

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
    }
    protected void lb_SelectedIndexChanged(object sender, EventArgs e)
    {
        lb_DataBound(sender, null);
    }

    protected void ibTemplatesNew_Click(object sender, ImageClickEventArgs e)
    {
        if (fv.CurrentMode == FormViewMode.Edit)
        {
            ListBox lbTemplates = fv.FindControl("lbTemplates") as ListBox;

            DDLList TEMPLATE_ID = fv.FindControl("TEMPLATE_ID") as DDLList;
            DDLList PRINT_STATE_ID = fv.FindControl("PRINT_STATE_ID") as DDLList;
            RBLFlag IS_SCAN_REQUIRED = fv.FindControl("IS_SCAN_REQUIRED") as RBLFlag;

            lbTemplates.SelectedIndex = -1;

            TEMPLATE_ID.SelectedValue = (String)null;
            PRINT_STATE_ID.SelectedValue = (String)null;
            IS_SCAN_REQUIRED.Value = (Decimal?)null;

            TEMPLATE_ID.Enabled = true;
            TEMPLATE_ID.Focus();
        }
    }
    protected void ibTemplatesDelete_Click(object sender, ImageClickEventArgs e)
    {
        if (fv.CurrentMode == FormViewMode.Edit)
        {
            ListBox lbTemplates = fv.FindControl("lbTemplates") as ListBox;

            DDLList TEMPLATE_ID = fv.FindControl("TEMPLATE_ID") as DDLList;

            if (lbTemplates.SelectedIndex != -1)
            {
                WcsPack wp = new WcsPack(new BbConnection());
                wp.GARANTEE_TEMPLATE_DEL((String)gv.SelectedValue, TEMPLATE_ID.SelectedValue);

                lbTemplates.DataBind();
            }
        }
    }
    protected void btTemplatesSave_Click(object sender, EventArgs e)
    {
        if (fv.CurrentMode == FormViewMode.Edit)
        {
            ListBox lbTemplates = fv.FindControl("lbTemplates") as ListBox;

            DDLList TEMPLATE_ID = fv.FindControl("TEMPLATE_ID") as DDLList;
            DDLList PRINT_STATE_ID = fv.FindControl("PRINT_STATE_ID") as DDLList;
            RBLFlag IS_SCAN_REQUIRED = fv.FindControl("IS_SCAN_REQUIRED") as RBLFlag;

            int Idx = lbTemplates.SelectedIndex;
            if (Idx != -1)
            {
                // обновляем
                WcsPack wp = new WcsPack(new BbConnection());
                wp.GARANTEE_TEMPLATE_SET((String)gv.SelectedValue, TEMPLATE_ID.SelectedValue, PRINT_STATE_ID.SelectedValue, IS_SCAN_REQUIRED.Value);

                lbTemplates.DataBind();
                lbTemplates.SelectedIndex = Idx;
                lbTemplates_DataBound(lbTemplates, null);
            }
            else
            {
                // создаем
                WcsPack wp = new WcsPack(new BbConnection());
                wp.GARANTEE_TEMPLATE_SET((String)gv.SelectedValue, TEMPLATE_ID.SelectedValue, PRINT_STATE_ID.SelectedValue, IS_SCAN_REQUIRED.Value);

                lbTemplates.DataBind();
                lbTemplates.SelectedIndex = lbTemplates.Items.Count - 1;
                lbTemplates_DataBound(lbTemplates, null);
            }
        }
    }
    protected void lbTemplates_DataBound(object sender, EventArgs e)
    {
        if (fv.CurrentMode == FormViewMode.Edit || fv.CurrentMode == FormViewMode.ReadOnly)
        {
            ListBox lbTemplates = fv.FindControl("lbTemplates") as ListBox;

            DDLList TEMPLATE_ID = fv.FindControl("TEMPLATE_ID") as DDLList;
            DDLList PRINT_STATE_ID = fv.FindControl("PRINT_STATE_ID") as DDLList;
            RBLFlag IS_SCAN_REQUIRED = fv.FindControl("IS_SCAN_REQUIRED") as RBLFlag;

            if (lbTemplates.Items.Count > 0 && lbTemplates.SelectedIndex == -1)
                lbTemplates.SelectedIndex = 0;

            if (lbTemplates.SelectedIndex != -1)
            {
                VWcsGaranteeTemplatesRecord SelectedItem = ((lbTemplates.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsGaranteeTemplatesRecord>)[lbTemplates.SelectedIndex];

                TEMPLATE_ID.SelectedValue = SelectedItem.TEMPLATE_ID;
                PRINT_STATE_ID.SelectedValue = SelectedItem.PRINT_STATE_ID;
                IS_SCAN_REQUIRED.Value = SelectedItem.IS_SCAN_REQUIRED;

                TEMPLATE_ID.Enabled = false;
            }
            else
            {
                TEMPLATE_ID.SelectedValue = (String)null;
                PRINT_STATE_ID.SelectedValue = (String)null;
                IS_SCAN_REQUIRED.Value = (Decimal?)null;

                TEMPLATE_ID.Enabled = true;
            }
        }
    }
    protected void lbTemplates_SelectedIndexChanged(object sender, EventArgs e)
    {
        lbTemplates_DataBound(sender, null);
    }
    # endregion
}
