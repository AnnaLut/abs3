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

using Bars.Extenders.Controls;
using Bars.UserControls;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using credit;

public partial class credit_constructor_wcssubproductcreditdata : Bars.BarsPage
{
    # region Приватные свойства
    # endregion

    # region Публичные методы
    public String SUBPRODUCT_ID
    {
        get
        {
            return (String)Session["WCS_SUBPRODUCT_ID"];
        }
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.SetPageTitle(this.Title + " \"" + Master.SUBPRODUCT_NAME + "\"", true);
    }
    protected void PRODUCT_ID_ValueChanged(object sender, EventArgs e)
    {
        CLONE_ID.Items.Clear();
        CLONE_ID.DataBind();
    }
    public void ValueChanged(object sender, EventArgs e)
    {
        if (fv.CurrentMode == FormViewMode.Edit || fv.CurrentMode == FormViewMode.Insert)
        {
            RBLFlag IS_CHECKABLE = sender as RBLFlag;
            TextBoxSQLBlock CHECK_PROC = fv.FindControl("CHECK_PROC") as TextBoxSQLBlock;
            CHECK_PROC.Enabled = IS_CHECKABLE.Value == 0 ? false : true;
        }
    }
    protected void fv_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        e.NewValues["SUBPRODUCT_ID"] = Master.SUBPRODUCT_ID;
    }
    protected void fv_ItemDeleting(object sender, FormViewDeleteEventArgs e)
    {
        VWcsSubproductCreditdata obj = new VWcsSubproductCreditdata();
        VWcsSubproductCreditdataRecord Item = new VWcsSubproductCreditdataRecord();
        Item.SUBPRODUCT_ID = Master.SUBPRODUCT_ID;
        Item.CRDDATA_ID = (String)gv.SelectedValue;
        obj.Delete(Item);

        gv.DataBind();

        e.Cancel = true;
    }
    protected void fv_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        gv.DataBind();
    }
    protected void fv_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        gv.DataBind();
    }

    protected void IS_CHECKABLE_PreRender(object sender, EventArgs e)
    {
        ValueChanged(sender, e);
    }
    protected void btClone_Click(object sender, EventArgs e)
    {
        WcsPack wp = new WcsPack(new ibank.core.BbConnection());
        wp.SBP_CRDDATA_CLONE(SUBPRODUCT_ID, CLONE_ID.SelectedValue);

        gv.DataBind();
    }
    # endregion
}
