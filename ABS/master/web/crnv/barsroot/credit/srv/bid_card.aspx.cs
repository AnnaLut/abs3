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

public partial class credit_srv_bid_card : System.Web.UI.Page
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
                // завершаем состояние Кредитна служба - обробка заявки, если все запросы обработаны
                switch (Master.SRV_HIERARCHY.ToUpper())
                {
                    case "TOBO":
                        switch (Master.SRV.ToUpper())
                        {
                            case "SS":
                                cmn.wp.BID_STATE_CHECK_OUT(Master.BID_ID, "NEW_SECURITY_S_PRC", (String)null);
                                break;
                            case "LS":
                                cmn.wp.BID_STATE_CHECK_OUT(Master.BID_ID, "NEW_LAW_S_PRC", (String)null);
                                break;
                            case "AS":
                                cmn.wp.BID_STATE_CHECK_OUT(Master.BID_ID, "NEW_PROBLEMACTIVE_S_PRC", (String)null);
                                break;
                        }
                        break;
                    case "RU":
                        switch (Master.SRV.ToUpper())
                        {
                            case "SS":
                                cmn.wp.BID_STATE_CHECK_OUT(Master.BID_ID, "NEW_RU_SECURITY_S_PRC", (String)null);
                                break;
                            case "LS":
                                cmn.wp.BID_STATE_CHECK_OUT(Master.BID_ID, "NEW_RU_LAW_S_PRC", (String)null);
                                break;
                            case "AS":
                                cmn.wp.BID_STATE_CHECK_OUT(Master.BID_ID, "NEW_RU_PROBLEMACTIVE_S_PRC", (String)null);
                                break;
                        }
                        break;
                    case "CA":
                        switch (Master.SRV.ToUpper())
                        {
                            case "SS":
                                cmn.wp.BID_STATE_CHECK_OUT(Master.BID_ID, "NEW_CA_SECURITY_S_PRC", (String)null);
                                break;
                            case "LS":
                                cmn.wp.BID_STATE_CHECK_OUT(Master.BID_ID, "NEW_CA_LAW_S_PRC", (String)null);
                                break;
                            case "AS":
                                cmn.wp.BID_STATE_CHECK_OUT(Master.BID_ID, "NEW_CA_PROBLEMACTIVE_S_PRC", (String)null);
                                break;
                            case "RS":
                                cmn.wp.BID_STATE_CHECK_OUT(Master.BID_ID, "NEW_CA_RISK_S_PRC", (String)null);
                                break;
                            case "FS":
                                cmn.wp.BID_STATE_CHECK_OUT(Master.BID_ID, "NEW_CA_FINANCE_S_PRC", (String)null);
                                break;
                        }
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
        Response.Redirect(String.Format("/barsroot/credit/srv/process.aspx?srv={0}&srvhr={1}&bid_id={2}", Master.SRV, Master.SRV_HIERARCHY, Master.BID_ID));
    }
    protected void lbDOCS_Click(object sender, EventArgs e)
    {
        Response.Redirect(String.Format("/barsroot/credit/srv/printdocs.aspx?srv={0}&srvhr={1}&bid_id={2}", Master.SRV, Master.SRV_HIERARCHY, Master.BID_ID));
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
                switch (Master.SRV.ToUpper())
                {
                    case "SS":
                        cmn.wp.BID_STATE_CHECK_IN(Master.BID_ID, "NEW_SECURITY_S_PRC", GetSrvConclusion(con, Master.BID_ID));
                        cmn.wp.BID_STATE_DEL(Master.BID_ID, "NEW_SECURITY_S_PRC");
                        break;
                    case "LS":
                        cmn.wp.BID_STATE_CHECK_IN(Master.BID_ID, "NEW_LAW_S_PRC", GetSrvConclusion(con, Master.BID_ID));
                        cmn.wp.BID_STATE_DEL(Master.BID_ID, "NEW_LAW_S_PRC");
                        break;
                    case "AS":
                        cmn.wp.BID_STATE_CHECK_IN(Master.BID_ID, "NEW_PROBLEMACTIVE_S_PRC", GetSrvConclusion(con, Master.BID_ID));
                        cmn.wp.BID_STATE_DEL(Master.BID_ID, "NEW_PROBLEMACTIVE_S_PRC");
                        break;
                }
                break;
            case "RU":
                switch (Master.SRV.ToUpper())
                {
                    case "SS":
                        cmn.wp.BID_STATE_CHECK_IN(Master.BID_ID, "NEW_RU_SECURITY_S_PRC", GetSrvConclusion(con, Master.BID_ID));
                        cmn.wp.BID_STATE_DEL(Master.BID_ID, "NEW_RU_SECURITY_S_PRC");
                        break;
                    case "LS":
                        cmn.wp.BID_STATE_CHECK_IN(Master.BID_ID, "NEW_RU_LAW_S_PRC", GetSrvConclusion(con, Master.BID_ID));
                        cmn.wp.BID_STATE_DEL(Master.BID_ID, "NEW_RU_LAW_S_PRC");
                        break;
                    case "AS":
                        cmn.wp.BID_STATE_CHECK_IN(Master.BID_ID, "NEW_RU_PROBLEMACTIVE_S_PRC", GetSrvConclusion(con, Master.BID_ID));
                        cmn.wp.BID_STATE_DEL(Master.BID_ID, "NEW_RU_PROBLEMACTIVE_S_PRC");
                        break;
                }
                break;
            case "CA":
                switch (Master.SRV.ToUpper())
                {
                    case "SS":
                        cmn.wp.BID_STATE_CHECK_IN(Master.BID_ID, "NEW_CA_SECURITY_S_PRC", GetSrvConclusion(con, Master.BID_ID));
                        cmn.wp.BID_STATE_DEL(Master.BID_ID, "NEW_CA_SECURITY_S_PRC");
                        break;
                    case "LS":
                        cmn.wp.BID_STATE_CHECK_IN(Master.BID_ID, "NEW_CA_LAW_S_PRC", GetSrvConclusion(con, Master.BID_ID));
                        cmn.wp.BID_STATE_DEL(Master.BID_ID, "NEW_CA_LAW_S_PRC");
                        break;
                    case "AS":
                        cmn.wp.BID_STATE_CHECK_IN(Master.BID_ID, "NEW_CA_PROBLEMACTIVE_S_PRC", GetSrvConclusion(con, Master.BID_ID));
                        cmn.wp.BID_STATE_DEL(Master.BID_ID, "NEW_CA_PROBLEMACTIVE_S_PRC");
                        break;
                    case "RS":
                        cmn.wp.BID_STATE_CHECK_IN(Master.BID_ID, "NEW_CA_RISK_S_PRC", GetSrvConclusion(con, Master.BID_ID));
                        cmn.wp.BID_STATE_DEL(Master.BID_ID, "NEW_CA_RISK_S_PRC");
                        break;
                    case "FS":
                        cmn.wp.BID_STATE_CHECK_IN(Master.BID_ID, "NEW_CA_FINANCE_S_PRC", GetSrvConclusion(con, Master.BID_ID));
                        cmn.wp.BID_STATE_DEL(Master.BID_ID, "NEW_CA_FINANCE_S_PRC");
                        break;
                }
                break;
        }

        Response.Redirect(String.Format("/barsroot/credit/srv/queries.aspx?srv={0}&srvhr={1}", Master.SRV, Master.SRV_HIERARCHY));
    }
    # endregion

    # region Приватные методы
    private void CheckStateAccess()
    {
        Common cmn = new Common(new BbConnection());

        switch (Master.SRV_HIERARCHY.ToUpper())
        {
            case "TOBO":
                switch (Master.SRV.ToUpper())
                {
                    case "SS":
                        lbPROCCESS.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_SECURITY_S_PRC"));
                        lbDOCS.Enabled = true;

                        lbFinish.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_SECURITY_S_PRC"));
                        break;
                    case "LS":
                        lbPROCCESS.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_LAW_S_PRC"));
                        lbDOCS.Enabled = true;

                        lbFinish.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_LAW_S_PRC"));
                        break;
                    case "AS":
                        lbPROCCESS.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_PROBLEMACTIVE_S_PRC"));
                        lbDOCS.Enabled = true;

                        lbFinish.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_PROBLEMACTIVE_S_PRC"));
                        break;
                }
                break;
            case "RU":
                switch (Master.SRV.ToUpper())
                {
                    case "SS":
                        lbPROCCESS.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_RU_SECURITY_S_PRC"));
                        lbDOCS.Enabled = true;

                        lbFinish.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_RU_SECURITY_S_PRC"));
                        break;
                    case "LS":
                        lbPROCCESS.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_RU_LAW_S_PRC"));
                        lbDOCS.Enabled = true;

                        lbFinish.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_RU_LAW_S_PRC"));
                        break;
                    case "AS":
                        lbPROCCESS.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_RU_PROBLEMACTIVE_S_PRC"));
                        lbDOCS.Enabled = true;

                        lbFinish.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_RU_PROBLEMACTIVE_S_PRC"));
                        break;
                }
                break;
            case "CA":
                switch (Master.SRV.ToUpper())
                {
                    case "SS":
                        lbPROCCESS.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CA_SECURITY_S_PRC"));
                        lbDOCS.Enabled = true;

                        lbFinish.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CA_SECURITY_S_PRC"));
                        break;
                    case "LS":
                        lbPROCCESS.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CA_LAW_S_PRC"));
                        lbDOCS.Enabled = true;

                        lbFinish.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CA_LAW_S_PRC"));
                        break;
                    case "AS":
                        lbPROCCESS.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CA_PROBLEMACTIVE_S_PRC"));
                        lbDOCS.Enabled = true;

                        lbFinish.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CA_PROBLEMACTIVE_S_PRC"));
                        break;
                    case "RS":
                        lbPROCCESS.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CA_RISK_S_PRC"));
                        lbDOCS.Enabled = true;

                        lbFinish.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CA_RISK_S_PRC"));
                        break;
                    case "FS":
                        lbPROCCESS.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CA_FINANCE_S_PRC"));
                        lbDOCS.Enabled = true;

                        lbFinish.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CA_FINANCE_S_PRC"));
                        break;
                }
                break;
        }
    }
    private Boolean Validate(BbConnection con, Decimal? BID_ID)
    {
        Common cmn = new Common(con, BID_ID);

        // проверки
        Master.HideError();

        // вопросы группы
        List<VWcsSrvBidInfoqueriesRecord> lst = (new VWcsSrvBidInfoqueries(con)).SelectSrvBidInfoqueries(Master.SRV, Master.SRV_HIERARCHY, BID_ID);
        foreach (VWcsSrvBidInfoqueriesRecord rec in lst)
        {
            // проверяем что обязательный запрос обработан
            if (1 == rec.IS_REQUIRED && (2 != rec.STATUS || !rec.STATUS.HasValue))
            {
                Master.ShowError(String.Format(Resources.credit.StringConstants.text_incomplete_iquery, rec.IQUERY_ID, rec.IQUERY_NAME));
                return false;
            }
        }

        // сканкопии печатных документов
        List<VWcsSrvBidTemplatesRecord> lstTemplates = (new VWcsSrvBidTemplates(con)).SelectSrvBidTemplates(Master.SRV, BID_ID);
        foreach (VWcsSrvBidTemplatesRecord rec in lstTemplates)
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
    private String GetSrvConclusion(BbConnection con, Decimal? BID_ID)
    {
        Common cmn = new Common(con, BID_ID);
        String SrvConclusion = String.Empty;

        String IQUERY_ID = String.Empty;
        String QUESTION_ID = String.Empty;
        switch (Master.SRV.ToUpper())
        {
            case "SS":
                IQUERY_ID = "IQ_CONCL_SECURITY_S";
                QUESTION_ID = "IQ_CONCL_SECURITY_S_Q6";
                break;
            case "LS":
                IQUERY_ID = "IQ_CONCL_LAW_S";
                QUESTION_ID = "IQ_CONCL_LAW_S_Q7";
                break;
            case "AS":
                IQUERY_ID = "IQ_CONCL_ASSETS_S";
                QUESTION_ID = "IQ_CONCL_ASSETS_S_Q12";
                break;
            case "RS":
                // !!!!! Доделать
                IQUERY_ID = String.Empty;
                QUESTION_ID = String.Empty;
                break;
            case "FS":
                // !!!!! Доделать
                IQUERY_ID = String.Empty;
                QUESTION_ID = String.Empty;
                break;
        }

        List<VWcsSrvBidInfoqueriesRecord> lst = (new VWcsSrvBidInfoqueries(con)).SelectSrvBidInfoquery(Master.SRV, Master.SRV_HIERARCHY, BID_ID, IQUERY_ID);
        if (lst.Count > 0 && lst[0].STATUS == 2)
        {
            VWcsSrvBidInfoqueriesRecord rec = lst[0];
            List<VWcsBidInfoqueryQuestionsRecord> lst0 = (new VWcsBidInfoqueryQuestions(con)).SelectBidInfoqueryQuestion(BID_ID, rec.IQUERY_ID, QUESTION_ID);
            if (lst0.Count > 0 && cmn.wu.HAS_ANSW(BID_ID, lst0[0].QUESTION_ID, lst[0].WS_ID, 0) == 1)
            {
                SrvConclusion = cmn.wu.GET_ANSW(BID_ID, lst0[0].QUESTION_ID, lst[0].WS_ID, 0);
            }
        }

        return Resources.credit.StringConstants.text_conclusion + SrvConclusion;
    }
    # endregion
}