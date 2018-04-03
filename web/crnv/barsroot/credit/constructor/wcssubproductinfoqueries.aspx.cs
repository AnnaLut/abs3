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
using Bars.Classes;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using credit;

public partial class credit_constructor_wcssubproductinfoqueries : Bars.BarsPage
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

        String ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        sdsActLevels.ConnectionString = ConnectionString;
    }
    protected void fv_DataBound(object sender, EventArgs e)
    {
        if (fv.CurrentMode == FormViewMode.Edit || fv.CurrentMode == FormViewMode.ReadOnly)
        {
            HtmlTableRow trACT_LEVEL = fv.FindControl("trACT_LEVEL") as HtmlTableRow;
            HtmlTableRow trSERVICE_ID = fv.FindControl("trSERVICE_ID") as HtmlTableRow;

            String TYPE_ID = (String)fv.DataKey["TYPE_ID"];

            if (TYPE_ID == "MANUAL")
            {
                trACT_LEVEL.Visible = false;
                trSERVICE_ID.Visible = true;
            }
            else
            {
                trACT_LEVEL.Visible = true;
                trSERVICE_ID.Visible = false;
            }
        }
    }
    protected void fv_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        gv.DataBind();
    }
    protected void fv_ItemCommand(object sender, FormViewCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            # region switch starments
            case "NewFromRef": gv.DataBind();
                break;
            /*            case "MoveUp":
                            e.
                            break;
                        case "MoveDown": gv.DataBind();
                            break;*/
            # endregion
        }
    }
    protected void fv_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        gv.DataBind();
    }
    protected void PRODUCT_ID_ValueChanged(object sender, EventArgs e)
    {
        CLONE_ID.Items.Clear();
        CLONE_ID.DataBind();
    }
    protected void btClone_Click(object sender, EventArgs e)
    {
        WcsPack wp = new WcsPack(new ibank.core.BbConnection());
        wp.SBPROD_IQUERY_CLONE(SUBPRODUCT_ID, CLONE_ID.SelectedValue);

        gv.DataBind();
    }
    # endregion
}
