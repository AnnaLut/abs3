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

public partial class ins_pmts_schedule : System.Web.UI.Page
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
    protected void lvPaymentsSchedule_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        if (e.Item.ItemType == ListViewItemType.DataItem && (e.Item as ListViewDataItem).DisplayIndex == lvPaymentsSchedule.EditIndex)
        {
            TextBoxDate FACT_DATE = e.Item.FindControl("FACT_DATE") as TextBoxDate;
            TextBoxDecimal FACT_SUM = e.Item.FindControl("FACT_SUM") as TextBoxDecimal;

            Decimal ID = (Decimal)lvPaymentsSchedule.DataKeys[(e.Item as ListViewDataItem).DataItemIndex]["ID"];
            VInsPaymentsScheduleRecord rec = (new VInsPaymentsSchedule()).SelectPayment(ID);

            if (FACT_DATE != null) FACT_DATE.Value = rec.PLAN_DATE;
            if (FACT_SUM != null) FACT_SUM.Value = rec.PLAN_SUM;
        }
    }
    protected void lvPaymentsSchedule_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "UnSelect":
                lvPaymentsSchedule.SelectedIndex = -1;
                break;
            case "Pay":
                if (e.Item.ItemType == ListViewItemType.DataItem && (e.Item as ListViewDataItem).DisplayIndex == lvPaymentsSchedule.EditIndex)
                {
                    TextBoxDate FACT_DATE = e.Item.FindControl("FACT_DATE") as TextBoxDate;
                    TextBoxDecimal FACT_SUM = e.Item.FindControl("FACT_SUM") as TextBoxDecimal;
                    TextBoxString PMT_NUM = e.Item.FindControl("PMT_NUM") as TextBoxString;
                    TextBoxString PMT_COMM = e.Item.FindControl("PMT_COMM") as TextBoxString;

                    Decimal ID = (Decimal)lvPaymentsSchedule.DataKeys[(e.Item as ListViewDataItem).DataItemIndex]["ID"];

                    InsPack ip = new InsPack(new ibank.core.BbConnection());
                    ip.PAY_DEAL_PMT(ID, FACT_DATE.Value, FACT_SUM.Value, PMT_NUM.Value, PMT_COMM.Value);

                    lvPaymentsSchedule.EditIndex = -1;
                }
                break;
        }
    }
    protected void lbBack_Click(object sender, EventArgs e)
    {
        Response.Redirect(BackPageUrl);
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