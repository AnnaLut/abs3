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

public partial class ins_fees : System.Web.UI.Page
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
        TextBoxString FEE_ID = e.Item.FindControl("FEE_ID") as TextBoxString;
        TextBoxString NAME = e.Item.FindControl("NAME") as TextBoxString;
        TextBoxDecimal MIN_VALUE = e.Item.FindControl("MIN_VALUE") as TextBoxDecimal;
        TextBoxDecimal PERC_VALUE = e.Item.FindControl("PERC_VALUE") as TextBoxDecimal;
        TextBoxDecimal MAX_VALUE = e.Item.FindControl("MAX_VALUE") as TextBoxDecimal;

        InsPack ip = new InsPack(new BbConnection());
        ip.SET_FEE(FEE_ID.Value, NAME.Value, MIN_VALUE.Value, PERC_VALUE.Value, MAX_VALUE.Value);

        lv.InsertItemPosition = InsertItemPosition.None;
        lv.DataBind();
        e.Cancel = true;
    }
    protected void lv_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {
        String FEE_ID = (String)e.Keys["FEE_ID"];
        TextBoxString NAME = lv.Items[e.ItemIndex].FindControl("NAME") as TextBoxString;
        TextBoxDecimal MIN_VALUE = lv.Items[e.ItemIndex].FindControl("MIN_VALUE") as TextBoxDecimal;
        TextBoxDecimal PERC_VALUE = lv.Items[e.ItemIndex].FindControl("PERC_VALUE") as TextBoxDecimal;
        TextBoxDecimal MAX_VALUE = lv.Items[e.ItemIndex].FindControl("MAX_VALUE") as TextBoxDecimal;

        InsPack ip = new InsPack(new BbConnection());
        ip.SET_FEE(FEE_ID, NAME.Value, MIN_VALUE.Value, PERC_VALUE.Value, MAX_VALUE.Value);

        lv.EditIndex = -1;
        lv.DataBind();
        e.Cancel = true;
    }
    protected void lv_ItemDeleting(object sender, ListViewDeleteEventArgs e)
    {
        String FEE_ID = (String)e.Keys["FEE_ID"];

        InsPack ip = new InsPack(new BbConnection());
        ip.DEL_FEE(FEE_ID);

        lv.DataBind();
        e.Cancel = true;
    }
    # endregion
}