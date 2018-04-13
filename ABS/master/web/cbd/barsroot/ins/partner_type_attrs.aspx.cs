using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Drawing;
using Bars.Ins;
using Bars.Classes;
using Bars.UserControls;
using ibank.core;
using Bars.DataComponents;

public partial class ins_partner_type_attrs : System.Web.UI.Page
{
    # region Приватные свойства
    # endregion

    # region Публичные свойства
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.SetPageTitle(String.Format(this.Title, Convert.ToInt16(Request.Params.Get("custtype")) == 2 ? "ЮО" : "ФО"), true);

        sds.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        sds.SelectCommand = "select * from v_ins_partner_type_attrs_adm where custid = :p_custid";
    }
    protected void PARTNER_ValueChanged(object sender, EventArgs e)
    {
        DDLList PARTNER = (sender as DDLList);
        BarsObjectDataSource ods = PARTNER.Parent.Parent.FindControl("ods_partner_types") as BarsObjectDataSource;

        ods.SelectParameters["PARTNER_ID"].DefaultValue = PARTNER.SelectedValue;
    }
    protected void PARTNER_DataBinding(object sender, EventArgs e)
    {
        sds_partners.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        sds_partners.SelectCommand = "select * from v_ins_partners where custid = :p_custid";
    }
    protected void ATTR_TYPE_DataBinding(object sender, EventArgs e)
    {
        sds_attr_types.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        sds_attr_types.SelectCommand = "select * from ins_attr_types";
    }
    protected void lbATTR_Click(object sender, EventArgs e)
    {
        LinkButton lbATTR = sender as LinkButton;
        DDLList ATTR = lbATTR.Parent.FindControl("ATTR") as DDLList;

        ATTR.Items.Clear();
        ATTR.Items.Add("");
        ATTR.DataBind();
    }
    protected void ibAddNew_Click(object sender, EventArgs e)
    {
        lv.InsertItemPosition = InsertItemPosition.LastItem;
        sds_partners.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        sds_partners.SelectCommand = "select * from v_ins_partners where custid = :p_custid";
    }
    protected void ibCancel_Click(object sender, EventArgs e)
    {
        lv.InsertItemPosition = InsertItemPosition.None;
    }
    protected void lv_ItemInserting(object sender, ListViewInsertEventArgs e)
    {
        DDLList PARTNER = e.Item.FindControl("PARTNER") as DDLList;
        DDLList TYPE = e.Item.FindControl("TYPE") as DDLList;
        DDLList ATTR = e.Item.FindControl("ATTR") as DDLList;
        RBLFlag IS_REQUIRED = e.Item.FindControl("IS_REQUIRED") as RBLFlag;

        InsPack ip = new InsPack(new BbConnection());
        ip.SET_PARTNER_TYPE_ATTR((Decimal?)null, ATTR.SelectedValue, PARTNER.Value, TYPE.Value, IS_REQUIRED.Value);

        lv.InsertItemPosition = InsertItemPosition.None;
        lv.DataBind();
        e.Cancel = true;
    }
    protected void lv_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {
        Decimal ID = (Decimal)e.Keys["ID"];
        DDLList PARTNER = lv.Items[e.ItemIndex].FindControl("PARTNER") as DDLList;
        DDLList TYPE = lv.Items[e.ItemIndex].FindControl("TYPE") as DDLList;
        DDLList ATTR = lv.Items[e.ItemIndex].FindControl("ATTR") as DDLList;
        RBLFlag IS_REQUIRED = lv.Items[e.ItemIndex].FindControl("IS_REQUIRED") as RBLFlag;

        InsPack ip = new InsPack(new BbConnection());
        ip.SET_PARTNER_TYPE_ATTR(ID, ATTR.SelectedValue, PARTNER.Value, TYPE.Value, IS_REQUIRED.Value);

        lv.EditIndex = -1;
        lv.DataBind();
        e.Cancel = true;
    }
    protected void lv_ItemDeleting(object sender, ListViewDeleteEventArgs e)
    {
        Decimal ID = (Decimal)e.Keys["ID"];

        InsPack ip = new InsPack(new BbConnection());
        ip.DEL_PARTNER_TYPE_ATTR(ID, 0);

        lv.DataBind();
        e.Cancel = true;
    }
    # endregion

    # region Приватные методы
    # endregion
}