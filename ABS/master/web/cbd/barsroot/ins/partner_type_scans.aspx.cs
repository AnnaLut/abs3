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

public partial class ins_partner_type_scans : System.Web.UI.Page
{
    # region Приватные свойства
    # endregion

    # region Публичные свойства
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        sds.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        sds.SelectParameters.Clear();
        sds.SelectCommand = "select * from v_ins_partner_type_scans_adm where custid = :p_custid";
        sds.SelectParameters.Add("p_custid", System.Data.DbType.Decimal, Request.Params.Get("custtype"));
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
    protected void lbSCAN_Click(object sender, EventArgs e)
    {
        LinkButton lbSCAN = sender as LinkButton;
        DDLList SCAN = lbSCAN.Parent.FindControl("SCAN") as DDLList;

        SCAN.Items.Clear();
        SCAN.Items.Add("");
        SCAN.DataBind();
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
        DDLList SCAN = e.Item.FindControl("SCAN") as DDLList;
        RBLFlag IS_REQUIRED = e.Item.FindControl("IS_REQUIRED") as RBLFlag;

        InsPack ip = new InsPack(new BbConnection());
        ip.SET_PARTNER_TYPE_SCAN((Decimal?)null, SCAN.SelectedValue, PARTNER.Value, TYPE.Value, IS_REQUIRED.Value);

        lv.InsertItemPosition = InsertItemPosition.None;
        lv.DataBind();
        e.Cancel = true;
    }
    protected void lv_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {
        Decimal ID = (Decimal)e.Keys["ID"];
        DDLList PARTNER = lv.Items[e.ItemIndex].FindControl("PARTNER") as DDLList;
        DDLList TYPE = lv.Items[e.ItemIndex].FindControl("TYPE") as DDLList;
        DDLList SCAN = lv.Items[e.ItemIndex].FindControl("SCAN") as DDLList;
        RBLFlag IS_REQUIRED = lv.Items[e.ItemIndex].FindControl("IS_REQUIRED") as RBLFlag;

        InsPack ip = new InsPack(new BbConnection());
        ip.SET_PARTNER_TYPE_SCAN(ID, SCAN.SelectedValue, PARTNER.Value, TYPE.Value, IS_REQUIRED.Value);

        lv.EditIndex = -1;
        lv.DataBind();
        e.Cancel = true;
    }
    protected void lv_ItemDeleting(object sender, ListViewDeleteEventArgs e)
    {
        Decimal ID = (Decimal)e.Keys["ID"];

        InsPack ip = new InsPack(new BbConnection());
        ip.DEL_PARTNER_TYPE_SCAN(ID, 0);

        lv.DataBind();
        e.Cancel = true;
    }
    # endregion

    # region Приватные методы
    # endregion
}