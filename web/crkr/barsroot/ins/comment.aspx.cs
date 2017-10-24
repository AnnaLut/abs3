using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

using Bars.DataComponents;
using Bars.UserControls;
using Bars.Ins;
using ibank.core;
using System.Drawing;

public partial class ins_comment : System.Web.UI.Page
{
    # region Приватные свойства
    # endregion

    # region Публичные свойства
    public Boolean IsRequired
    {
        get
        {
            return (Request.Params.Get("req") == "1" ? true : false);
        }
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            FillControls();
        }
    }
    protected void bSave_Click(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, typeof(Page), "close_dialog", String.Format("CloseDialog('{0}'); ", COMM.Value), true);
    }
    # endregion

    # region Приватные методы
    private void FillControls()
    {
        COMM.IsRequired = IsRequired;
    }
    # endregion
}