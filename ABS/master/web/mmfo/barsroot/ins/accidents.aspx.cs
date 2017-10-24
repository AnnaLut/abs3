using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Drawing;
using Bars.UserControls;
using Bars.Ins;
using Bars.Classes;

using ibank.core;

public partial class accidents : System.Web.UI.Page
{
    # region Приватные свойства
    private VInsDealsRecord _Deal;
    # endregion

    # region Публичные свойства
    public Decimal DEAL_ID
    {
        get
        {
            if (Request.Params.Get("deal_id") == null) throw new Bars.Exception.BarsException("Не задано обов`язковий параметр Url deal_id");
            return Convert.ToDecimal(Request.Params.Get("DEAL_ID"));
        }
    }
    public VInsDealsRecord Deal
    {
        get
        {
            if (_Deal == null)
                _Deal = (new VInsDeals()).SelectDeal(DEAL_ID);

            return _Deal;
        }
    }
    public String BackPageUrl
    {
        get
        {
            return Convert.ToString(ViewState["BackPageUrl"]);
        }
        set
        {
            ViewState.Add("BackPageUrl", value);
        }
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.UrlReferrer != null)
                BackPageUrl = Request.UrlReferrer.PathAndQuery;
            FillControls();
        }
    }
    protected void lbBack_Click(object sender, EventArgs e)
    {
        Response.Redirect(BackPageUrl);
    }
    protected void ibAddNew_Click(object sender, EventArgs e)
    {
        lvAccidents.InsertItemPosition = InsertItemPosition.LastItem;
    }
    protected void ibCancel_Click(object sender, EventArgs e)
    {
        lvAccidents.InsertItemPosition = InsertItemPosition.None;
    }
    protected void lvAccidents_ItemInserting(object sender, ListViewInsertEventArgs e)
    {
        TextBoxDate ACDT_DATE = e.Item.FindControl("ACDT_DATE") as TextBoxDate;
        TextBoxString COMM = e.Item.FindControl("COMM") as TextBoxString;
        TextBoxDecimal REFUND_SUM = e.Item.FindControl("REFUND_SUM") as TextBoxDecimal;
        TextBoxDate REFUND_DATE = e.Item.FindControl("REFUND_DATE") as TextBoxDate;

        InsPack ip = new InsPack(new BbConnection());
        Decimal? ID = ip.CREATE_ACCIDENT((Decimal?)null, DEAL_ID, ACDT_DATE.Value, COMM.Value, REFUND_SUM.Value, REFUND_DATE.Value);

        lvAccidents.InsertItemPosition = InsertItemPosition.None;
        lvAccidents.DataBind();
        e.Cancel = true;
    }
    protected void lvAccidents_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {
        Decimal? ID = (Decimal?)lvAccidents.DataKeys[e.ItemIndex]["ID"];
        TextBoxDate ACDT_DATE = lvAccidents.Items[e.ItemIndex].FindControl("ACDT_DATE") as TextBoxDate;
        TextBoxString COMM = lvAccidents.Items[e.ItemIndex].FindControl("COMM") as TextBoxString;
        TextBoxDecimal REFUND_SUM = lvAccidents.Items[e.ItemIndex].FindControl("REFUND_SUM") as TextBoxDecimal;
        TextBoxDate REFUND_DATE = lvAccidents.Items[e.ItemIndex].FindControl("REFUND_DATE") as TextBoxDate;

        InsPack ip = new InsPack(new BbConnection());
        Decimal? NEW_ID = ip.CREATE_ACCIDENT(ID, DEAL_ID, ACDT_DATE.Value, COMM.Value, REFUND_SUM.Value, REFUND_DATE.Value);

        lvAccidents.EditIndex = -1;
        lvAccidents.DataBind();
        e.Cancel = true;
    }
    # endregion

    # region Приватные методы
    private void FillControls()
    {
        // Ключові параметри
        DEAL.Text = String.Format("{0}", Deal.DEAL_ID);
        DEAL.ToolTip = String.Format("СК: {0}; Тип: {1}", Deal.DEAL_ID, Deal.PARTNER_NAME, Deal.TYPE_NAME);
        VInsCustomersRecord Customer = (new VInsCustomers()).SelectCustomer(Deal.INS_RNK);
        INS.Text = String.Format("{0}", Customer.NMK);
        INS.ToolTip = String.Format("РНК: {0}; ІПН: {1}", Customer.RNK, Customer.OKPO);
        AGR.Text = String.Format("{0}{1}", Deal.SER, Deal.NUM);
        AGR.ToolTip = String.Format("З: {0:d}; По: {1:d}", Deal.SDATE, Deal.EDATE);
    }
    # endregion
}