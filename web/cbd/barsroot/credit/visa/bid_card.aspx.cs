using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Collections.Generic;
using credit;

using Bars.Classes;
using ibank.core;

public partial class credit_visa_bid_card : System.Web.UI.Page
{
    # region Приватные свойства
    # endregion

    # region Публичные свойства
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        try
        {
            // чекаут состояния
            if (!IsPostBack)
                cmn.wp.BID_STATE_CHECK_OUT(Master.BID_ID, "NEW_VISA", (String)null);
        }
        finally
        {
            con.CloseConnection();
        }

        Master.SetPageTitle(String.Format(this.Title, Convert.ToString(Master.BidRecord.BID_ID)), true);

        Master.FillData();
        CheckStateAccess();
    }

    protected void lbPROCCESS_Click(object sender, EventArgs e)
    {
        Response.Redirect(String.Format("/barsroot/credit/visa/process.aspx?srvhr={0}&bid_id={1}", Master.SRV_HIERARCHY, Master.BID_ID));
    }

    protected void lbFinish_Click(object sender, EventArgs e)
    {
        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        // проверки
        if (!Validate(con, Master.BID_ID)) return;

        // завершаем состояние ... VISA
        cmn.wp.BID_STATE_CHECK_IN(Master.BID_ID, "NEW_VISA", GetVisaComm(con, Master.BID_ID));
        cmn.wp.BID_STATE_DEL(Master.BID_ID, "NEW_VISA");

        // анализируем результат визы
        List<VWcsVisaBidInfoqueriesRecord> lst = (new VWcsVisaBidInfoqueries(con)).SelectVisaBidInfoqueries(Master.BID_ID, Master.SRV_HIERARCHY);
        String WS_ID = (lst.Count > 0 ? lst[0].WS_ID : "MAIN");
        Decimal? IQ_VISA_Q1 = cmn.wu.GET_ANSW_BOOL(Master.BID_ID, "IQ_VISA_Q1", WS_ID, 0);
        if (IQ_VISA_Q1 == 0)
            cmn.wp.BID_STATE_SET_IMMEDIATE(Master.BID_ID, "NEW_DENY", GetVisaComm(con, Master.BID_ID));

        Response.Redirect(String.Format("/barsroot/credit/visa/queries.aspx?srvhr={0}", Master.SRV_HIERARCHY));
    }
    # endregion

    # region Приватные методы
    private void CheckStateAccess()
    {
        // все проверки доступа выполнены на уровне представления
    }
    private Boolean Validate(BbConnection con, Decimal? BID_ID)
    {
        Common cmn = new Common(con, BID_ID);

        // проверки
        Master.HideError();

        // вопросы группы
        List<VWcsVisaBidInfoqueriesRecord> lst = (new VWcsVisaBidInfoqueries(con)).SelectVisaBidInfoqueries(BID_ID, Master.SRV_HIERARCHY);
        foreach (VWcsVisaBidInfoqueriesRecord rec in lst)
        {
            // проверяем что обязательный запрос обработан
            if (1 == rec.IS_REQUIRED && (2 != rec.STATUS || !rec.STATUS.HasValue))
            {
                Master.ShowError(String.Format(Resources.credit.StringConstants.text_incomplete_iquery, rec.IQUERY_ID, rec.IQUERY_NAME));
                return false;
            }
        }

        return true;
    }
    private String GetVisaComm(BbConnection con, Decimal? BID_ID)
    {
        Common cmn = new Common(con, BID_ID);
        String VisaComm = String.Empty;

        List<VWcsVisaBidInfoqueriesRecord> lst = (new VWcsVisaBidInfoqueries(con)).SelectVisaBidInfoqueries(Master.BID_ID, Master.SRV_HIERARCHY);
        String WS_ID = (lst.Count > 0 ? lst[0].WS_ID : "MAIN");

        Decimal? IQ_VISA_Q1 = cmn.wu.GET_ANSW_BOOL(BID_ID, "IQ_VISA_Q1", WS_ID, 0);
        String IQ_VISA_Q2 = cmn.wu.GET_ANSW_TEXT(BID_ID, "IQ_VISA_Q2", WS_ID, 0);

        return (IQ_VISA_Q1 == 0 ? Resources.credit.StringConstants.text_storno : Resources.credit.StringConstants.text_visa) + " : " + IQ_VISA_Q2;
    }
    # endregion
}