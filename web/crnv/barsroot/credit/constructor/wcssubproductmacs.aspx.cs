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

using Bars.Extenders.Controls;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using credit;

public partial class credit_constructor_wcssubproductmacs : Bars.BarsPage
{
    # region Приватные свойства
    private String SubProductsPageURL = "/barsroot/credit/constructor/wcssubproducts.aspx";
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
        Master.SetPageTitleUrl(SubProductsPageURL, true);
    }
    protected void PRODUCT_ID_ValueChanged(object sender, EventArgs e)
    {
        CLONE_ID.Items.Clear();
        CLONE_ID.DataBind();
    }
    protected void gvVWcsSubproductMacs_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            # region switch starments
            case "VALUES":
                String MAC_ID = (e.CommandArgument as String);
                Response.Redirect(String.Format("/barsroot/credit/constructor/wcssbpmacvalues.aspx?subproduct_id={0}&mac_id={1}", SUBPRODUCT_ID, MAC_ID));
                break;
            # endregion
        }

    }
    protected void btClone_Click(object sender, EventArgs e)
    {
        WcsPack wp = new WcsPack(new ibank.core.BbConnection());
        wp.SBPROD_MACS_CLONE(SUBPRODUCT_ID, CLONE_ID.SelectedValue);

        gvVWcsSubproductMacs.DataBind();
    }
    # endregion
}
