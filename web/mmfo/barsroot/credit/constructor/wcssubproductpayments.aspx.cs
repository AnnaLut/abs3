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

public partial class credit_constructor_wcssubproductpayments : Bars.BarsPage
{
    # region Приватные свойства
    # endregion

    # region Приватные методы
    private void EnablePartner()
    {
        foreach (ListItem li in cblPaymentTypes.Items)
            if (li.Value == "PARTNER")
                cblPtrTypes.Enabled = li.Selected;
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        // Заголовок Платежные инструкции субпродукта '{0}'        
        Master.SetPageTitle(String.Format(this.Title, Master.SUBPRODUCT_NAME), true);

        sdsPaymentTypes.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        sdsPtrTypes.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
    }
    protected void cblPaymentTypes_DataBound(object sender, EventArgs e)
    {
        List<VWcsSubproductPaymentsRecord> lst = (new VWcsSubproductPayments()).SelectSubproductPayments(Master.SUBPRODUCT_ID);
        foreach (VWcsSubproductPaymentsRecord rec in lst)
            foreach (ListItem li in cblPaymentTypes.Items)
                if (li.Value == rec.PAYMENT_ID)
                {
                    li.Selected = true;
                    break;
                }
        
        EnablePartner();
    }
    protected void cblPtrTypes_DataBound(object sender, EventArgs e)
    {
        List<VWcsSubproductPtrtypesRecord> lst = (new VWcsSubproductPtrtypes()).SelectSubproductPtrtypes(Master.SUBPRODUCT_ID);
        foreach (VWcsSubproductPtrtypesRecord rec in lst)
            foreach (ListItem li in cblPtrTypes.Items)
                if (li.Value == rec.PTR_TYPE_ID)
                {
                    li.Selected = true;
                    break;
                }
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        WcsPack wp = new WcsPack(new BbConnection());

        foreach (ListItem li in cblPaymentTypes.Items)
        {
            if (li.Selected)
            {
                wp.SBP_PAYMENT_SET(Master.SUBPRODUCT_ID, li.Value);

                if (li.Value == "PARTNER")
                    foreach (ListItem li0 in cblPtrTypes.Items)
                        if (li0.Selected)
                            wp.SBP_PTRTYPE_SET(Master.SUBPRODUCT_ID, li0.Value);
                        else
                            wp.SBP_PTRTYPE_DEL(Master.SUBPRODUCT_ID, li0.Value);
            }
            else
            {
                wp.SBP_PAYMENT_DEL(Master.SUBPRODUCT_ID, li.Value);

                if (li.Value == "PARTNER")
                    foreach (ListItem li0 in cblPtrTypes.Items)
                        wp.SBP_PTRTYPE_DEL(Master.SUBPRODUCT_ID, li0.Value);
            }
        }

        cblPaymentTypes.DataBind();
        cblPtrTypes.DataBind();
    }
    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);
        EnablePartner();
    }
    # endregion
}
