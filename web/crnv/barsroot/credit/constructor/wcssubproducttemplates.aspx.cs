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
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using credit;

public partial class credit_constructor_wcssubproducttemplates : Bars.BarsPage
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
    protected void fv_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        gv.DataBind();
    }
    protected void fv_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        gv.DataBind();
    }
    protected void fv_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        gv.DataBind();
    }
    protected void fv_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        e.Values["SUBPRODUCT_ID"] = Master.SUBPRODUCT_ID;
    }
    protected void PRODUCT_ID_ValueChanged(object sender, EventArgs e)
    {
        CLONE_ID.Items.Clear();
        CLONE_ID.DataBind();
    }
    protected void btClone_Click(object sender, EventArgs e)
    {
        WcsPack wp = new WcsPack(new ibank.core.BbConnection());
        wp.SBP_TEMPLATE_CLONE(SUBPRODUCT_ID, CLONE_ID.SelectedValue);

        gv.DataBind();
    }
    # endregion
}
