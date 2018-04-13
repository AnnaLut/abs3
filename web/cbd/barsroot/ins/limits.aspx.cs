using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Bars.UserControls;
using Bars.Ins;
using Bars.Classes;

using ibank.core;

public partial class ins_limits : System.Web.UI.Page
{
    # region Публичные свойства
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected void ibAddNew_Click(object sender, EventArgs e)
    {
        lv.InsertItemPosition = InsertItemPosition.LastItem;
    }
    protected void ibCancel_Click(object sender, EventArgs e)
    {
        lv.InsertItemPosition = InsertItemPosition.None;
    }
    protected void lv_ItemInserting(object sender, ListViewInsertEventArgs e)
    {
        TextBoxString LIMIT_ID = e.Item.FindControl("LIMIT_ID") as TextBoxString;
        TextBoxString NAME = e.Item.FindControl("NAME") as TextBoxString;
        TextBoxDecimal SUM_VALUE = e.Item.FindControl("SUM_VALUE") as TextBoxDecimal;
        TextBoxDecimal PERC_VALUE = e.Item.FindControl("PERC_VALUE") as TextBoxDecimal;

        InsPack ip = new InsPack(new BbConnection());
        ip.SET_LIMIT(LIMIT_ID.Value, NAME.Value, SUM_VALUE.Value, PERC_VALUE.Value);

        lv.InsertItemPosition = InsertItemPosition.None;
        lv.DataBind();
        e.Cancel = true;
    }
    protected void lv_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {
        String LIMIT_ID = (String)e.Keys["LIMIT_ID"];
        TextBoxString NAME = lv.Items[e.ItemIndex].FindControl("NAME") as TextBoxString;
        TextBoxDecimal SUM_VALUE = lv.Items[e.ItemIndex].FindControl("SUM_VALUE") as TextBoxDecimal;
        TextBoxDecimal PERC_VALUE = lv.Items[e.ItemIndex].FindControl("PERC_VALUE") as TextBoxDecimal;

        InsPack ip = new InsPack(new BbConnection());
        ip.SET_LIMIT(LIMIT_ID, NAME.Value, SUM_VALUE.Value, PERC_VALUE.Value);

        lv.EditIndex = -1;
        lv.DataBind();
        e.Cancel = true;
    }
    protected void lv_ItemDeleting(object sender, ListViewDeleteEventArgs e)
    {
        String LIMIT_ID = (String)e.Keys["LIMIT_ID"];

        InsPack ip = new InsPack(new BbConnection());
        ip.DEL_LIMIT(LIMIT_ID);

        lv.DataBind();
        e.Cancel = true;
    }
    # endregion
}