using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

using Bars.DataComponents;
using System.Collections.Generic;
using Bars.Classes;
using credit;
using ibank.core;

public partial class credit_constructor_grt_insurances : Bars.BarsPage
{
    # region Приватные свойства
    private VWcsBidGaranteesRecord _BidGarantee;

    private Decimal? BID_ID
    {
        get
        {
            return Convert.ToDecimal(Request.Params.Get("bid_id"));
        }
    }
    private String GARANTEE_ID
    {
        get
        {
            return Request.Params.Get("garantee_id");
        }
    }
    private Decimal? GARANTEE_NUM
    {
        get
        {
            return Convert.ToDecimal(Request.Params.Get("garantee_num"));
        }
    }
    # endregion

    # region Публичные свойства
    public VWcsBidGaranteesRecord BidGarantee
    {
        get
        {
            if (_BidGarantee == null)
                _BidGarantee = (new VWcsBidGarantees()).SelectBidGarantee(BID_ID, GARANTEE_ID, GARANTEE_NUM)[0];

            return _BidGarantee;
        }
    }

    public Boolean? ReadOnly
    {
        get
        {
            return Request.Params.Get("readonly") == "1" ? true : false;
        }
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        sds.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        // заголовок Страховки обеспечения {0} - {1} заявки №{2}
        Master.SetPageTitle(String.Format(this.Title, BidGarantee.GARANTEE_NAME, Convert.ToString(GARANTEE_NUM), Convert.ToString(BID_ID)), true);

        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        try
        {
            // переводим обеспечение в след состояние
            if (BidGarantee.STATUS_ID == 3) // Заповнення анкети (остаточне)
                cmn.wp.BID_GARANTEE_STATUS_SET(BID_ID, GARANTEE_ID, GARANTEE_NUM, 4); // Страхові договори
        }
        finally
        {
            con.CloseConnection();
        }

        // проверки
        Master.HideError();

        // прячем кнопку "новый" если для даного типа страховки не предусмотрены
        DataSourceSelectArguments dssa = new DataSourceSelectArguments();
        dssa.AddSupportedCapabilities(DataSourceCapabilities.RetrieveTotalRowCount);
        dssa.RetrieveTotalRowCount = true;

        DataView dv = (DataView)sds.Select(dssa);
        if (dv.Table.Rows.Count == 0)
        {
            ImageButton ibNew = (fv.FindControl("ibNew") as ImageButton);
            ibNew.Visible = false;
        }
    }
    protected void fv_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        gv.DataBind();
    }
    protected void fv_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        gv.DataBind();
    }
    protected void fv_ItemCommand(object sender, FormViewCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "Survey":
                Response.Redirect(String.Format("/barsroot/credit/manager/grt_ins_survey.aspx?bid_id={0}&garantee_id={1}&garantee_num={2}&insurance_id={3}&insurance_num={4}&readonly={5}", BID_ID.ToString(), GARANTEE_ID, GARANTEE_NUM, Convert.ToString(gv.SelectedDataKey["INSURANCE_ID"]), Convert.ToString(gv.SelectedDataKey["INSURANCE_NUM"]), (ReadOnly.Value ? 1 : 0)));
                break;
        }
    }
    protected void fv_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        e.Values["BID_ID"] = BID_ID;
        e.Values["GARANTEE_ID"] = GARANTEE_ID;
        e.Values["GARANTEE_NUM"] = GARANTEE_NUM;
    }
    protected void bNext_Click(object sender, EventArgs e)
    {
        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        try
        {
            // проверяем заполненость всех страховок
            if (!Validate(con, BID_ID)) return;

            // переводим обеспечение в след состояние
            if (BidGarantee.STATUS_ID == 4) // Страхові договори
                cmn.wp.BID_GARANTEE_STATUS_SET(BID_ID, GARANTEE_ID, GARANTEE_NUM, 5); // Заведено

            // возвращаемся в карточку заявки
            Response.Redirect(String.Format("/barsroot/credit/manager/garantees.aspx?bid_id={0}&readonly={1}", BID_ID.ToString(), (ReadOnly.Value ? 1 : 0)));
        }
        finally
        {
            con.CloseConnection();
        }
    }
    # endregion

    # region Приватные методы
    private Boolean Validate(BbConnection con, Decimal? BID_ID)
    {
        Common cmn = new Common(con, BID_ID);

        // проверки
        Master.HideError();

        // проверяем статусы договоров страховок
        List<VWcsBidGrtInsurancesRecord> lst = (new VWcsBidGrtInsurances(con)).SelectBidGrtInsurances(BID_ID, GARANTEE_ID, GARANTEE_NUM);
        foreach (VWcsBidGrtInsurancesRecord rec in lst)
        {
            // проверяем что залог в стостоянии "Заведено"
            if (rec.STATUS_ID != 2)
            {
                Master.ShowError(String.Format(Resources.credit.StringConstants.text_ins_must_be_in_status, rec.INSURANCE_NAME, rec.INSURANCE_NUM, "Заведено"));
                return false;
            }
        }

        return true;
    }
    # endregion
}
