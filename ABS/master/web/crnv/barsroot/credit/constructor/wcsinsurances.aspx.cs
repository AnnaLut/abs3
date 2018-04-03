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

public partial class credit_constructor_wcsinsurances : Bars.BarsPage
{
    # region Приватные свойства
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void fv_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        gv.DataBind();
    }
    # endregion
}
