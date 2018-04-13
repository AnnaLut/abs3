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

public partial class credit_constructor_insurances : Bars.BarsPage
{
    # region Приватные свойства
    private Decimal? BID_ID
    {
        get
        {
            return Convert.ToDecimal(Request.Params.Get("bid_id"));
        }
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        sds.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        // заголовок Страховки клиента по заявке №{0}
        Master.SetPageTitle(String.Format(this.Title, Convert.ToString(BID_ID)), true);

        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        try
        {
            // чекаут состояния
            if (!IsPostBack) cmn.wp.BID_STATE_CHECK_OUT(BID_ID, "NEW_INS_CLIENT", (String)null);
        }
        finally
        {
            con.CloseConnection();
        }

        // проверки
        Master.HideError();
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
                Response.Redirect(String.Format("/barsroot/credit/manager/ins_survey.aspx?bid_id={0}&insurance_id={1}&insurance_num={2}", BID_ID.ToString(), Convert.ToString(gv.SelectedDataKey["INSURANCE_ID"]), Convert.ToString(gv.SelectedDataKey["INSURANCE_NUM"])));
                break;
        }
    }
    protected void fv_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        e.Values["BID_ID"] = BID_ID;
    }
    protected void bNext_Click(object sender, EventArgs e)
    {
        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        try
        {
            // про
            if (!Validate(con, BID_ID)) return;

            // чекин состояния и чистка сессии
            cmn.wp.BID_STATE_CHECK_IN(BID_ID, "NEW_INS_CLIENT", (String)null);

            // завершаем состояние и переходим на след
            cmn.wp.BID_STATE_DEL(BID_ID, "NEW_INS_CLIENT");

            // возвращаемся в карточку заявки
            Response.Redirect(String.Format("/barsroot/credit/manager/bid_card.aspx?bid_id={0}", BID_ID.ToString()));
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
        List<VWcsBidInsurancesRecord> lst = (new VWcsBidInsurances(con)).SelectBidInsurances(BID_ID);
        foreach (VWcsBidInsurancesRecord rec in lst)
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
