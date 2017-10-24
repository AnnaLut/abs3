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

public partial class credit_constructor_wcssubproductstops : Bars.BarsPage
{
    # region Приватные свойства
    # endregion

    # region Публичные методы
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.SetPageTitle(this.Title + " \"" + Master.SUBPRODUCT_NAME + "\"", true);

        String ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        sdsActLevels.ConnectionString = ConnectionString;
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
            # endregion
        }
    }
    protected void fv_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        gv.DataBind();
    }
    # endregion
}
