using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

using ibank.core;
using Bars.UserControls;
using Bars.Ins;

using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Classes;

public partial class ins_partners : System.Web.UI.Page
{
    # region Публичные свойства
    public String FilterCT
    {
        get
        {
            if (Request.Params.Get("custtype") == null) throw new Bars.Exception.BarsException("Не задано обов`язковий параметр custtype");
            return Request.Params.Get("custtype");
        }
    }
    # endregion
    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.SetPageTitle(String.Format(this.Title, Convert.ToInt16(Request.Params.Get("custtype")) == 2 ? "ЮО" : "ФО"), true);
        InitDataSource();
        //String custtype = FilterCT;
    }
    protected void fv_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        e.Values["CUSTID"] = FilterCT;
    }
    protected void fv_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        gv.DataBind();
    }
    protected void fv_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        ListView lvPartnerTypes = (sender as FormView).FindControl("lvPartnerTypes") as ListView;
        for (int i = 0; i < lvPartnerTypes.Items.Count; i++)
        {
            ListViewItem item = lvPartnerTypes.Items[i];

            Decimal PARTNER_ID = (Decimal)lvPartnerTypes.DataKeys[i]["PARTNER_ID"];
            Decimal TYPE_ID = (Decimal)lvPartnerTypes.DataKeys[i]["TYPE_ID"];

            DDLList TARIFF = item.FindControl("TARIFF") as DDLList;
            DDLList FEE = item.FindControl("FEE") as DDLList;
            DDLList LIMIT = item.FindControl("LIMIT") as DDLList;
            RBLFlag ACTIVE = item.FindControl("ACTIVE") as RBLFlag;

            InsPack ip = new InsPack(new BbConnection());
            ip.SET_PARTNER_TYPE(PARTNER_ID, TYPE_ID, TARIFF.SelectedValue, FEE.SelectedValue, LIMIT.SelectedValue, ACTIVE.Value);
        }
    }
    protected void fv_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        gv.DataBind();
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
    # endregion
    # region Приватные
    private void InitDataSource()
    {
        sds.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        sds.SelectCommand = "select * from v_ins_partners where custid = :p_custid";
    }
    # endregion
}