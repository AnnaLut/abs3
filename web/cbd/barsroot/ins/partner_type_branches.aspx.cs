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
using Bars.Oracle;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

public partial class ins_partner_type_branches : System.Web.UI.Page
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
        sds.SelectCommand = "select * from v_ins_partner_type_branches where custid = :p_custid";
        sds.SelectParameters.Add("p_custid", System.Data.DbType.Decimal, Request.Params.Get("custtype"));
    }
    protected void PARTNER_ValueChanged(object sender, EventArgs e)
    {
        DDLList PARTNER = (sender as DDLList);
        
        IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
        OracleConnection con = icon.GetUserConnection(Context);
        OracleCommand cmd = con.CreateCommand();

        ListBox el = (ListBox)lv.InsertItem.FindControl("TYPE_ID");

        el.Items.Clear();
        el.Items.Add("Всі");

        cmd.CommandText = "select t.id, t.name from v_ins_partner_types pt, ins_types t where pt.type_id = t.id and pt.partner_id = :p_partner_id and pt.active = 1";
        cmd.Parameters.Add("p_partner_id", OracleDbType.Decimal, PARTNER.SelectedValue, System.Data.ParameterDirection.Input);

        OracleDataReader reader = cmd.ExecuteReader();

        while (reader.Read())
        {
            String val = Convert.ToString(reader.GetOracleDecimal(0)) + " - " + reader.GetString(1);
            el.Items.Add(val);
        }

        reader.Close();

        con.Close();
        con.Dispose();
    }

    protected void PARTNER_DataBinding(object sender, EventArgs e)
    {
        sds_partners.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        sds_partners.SelectParameters.Clear();
        sds_partners.SelectCommand = "select * from v_ins_partners where custid = :p_custid";
        sds_partners.SelectParameters.Add("p_custid", System.Data.DbType.Decimal, Request.Params.Get("custtype"));
    }
    protected void lbTARIFF_Click(object sender, EventArgs e)
    {
        LinkButton lbTARIFF = sender as LinkButton;
        DDLList TARIFF = lbTARIFF.Parent.FindControl("TARIFF") as DDLList;

        TARIFF.Items.Clear();
        TARIFF.Items.Add("");
        TARIFF.DataBind();
    }
    protected void lbFEE_Click(object sender, EventArgs e)
    {
        LinkButton lbFEE = sender as LinkButton;
        DDLList FEE = lbFEE.Parent.FindControl("FEE") as DDLList;

        FEE.Items.Clear();
        FEE.Items.Add("");
        FEE.DataBind();
    }
    protected void lbLIMIT_Click(object sender, EventArgs e)
    {
        LinkButton lbLIMIT = sender as LinkButton;
        DDLList LIMIT = lbLIMIT.Parent.FindControl("LIMIT") as DDLList;

        LIMIT.Items.Clear();
        LIMIT.Items.Add("");
        LIMIT.DataBind();
    }
    protected void ibAddNew_Click(object sender, EventArgs e)
    {
        lv.InsertItemPosition = InsertItemPosition.LastItem;
        
        sds_partners.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        sds_partners.SelectParameters.Clear();
        sds_partners.SelectCommand = "select * from v_ins_partners where custid = :p_custid";
        sds_partners.SelectParameters.Add("p_custid", System.Data.DbType.Decimal, Request.Params.Get("custtype"));
    }
    protected void ibCancel_Click(object sender, EventArgs e)
    {
        lv.InsertItemPosition = InsertItemPosition.None;
    }
    protected void lv_ItemInserting(object sender, ListViewInsertEventArgs e)
    {
        ListBox BRANCH = e.Item.FindControl("BRANCH") as ListBox;
        DDLList PARTNER = e.Item.FindControl("PARTNER") as DDLList;
        ListBox TYPE = e.Item.FindControl("TYPE_ID") as ListBox;
        DDLList TARIFF = e.Item.FindControl("TARIFF") as DDLList;
        DDLList FEE = e.Item.FindControl("FEE") as DDLList;
        DDLList LIMIT = e.Item.FindControl("LIMIT") as DDLList;
        RBLFlag APPLY_HIER = e.Item.FindControl("APPLY_HIER") as RBLFlag;

        int count_br = BRANCH.Items.Count;
        int count_tp = TYPE.Items.Count;

        InsPack ip = new InsPack(new BbConnection());
        for (int i = 0; i < count_br; i++)
        {
            if (BRANCH.Items[i].Selected)
            {
                String str_branch = BRANCH.Items[i].Value;
                str_branch = str_branch.Substring(0, str_branch.IndexOf('-'));
                str_branch = str_branch.Trim(' ');
                for (int j = 0; j < count_tp; j++)
                {
                    if (TYPE.Items[j].Selected)
                    {
                        String str_type = TYPE.Items[j].Value;
                        if (str_type.IndexOf('-') == -1)
                        {
                            ip.SET_PARTNER_TYPE_BRANCH((Decimal?)null, str_branch, PARTNER.Value, (Decimal?)null, TARIFF.SelectedValue, FEE.SelectedValue, LIMIT.SelectedValue, APPLY_HIER.Value);
                        }
                        else
                        {
                            str_type = str_type.Substring(0, str_type.IndexOf('-'));
                            str_type = str_type.Trim(' ');
                            ip.SET_PARTNER_TYPE_BRANCH((Decimal?)null, str_branch, PARTNER.Value, Convert.ToDecimal(str_type), TARIFF.SelectedValue, FEE.SelectedValue, LIMIT.SelectedValue, APPLY_HIER.Value);
                        }
                    }
                }
            }
        }
        lv.InsertItemPosition = InsertItemPosition.None;
        lv.DataBind();
        e.Cancel = true;
    }
    protected void lv_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {
        Decimal ID = (Decimal)e.Keys["ID"];
        TextBoxRefer BRANCH = lv.Items[e.ItemIndex].FindControl("BRANCH") as TextBoxRefer;
        DDLList PARTNER = lv.Items[e.ItemIndex].FindControl("PARTNER") as DDLList;
        DDLList TYPE = lv.Items[e.ItemIndex].FindControl("TYPE") as DDLList;
        DDLList TARIFF = lv.Items[e.ItemIndex].FindControl("TARIFF") as DDLList;
        DDLList FEE = lv.Items[e.ItemIndex].FindControl("FEE") as DDLList;
        DDLList LIMIT = lv.Items[e.ItemIndex].FindControl("LIMIT") as DDLList;
        RBLFlag APPLY_HIER = lv.Items[e.ItemIndex].FindControl("APPLY_HIER") as RBLFlag;

        InsPack ip = new InsPack(new BbConnection());
        ip.SET_PARTNER_TYPE_BRANCH(ID, BRANCH.Value, PARTNER.Value, TYPE.Value, TARIFF.SelectedValue, FEE.SelectedValue, LIMIT.SelectedValue, APPLY_HIER.Value);

        lv.EditIndex = -1;
        lv.DataBind();
        e.Cancel = true;
    }
    protected void lv_ItemDeleting(object sender, ListViewDeleteEventArgs e)
    {
        Decimal ID = (Decimal)e.Keys["ID"];

        InsPack ip = new InsPack(new BbConnection());
        ip.DEL_PARTNER_TYPE_BRANCH(ID, 0);

        lv.DataBind();
        e.Cancel = true;
    }
    protected void BRANCH_LB_DataBinding(object sender, EventArgs e)
    {
        IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
        OracleConnection con = icon.GetUserConnection(Context);
        OracleCommand cmd = con.CreateCommand();

        ListBox el = sender as ListBox;

        cmd.CommandText = "select * from branch where branch like '/______/______/' or branch like '/______/' order by branch";
        cmd.Parameters.Add("p_custid", OracleDbType.Decimal, Request.Params.Get("custtype"), System.Data.ParameterDirection.Input);

        OracleDataReader reader = cmd.ExecuteReader();
        el.Items.Clear();
        while (reader.Read())
        {
           String val = Convert.ToString(reader.GetOracleString(0)) + " - " + Convert.ToString(reader.GetOracleString(1));
           el.Items.Add(val);
        }

        reader.Close();

        con.Close();
        con.Dispose();
    }
    # endregion
    # region Приватные методы
    # endregion
}