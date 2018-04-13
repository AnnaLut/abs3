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

public partial class credit_secretarycc_bid_card : System.Web.UI.Page
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
            {
                switch (Master.SRV_HIERARCHY.ToUpper())
                {
                    case "TOBO":
                        cmn.wp.BID_STATE_CHECK_OUT(Master.BID_ID, "NEW_SECRETARYCC", (String)null);
                        break;
                    case "RU":
                        cmn.wp.BID_STATE_CHECK_OUT(Master.BID_ID, "NEW_RU_SECRETARYCC", (String)null);
                        break;
                    case "CA":
                        cmn.wp.BID_STATE_CHECK_OUT(Master.BID_ID, "NEW_CA_SECRETARYCC", (String)null);
                        break;
                }
            }
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
        Response.Redirect(String.Format("/barsroot/credit/secretarycc/process.aspx?srvhr={0}&bid_id={1}", Master.SRV_HIERARCHY, Master.BID_ID));
    }
    protected void lbDOCS_Click(object sender, EventArgs e)
    {
        Response.Redirect(String.Format("/barsroot/credit/secretarycc/printdocs.aspx?srvhr={0}&bid_id={1}", Master.SRV_HIERARCHY, Master.BID_ID));
    }

    protected void lbFinish_Click(object sender, EventArgs e)
    {
        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        // проверки
        if (!Validate(con, Master.BID_ID)) return;

        // завершаем состояние ... служба - обробка заявки, если все запросы обработаны
        switch (Master.SRV_HIERARCHY.ToUpper())
        {
            case "TOBO":
                cmn.wp.BID_STATE_CHECK_IN(Master.BID_ID, "NEW_SECRETARYCC", GetCCConclusion(con, Master.BID_ID));
                cmn.wp.BID_STATE_DEL(Master.BID_ID, "NEW_SECRETARYCC");
                break;
            case "RU":
                cmn.wp.BID_STATE_CHECK_IN(Master.BID_ID, "NEW_RU_SECRETARYCC", GetCCConclusion(con, Master.BID_ID));
                cmn.wp.BID_STATE_DEL(Master.BID_ID, "NEW_RU_SECRETARYCC");
                break;
            case "CA":
                cmn.wp.BID_STATE_CHECK_IN(Master.BID_ID, "NEW_CA_SECRETARYCC", GetCCConclusion(con, Master.BID_ID));
                cmn.wp.BID_STATE_DEL(Master.BID_ID, "NEW_CA_SECRETARYCC");
                break;
        }

        Response.Redirect(String.Format("/barsroot/credit/secretarycc/queries.aspx?srvhr={0}", Master.SRV_HIERARCHY));
    }
    # endregion

    # region Приватные методы
    private void CheckStateAccess()
    {
        Common cmn = new Common(new BbConnection());

        switch (Master.SRV_HIERARCHY.ToUpper())
        {
            case "TOBO":
                lbPROCCESS.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_SECRETARYCC"));
                lbDOCS.Enabled = true;
                break;
            case "RU":
                lbPROCCESS.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_RU_SECRETARYCC"));
                lbDOCS.Enabled = true;
                break;
            case "CA":
                lbPROCCESS.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CA_SECRETARYCC"));
                lbDOCS.Enabled = true;
                break;
        }
    }
    private Boolean Validate(BbConnection con, Decimal? BID_ID)
    {
        Common cmn = new Common(con, BID_ID);

        // проверки
        Master.HideError();

        // вопросы группы
        List<VWcsCcBidInfoqueriesRecord> lst = (new VWcsCcBidInfoqueries(con)).SelectCcBidInfoqueries(BID_ID, Master.SRV_HIERARCHY);
        foreach (VWcsCcBidInfoqueriesRecord rec in lst)
        {
            // проверяем что обязательный запрос обработан
            if (1 == rec.IS_REQUIRED && (2 != rec.STATUS || !rec.STATUS.HasValue))
            {
                Master.ShowError(String.Format(Resources.credit.StringConstants.text_incomplete_iquery, rec.IQUERY_ID, rec.IQUERY_NAME));
                return false;
            }
        }

        // сканкопии печатных документов
        List<VWcsCcBidTemplatesRecord> lstTemplates = (new VWcsCcBidTemplates(con)).SelectCcBidTemplates(BID_ID);
        foreach (VWcsCcBidTemplatesRecord rec in lstTemplates)
        {
            // проверяем что обязательная сканкопия отсканированна
            if (1 == rec.IS_SCAN_REQUIRED && rec.IMG == null)
            {
                Master.ShowError(String.Format(Resources.credit.StringConstants.text_unscaned_document, rec.TEMPLATE_ID, rec.TEMPLATE_NAME));
                return false;
            }
        }

        return true;
    }
    private String GetCCConclusion(BbConnection con, Decimal? BID_ID)
    {
        Common cmn = new Common(con, BID_ID);
        String CCConclusion = String.Empty;

        List<VWcsCcBidInfoqueriesRecord> lst = (new VWcsCcBidInfoqueries(con)).SelectCcBidInfoqueries(BID_ID, Master.SRV_HIERARCHY);
        String WS_ID = (lst.Count > 0 ? lst[0].WS_ID : "MAIN");

        if (cmn.wu.HAS_ANSW(BID_ID, "IQ_CC_DECISION_Q1", WS_ID, 0) == 1 &&
            cmn.wu.HAS_ANSW(BID_ID, "IQ_CC_DECISION_Q2", WS_ID, 0) == 1 &&
            cmn.wu.HAS_ANSW(BID_ID, "IQ_CC_DECISION_Q3", WS_ID, 0) == 1)
        {
            DateTime? IQ_CC_DECISION_Q1 = cmn.wu.GET_ANSW_DATE(BID_ID, "IQ_CC_DECISION_Q1", WS_ID, 0);
            String IQ_CC_DECISION_Q2 = cmn.wu.GET_ANSW_TEXT(BID_ID, "IQ_CC_DECISION_Q2", WS_ID, 0);
            String IQ_CC_DECISION_Q3 = cmn.wu.GET_ANSW_LIST_TEXT(BID_ID, "IQ_CC_DECISION_Q3", WS_ID, 0);
            String IQ_CC_DECISION_Q4 = cmn.wu.GET_ANSW_TEXT(BID_ID, "IQ_CC_DECISION_Q4", WS_ID, 0);

            CCConclusion = String.Format(Resources.credit.StringConstants.text_decision1, IQ_CC_DECISION_Q2, IQ_CC_DECISION_Q1, IQ_CC_DECISION_Q3, IQ_CC_DECISION_Q4);
        }

        return Resources.credit.StringConstants.text_decision2 + CCConclusion;
    }
    # endregion
}