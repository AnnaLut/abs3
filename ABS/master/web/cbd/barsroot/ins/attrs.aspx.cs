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

public partial class ins_attrs : System.Web.UI.Page
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
        TextBoxString ATTR_ID = e.Item.FindControl("ATTR_ID") as TextBoxString;
        TextBoxString NAME = e.Item.FindControl("NAME") as TextBoxString;
        DDLList TYPE_ID = e.Item.FindControl("TYPE_ID") as DDLList;

        InsPack ip = new InsPack(new BbConnection());
        ip.SET_ATTR(ATTR_ID.Value, NAME.Value, TYPE_ID.SelectedValue);

        lv.InsertItemPosition = InsertItemPosition.None;
        lv.DataBind();
        e.Cancel = true;
    }
    protected void lv_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {
        String ATTR_ID = (String)e.Keys["ATTR_ID"];
        TextBoxString NAME = lv.Items[e.ItemIndex].FindControl("NAME") as TextBoxString;
        DDLList TYPE_ID = lv.Items[e.ItemIndex].FindControl("TYPE_ID") as DDLList;

        InsPack ip = new InsPack(new BbConnection());
        ip.SET_ATTR(ATTR_ID, NAME.Value, TYPE_ID.SelectedValue);

        lv.EditIndex = -1;
        lv.DataBind();
        e.Cancel = true;
    }
    protected void lv_ItemDeleting(object sender, ListViewDeleteEventArgs e)
    {
        String ATTR_ID = (String)e.Keys["ATTR_ID"];

        InsPack ip = new InsPack(new BbConnection());
        ip.DEL_ATTR(ATTR_ID);

        lv.DataBind();
        e.Cancel = true;
    }
    # endregion
}