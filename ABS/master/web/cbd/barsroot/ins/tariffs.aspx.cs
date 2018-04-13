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

public partial class ins_tariffs : System.Web.UI.Page
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
        TextBoxString TARIFF_ID = e.Item.FindControl("TARIFF_ID") as TextBoxString;
        TextBoxString NAME = e.Item.FindControl("NAME") as TextBoxString;
        TextBoxDecimal MIN_VALUE = e.Item.FindControl("MIN_VALUE") as TextBoxDecimal;
        TextBoxDecimal MIN_PERC = e.Item.FindControl("MIN_PERC") as TextBoxDecimal;
        TextBoxDecimal MAX_VALUE = e.Item.FindControl("MAX_VALUE") as TextBoxDecimal;
        TextBoxDecimal MAX_PERC = e.Item.FindControl("MAX_PERC") as TextBoxDecimal;

        InsPack ip = new InsPack(new BbConnection());
        ip.SET_TARIFF(TARIFF_ID.Value, NAME.Value, MIN_VALUE.Value, MIN_PERC.Value, MAX_VALUE.Value, MAX_PERC.Value, (Decimal?)null);

        lv.InsertItemPosition = InsertItemPosition.None;
        lv.DataBind();
        e.Cancel = true;
    }
    protected void lv_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {
        String TARIFF_ID = (String)e.Keys["TARIFF_ID"];
        TextBoxString NAME = lv.Items[e.ItemIndex].FindControl("NAME") as TextBoxString;
        TextBoxDecimal MIN_VALUE = lv.Items[e.ItemIndex].FindControl("MIN_VALUE") as TextBoxDecimal;
        TextBoxDecimal MIN_PERC = lv.Items[e.ItemIndex].FindControl("MIN_PERC") as TextBoxDecimal;
        TextBoxDecimal MAX_VALUE = lv.Items[e.ItemIndex].FindControl("MAX_VALUE") as TextBoxDecimal;
        TextBoxDecimal MAX_PERC = lv.Items[e.ItemIndex].FindControl("MAX_PERC") as TextBoxDecimal;

        InsPack ip = new InsPack(new BbConnection());
        ip.SET_TARIFF(TARIFF_ID, NAME.Value, MIN_VALUE.Value, MIN_PERC.Value, MAX_VALUE.Value, MAX_PERC.Value, (Decimal?)null);

        lv.EditIndex = -1;
        lv.DataBind();
        e.Cancel = true;
    }
    protected void lv_ItemDeleting(object sender, ListViewDeleteEventArgs e)
    {
        String TARIFF_ID = (String)e.Keys["TARIFF_ID"];

        InsPack ip = new InsPack(new BbConnection());
        ip.DEL_TARIFF(TARIFF_ID);

        lv.DataBind();
        e.Cancel = true;
    }
    # endregion
}