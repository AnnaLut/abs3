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

public partial class ins_scans : System.Web.UI.Page
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
        TextBoxString SCAN_ID = e.Item.FindControl("SCAN_ID") as TextBoxString;
        TextBoxString NAME = e.Item.FindControl("NAME") as TextBoxString;

        InsPack ip = new InsPack(new BbConnection());
        ip.SET_SCAN(SCAN_ID.Value, NAME.Value);

        lv.InsertItemPosition = InsertItemPosition.None;
        lv.DataBind();
        e.Cancel = true;
    }
    protected void lv_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {
        String SCAN_ID = (String)e.Keys["SCAN_ID"];
        TextBoxString NAME = lv.Items[e.ItemIndex].FindControl("NAME") as TextBoxString;

        InsPack ip = new InsPack(new BbConnection());
        ip.SET_SCAN(SCAN_ID, NAME.Value);

        lv.EditIndex = -1;
        lv.DataBind();
        e.Cancel = true;
    }
    protected void lv_ItemDeleting(object sender, ListViewDeleteEventArgs e)
    {
        String SCAN_ID = (String)e.Keys["SCAN_ID"];

        InsPack ip = new InsPack(new BbConnection());
        ip.DEL_SCAN(SCAN_ID);

        lv.DataBind();
        e.Cancel = true;
    }
    # endregion
}