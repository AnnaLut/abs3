using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using ibank.core;

using Bars.Ins;
using Bars.UserControls;

public partial class ins_branch_rnk : System.Web.UI.Page
{
    # region Приватные свойства
    # endregion

    # region Публичные свойства
    public Decimal PARTNER_ID
    {
        get
        {
            return Convert.ToDecimal(Request.Params.Get("partner_id"));
        }
    }
    # endregion

    # region Событи
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
        TextBoxRefer BRANCH = e.Item.FindControl("BRANCH") as TextBoxRefer;
        TextBoxRefer RNK = e.Item.FindControl("RNK") as TextBoxRefer;

        InsPack ip = new InsPack(new BbConnection());
        ip.SET_PARTNER_BRANCH_RNK(PARTNER_ID, BRANCH.Value, Convert.ToDecimal(RNK.Value));

        lv.InsertItemPosition = InsertItemPosition.None;
        lv.DataBind();
        e.Cancel = true;
    }
    protected void lv_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {
        String BRANCH = (String)e.Keys["BRANCH"];
        TextBoxRefer RNK = lv.Items[e.ItemIndex].FindControl("RNK") as TextBoxRefer;

        InsPack ip = new InsPack(new BbConnection());
        ip.SET_PARTNER_BRANCH_RNK(PARTNER_ID, BRANCH, Convert.ToDecimal(RNK.Value));

        lv.EditIndex = -1;
        lv.DataBind();
        e.Cancel = true;
    }
    protected void lv_ItemDeleting(object sender, ListViewDeleteEventArgs e)
    {
        String BRANCH = (String)e.Keys["BRANCH"];

        InsPack ip = new InsPack(new BbConnection());
        ip.DEL_PARTNER_BRANCH_RNK(PARTNER_ID, BRANCH);

        lv.DataBind();
        e.Cancel = true;
    }
    # endregion

    # region Приватные методы
    # endregion
}