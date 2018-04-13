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
using System.Collections.Generic;

using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

using Bars.Classes;
using Bars.Extenders.Controls;

using ibank.objlayer;

public partial class credit_constructor_wcsproducts : Bars.BarsPage
{
    # region Приватные свойства
    private String SubProductsPageURL = "/barsroot/credit/constructor/wcssubproducts.aspx";
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected void fvVWcsProducts_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        gvVWcsProducts.DataBind();
    }
    protected void fvVWcsProducts_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        gvVWcsProducts.DataBind();
    }
    protected void fvVWcsProducts_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        gvVWcsProducts.DataBind();
    }
    protected void fvVWcsProducts_ItemCommand(object sender, FormViewCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "ShowSubProducts":
                Master.PRODUCT_ID = Convert.ToString(e.CommandArgument);
                Master.GoToPage(SubProductsPageURL);
                break;
        }
    }
    # endregion
}