using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Collections.Generic;
using credit;

using Bars.Classes;
using ibank.core;

public partial class credit_adm_bid_card : System.Web.UI.MasterPage
{
    # region Приватные свойства
    private VWcsBidsRecord _BidRecord;
    private Boolean? _ReadOnly = null;
    # endregion

    # region Публичные свойства
    public String SRV
    {
        get
        {
            return Convert.ToString(Request.Params.Get("srv"));
        }
    }
    public String SRV_HIERARCHY
    {
        get
        {
            return Convert.ToString(Request.Params.Get("srvhr"));
        }
    }
    public Decimal? BID_ID
    {
        get
        {
            return Convert.ToDecimal(Request.Params.Get("bid_id"));
        }
    }
    public VWcsBidsRecord BidRecord
    {
        get
        {
            if (_BidRecord == null)
            {
                List<VWcsBidsRecord> lst = (new VWcsBids()).SelectBid(BID_ID);
                if (lst.Count > 0) _BidRecord = lst[0];
            }

            return _BidRecord;
        }
    }
    public Boolean? ReadOnly
    {
        get
        {
            return _ReadOnly;
        }
    }
    # endregion

    # region События
    protected void lbStatesHistory_Click(object sender, EventArgs e)
    {
        Response.Redirect(String.Format("/barsroot/credit/bid_stateshistory.aspx?bid_id={0}", BID_ID.ToString()));
    }

    protected void lbSURVEY_Click(object sender, EventArgs e)
    {
        Response.Redirect(String.Format("/barsroot/credit/survey.aspx?bid_id={0}", BID_ID));
    }
    protected void lbSCANCOPY_Click(object sender, EventArgs e)
    {
        Response.Redirect(String.Format("/barsroot/credit/scancopy.aspx?bid_id={0}", BID_ID));
    }
    protected void lbGARANTEE_Click(object sender, EventArgs e)
    {
        Response.Redirect(String.Format("/barsroot/credit/garantees.aspx?bid_id={0}", BID_ID));
    }

    protected void lbSCORING_Click(object sender, EventArgs e)
    {
        Response.Redirect(String.Format("/barsroot/credit/scoring.aspx?bid_id={0}", BID_ID));
    }
    protected void lbINFOQUERIES_Click(object sender, EventArgs e)
    {
        Response.Redirect(String.Format("/barsroot/credit/infoqueries.aspx?bid_id={0}", BID_ID));
    }
    protected void lbSTOPS_Click(object sender, EventArgs e)
    {
        Response.Redirect(String.Format("/barsroot/credit/stops.aspx?bid_id={0}", BID_ID));
    }
    # endregion

    # region Публичные методы
    /// <summary>
    /// Заголовок страницы
    /// </summary>
    public void SetPageTitle(String Title, Boolean OverWrite)
    {
        Master.SetPageTitle(Title, OverWrite);
    }
    public void SetPageTitle(String Title)
    {
        SetPageTitle(Title, false);
    }

    /// <summary>
    /// Отображение ошибок
    /// </summary>
    public void ShowError(String ErrorText)
    {
        Master.ShowError(ErrorText);
    }
    public void HideError()
    {
        Master.HideError();
    }

    public void FillData()
    {
        // Базовая информация про клиента
        //RNK.Text = String.Format("{0}", BidRecord.RNK);
        F.Text = BidRecord.F;
        I.Text = BidRecord.I;
        O.Text = BidRecord.O;
        INN.Text = BidRecord.INN;
        BDATE.Text = String.Format("{0:d}", BidRecord.BDATE);

        // Информация про кредит
        SUBPRODUCT.Text = BidRecord.SUBPRODUCT_ID;
        SUBPRODUCT.ToolTip = BidRecord.SUBPRODUCT_DESC;
        SUMM.Text = String.Format("{0:### ### ### ##0.00}", BidRecord.SUMM);
        OWN_FUNDS.Text = String.Format("{0:### ### ### ##0.00}", BidRecord.OWN_FUNDS);
        TERM.Text = BidRecord.TERM + " (міс.)";
        CREDIT_CURRENCY.Text = String.Format("{0}", BidRecord.CREDIT_CURRENCY);
        SINGLE_FEE.Text = String.Format("{0:##0.00}", BidRecord.SINGLE_FEE) + " (грн.)";
        MONTHLY_FEE.Text = String.Format("{0:##0.00%}", BidRecord.MONTHLY_FEE / 100);
        INTEREST_RATE.Text = String.Format("{0:##0.00%}", BidRecord.INTEREST_RATE / 100);
        REPAYMENT_METHOD.Text = BidRecord.REPAYMENT_METHOD_TEXT;
        REPAYMENT_DAY.Text = String.Format("{0}", BidRecord.REPAYMENT_DAY);
        INIT_PAYMENT_MTD.Text = BidRecord.INIT_PAYMENT_MTD;
    }
    # endregion
}
