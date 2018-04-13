using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Collections.Generic;
using credit;

using Bars.Classes;
using ibank.core;

public partial class credit_crdsrv_bid_card : System.Web.UI.Page
{
    # region Приватные свойства
    private VWcsBidsRecord _BidRecord;

    # endregion

    # region Публичные свойства
    public VWcsBidsRecord BidRecord
    {
        get
        {
            if (_BidRecord == null)
            {
                List<VWcsBidsRecord> lst = (new VWcsBids()).SelectBid(Master.BID_ID);
                if (lst.Count > 0) _BidRecord = lst[0];
            }

            return _BidRecord;
        }
    }
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
                        cmn.wp.BID_STATE_CHECK_OUT(Master.BID_ID, "NEW_CREDIT_S", (String)null);

                        if (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CREDIT_S_PRC"))
                            cmn.wp.BID_STATE_CHECK_OUT(Master.BID_ID, "NEW_CREDIT_S_PRC", (String)null);
                        if (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CREDIT_S_SRVANALYSE"))
                            cmn.wp.BID_STATE_CHECK_OUT(Master.BID_ID, "NEW_CREDIT_S_SRVANALYSE", (String)null);
                        if (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CREDIT_S_CCANALYSE"))
                            cmn.wp.BID_STATE_CHECK_OUT(Master.BID_ID, "NEW_CREDIT_S_CCANALYSE", (String)null);
                        break;
                    case "RU":
                        cmn.wp.BID_STATE_CHECK_OUT(Master.BID_ID, "NEW_RU_CREDIT_S", (String)null);

                        if (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_RU_CREDIT_S_PRC"))
                            cmn.wp.BID_STATE_CHECK_OUT(Master.BID_ID, "NEW_RU_CREDIT_S_PRC", (String)null);
                        if (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_RU_CREDIT_S_SRVANALYSE"))
                            cmn.wp.BID_STATE_CHECK_OUT(Master.BID_ID, "NEW_RU_CREDIT_S_SRVANALYSE", (String)null);
                        if (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_RU_CREDIT_S_CCANALYSE"))
                            cmn.wp.BID_STATE_CHECK_OUT(Master.BID_ID, "NEW_RU_CREDIT_S_CCANALYSE", (String)null);
                        break;
                    case "CA":
                        cmn.wp.BID_STATE_CHECK_OUT(Master.BID_ID, "NEW_CA_CREDIT_S", (String)null);

                        if (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CA_CREDIT_S_PRC"))
                            cmn.wp.BID_STATE_CHECK_OUT(Master.BID_ID, "NEW_CA_CREDIT_S_PRC", (String)null);
                        if (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CA_CREDIT_S_SRVANALYSE"))
                            cmn.wp.BID_STATE_CHECK_OUT(Master.BID_ID, "NEW_CA_CREDIT_S_SRVANALYSE", (String)null);
                        if (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CA_CREDIT_S_CCANALYSE"))
                            cmn.wp.BID_STATE_CHECK_OUT(Master.BID_ID, "NEW_CA_CREDIT_S_CCANALYSE", (String)null);
                        break;
                }

                // отображение решения КК
                if (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CREDIT_S_CCANALYSE") ||
                    1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_RU_CREDIT_S_CCANALYSE") ||
                    1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CA_CREDIT_S_CCANALYSE"))
                {
                    String CCConclusion = GetCCConclusion(con, Master.BID_ID);
                    String LableShort = lbFinishCcAnalyse.Text + " (" + (CCConclusion.Length > 30 ? CCConclusion.Substring(0, 30) + "..." : CCConclusion) + ")";
                    String LableFull = lbFinishCcAnalyse.Text + " (" + CCConclusion + ")";

                    lbFinishCcAnalyse.Text = LableShort;
                    lbFinishCcAnalyse.ToolTip = LableFull;
                }

                // проверка довведенных данные если была доработка
                if (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_DATAREINPUT_FINISHED"))
                {
                    cmn.wp.BID_STATE_CHECK_OUT(Master.BID_ID, "NEW_DATAREINPUT_FINISHED", (String)null);
                }
                if (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_SRVSREINPUT_FINISHED"))
                {
                    cmn.wp.BID_STATE_CHECK_OUT(Master.BID_ID, "NEW_SRVSREINPUT_FINISHED", (String)null);
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
        Response.Redirect(String.Format("/barsroot/credit/crdsrv/process.aspx?srvhr={0}&bid_id={1}", Master.SRV_HIERARCHY, Master.BID_ID));
    }
    protected void lbDOCS_Click(object sender, EventArgs e)
    {
        Response.Redirect(String.Format("/barsroot/credit/crdsrv/printdocs.aspx?srvhr={0}&bid_id={1}", Master.SRV_HIERARCHY, Master.BID_ID));
    }

    protected void lbSend2Srvs_Click(object sender, EventArgs e)
    {
        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        // проверка довведенных данные если была доработка
        if (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_DATAREINPUT_FINISHED"))
        {
            cmn.wp.BID_STATE_CHECK_IN(Master.BID_ID, "NEW_DATAREINPUT_FINISHED", (String)null);
            cmn.wp.BID_STATE_DEL(Master.BID_ID, "NEW_DATAREINPUT_FINISHED");
        }

        if (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_SRVSREINPUT_FINISHED"))
        {
            cmn.wp.BID_STATE_CHECK_IN(Master.BID_ID, "NEW_SRVSREINPUT_FINISHED", (String)null);
            cmn.wp.BID_STATE_DEL(Master.BID_ID, "NEW_SRVSREINPUT_FINISHED");
        }

        // проверки
        if (!Validate(con, Master.BID_ID)) return;

        switch (Master.SRV_HIERARCHY.ToUpper())
        {
            case "TOBO":
                cmn.wp.BID_STATE_CHECK_IN(Master.BID_ID, "NEW_CREDIT_S_PRC", GetCrdSrvConclusion(con, Master.BID_ID));
                cmn.wp.BID_STATE_DEL(Master.BID_ID, "NEW_CREDIT_S_PRC");
                break;
            case "RU":
                cmn.wp.BID_STATE_CHECK_IN(Master.BID_ID, "NEW_RU_CREDIT_S_PRC", GetCrdSrvConclusion(con, Master.BID_ID));
                cmn.wp.BID_STATE_DEL(Master.BID_ID, "NEW_RU_CREDIT_S_PRC");
                break;
            case "CA":
                cmn.wp.BID_STATE_CHECK_IN(Master.BID_ID, "NEW_CA_CREDIT_S_PRC", GetCrdSrvConclusion(con, Master.BID_ID));
                cmn.wp.BID_STATE_DEL(Master.BID_ID, "NEW_CA_CREDIT_S_PRC");
                break;
        }

        Response.Redirect(String.Format("/barsroot/credit/crdsrv/queries.aspx?srvhr={0}", Master.SRV_HIERARCHY));
    }
    protected void lbFinishSrvAnalyse_Click(object sender, EventArgs e)
    {
        Common cmn = new Common(new BbConnection());

        // проверка довведенных данные если была доработка
        if (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_DATAREINPUT_FINISHED"))
        {
            cmn.wp.BID_STATE_CHECK_IN(Master.BID_ID, "NEW_DATAREINPUT_FINISHED", (String)null);
            cmn.wp.BID_STATE_DEL(Master.BID_ID, "NEW_DATAREINPUT_FINISHED");
        }

        if (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_SRVSREINPUT_FINISHED"))
        {
            cmn.wp.BID_STATE_CHECK_IN(Master.BID_ID, "NEW_SRVSREINPUT_FINISHED", (String)null);
            cmn.wp.BID_STATE_DEL(Master.BID_ID, "NEW_SRVSREINPUT_FINISHED");
        }

        // завершаем состояние Кредитна служба - аналіз результатів розгляду службами
        switch (Master.SRV_HIERARCHY.ToUpper())
        {
            case "TOBO":
                cmn.wp.BID_STATE_CHECK_IN(Master.BID_ID, "NEW_CREDIT_S_SRVANALYSE", (String)null);
                cmn.wp.BID_STATE_DEL(Master.BID_ID, "NEW_CREDIT_S_SRVANALYSE");
                break;
            case "RU":
                cmn.wp.BID_STATE_CHECK_IN(Master.BID_ID, "NEW_RU_CREDIT_S_SRVANALYSE", (String)null);
                cmn.wp.BID_STATE_DEL(Master.BID_ID, "NEW_RU_CREDIT_S_SRVANALYSE");
                break;
            case "CA":
                cmn.wp.BID_STATE_CHECK_IN(Master.BID_ID, "NEW_CA_CREDIT_S_SRVANALYSE", (String)null);
                cmn.wp.BID_STATE_DEL(Master.BID_ID, "NEW_CA_CREDIT_S_SRVANALYSE");
                break;
        }

        Response.Redirect(String.Format("/barsroot/credit/crdsrv/queries.aspx?srvhr={0}", Master.SRV_HIERARCHY));
    }
    protected void lbFinishCcAnalyse_Click(object sender, EventArgs e)
    {
        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        // решение КК
        /*
        0	Прийнято
        1	Прийнято за умовою (зміна: % ставки, Забезпечення, Строку, Суми)
        2	Прийнято за умовою (розгляд на рівні вищої установи)
        3	Відхилено
        4	Прийнято з відкладальною умовою
        */
        List<VWcsCrdsrvBidInfoqueriesRecord> lst = (new VWcsCrdsrvBidInfoqueries(con)).SelectCrdsrvBidInfoqueries(Master.BID_ID, Master.SRV_HIERARCHY);
        String WS_ID = (lst.Count > 0 ? lst[0].WS_ID : "MAIN");

        Decimal? CCConclusion = (Decimal?)null;
        if (1 == cmn.wu.HAS_ANSW(Master.BID_ID, "IQ_CC_DECISION_Q3", WS_ID, 0))
        {
            CCConclusion = cmn.wu.GET_ANSW_LIST(Master.BID_ID, "IQ_CC_DECISION_Q3", WS_ID, 0);
        }

        // проверяем текущее значение лимита разсмотрения
        Decimal? SumLimit = (Decimal?)null;
        SumLimit = Convert.ToDecimal(cmn.wu.GET_SBP_MAC(Master.BidRecord.SUBPRODUCT_ID, "MAC_SUM_LIMIT"));

        switch (Convert.ToInt32(CCConclusion.Value))
        {
            case 0:
            case 4:
                # region 0 Прийнято, 4 Прийнято з відкладальною умовою
                // проверка довведенных данные если была доработка
                if (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_DATAREINPUT_FINISHED"))
                {
                    cmn.wp.BID_STATE_CHECK_IN(Master.BID_ID, "NEW_DATAREINPUT_FINISHED", (String)null);
                    cmn.wp.BID_STATE_DEL(Master.BID_ID, "NEW_DATAREINPUT_FINISHED");
                }

                if (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_SRVSREINPUT_FINISHED"))
                {
                    cmn.wp.BID_STATE_CHECK_IN(Master.BID_ID, "NEW_SRVSREINPUT_FINISHED", (String)null);
                    cmn.wp.BID_STATE_DEL(Master.BID_ID, "NEW_SRVSREINPUT_FINISHED");
                }

                FinishCurrentCreditSCCAnalyse(cmn, Master.SRV_HIERARCHY.ToUpper(), Master.BID_ID);
                FinishCurrentCreditS(cmn, Master.SRV_HIERARCHY.ToUpper(), Master.BID_ID);

                FinishWithAnalysedLimit(con, cmn, SumLimit, BidRecord.SUMM, Master.SRV_HIERARCHY.ToUpper(), Master.BID_ID);
                # endregion
                break;
            case 1:
                # region 1 Прийнято за умовою (зміна: % ставки, Забезпечення, Строку, Суми)

                // проверка довведенных данные если была доработка
                if (1 != cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_DATAREINPUT_FINISHED"))
                {
                    cmn.wp.BID_STATE_SET(Master.BID_ID, "NEW_DATAREINPUT", GetCCConclusion(con, Master.BID_ID));
                }
                else
                {
                    cmn.wp.BID_STATE_CHECK_IN(Master.BID_ID, "NEW_DATAREINPUT_FINISHED", (String)null);
                    cmn.wp.BID_STATE_DEL(Master.BID_ID, "NEW_DATAREINPUT_FINISHED");

                    # region Принимаем
                    FinishCurrentCreditSCCAnalyse(cmn, Master.SRV_HIERARCHY.ToUpper(), Master.BID_ID);
                    FinishCurrentCreditS(cmn, Master.SRV_HIERARCHY.ToUpper(), Master.BID_ID);

                    FinishWithAnalysedLimit(con, cmn, SumLimit, BidRecord.SUMM, Master.SRV_HIERARCHY.ToUpper(), Master.BID_ID);
                    # endregion
                }
                # endregion
                break;
            case 2:
                # region 2 Прийнято за умовою (розгляд на рівні вищої установи)
                // проверка довведенных данные если была доработка
                if (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_DATAREINPUT_FINISHED"))
                {
                    cmn.wp.BID_STATE_CHECK_IN(Master.BID_ID, "NEW_DATAREINPUT_FINISHED", (String)null);
                    cmn.wp.BID_STATE_DEL(Master.BID_ID, "NEW_DATAREINPUT_FINISHED");
                }

                if (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_SRVSREINPUT_FINISHED"))
                {
                    cmn.wp.BID_STATE_CHECK_IN(Master.BID_ID, "NEW_SRVSREINPUT_FINISHED", (String)null);
                    cmn.wp.BID_STATE_DEL(Master.BID_ID, "NEW_SRVSREINPUT_FINISHED");
                }

                FinishCurrentCreditSCCAnalyse(cmn, Master.SRV_HIERARCHY.ToUpper(), Master.BID_ID);
                FinishCurrentCreditS(cmn, Master.SRV_HIERARCHY.ToUpper(), Master.BID_ID);

                FinishWithHLAnalyse(con, cmn, Master.SRV_HIERARCHY.ToUpper(), Master.BID_ID);
                # endregion
                break;
            case 3:
                # region 3 Відхилено
                FinishCurrentCreditSCCAnalyse(cmn, Master.SRV_HIERARCHY.ToUpper(), Master.BID_ID);
                FinishCurrentCreditS(cmn, Master.SRV_HIERARCHY.ToUpper(), Master.BID_ID);

                cmn.wp.BID_STATE_SET_IMMEDIATE(Master.BID_ID, "NEW_DENY", GetCCConclusion(con, Master.BID_ID));
                # endregion
                break;
        }

        Response.Redirect(String.Format("/barsroot/credit/crdsrv/queries.aspx?srvhr={0}", Master.SRV_HIERARCHY));
    }
    protected void lb2SrvsReInput_Click(object sender, EventArgs e)
    {
        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        // проверка довведенных данные если была доработка
        if (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_DATAREINPUT_FINISHED"))
        {
            cmn.wp.BID_STATE_CHECK_IN(Master.BID_ID, "NEW_DATAREINPUT_FINISHED", (String)null);
            cmn.wp.BID_STATE_DEL(Master.BID_ID, "NEW_DATAREINPUT_FINISHED");
        }

        if (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_SRVSREINPUT_FINISHED"))
        {
            cmn.wp.BID_STATE_CHECK_IN(Master.BID_ID, "NEW_SRVSREINPUT_FINISHED", (String)null);
            cmn.wp.BID_STATE_DEL(Master.BID_ID, "NEW_SRVSREINPUT_FINISHED");
        }

        /*cmn.wp.BID_STATE_SET(Master.BID_ID, "NEW_SRVSREINPUT", "Comment");
        cmn.wp.BID_STATE_CHECK_OUT(Master.BID_ID, "NEW_SRVSREINPUT", null);*/
        Response.Redirect(String.Format("/barsroot/credit/crdsrv/bid_srvsreinput.aspx?srvhr={0}&bid_id={1}", Master.SRV_HIERARCHY, Master.BID_ID));
    }
    protected void lbDataReInput_Click(object sender, EventArgs e)
    {
        Response.Redirect(String.Format("/barsroot/credit/crdsrv/bid_datareinput.aspx?srvhr={0}&bid_id={1}", Master.SRV_HIERARCHY, Master.BID_ID));
    }
    protected void lbDeny_Click(object sender, EventArgs e)
    {
        Response.Redirect(String.Format("/barsroot/credit/crdsrv/bid_deny.aspx?srvhr={0}&bid_id={1}", Master.SRV_HIERARCHY, Master.BID_ID));
    }
    # endregion

    # region Приватные методы
    private void CheckStateAccess()
    {
        Common cmn = new Common(new BbConnection());

        Boolean HasStateDataReInput = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_DATAREINPUT"));
        Boolean HasStateSrvsReInput = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_SRVSREINPUT"));

        switch (Master.SRV_HIERARCHY.ToUpper())
        {
            case "TOBO":
                lbPROCCESS.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CREDIT_S_PRC")) && !HasStateDataReInput;
                lbDOCS.Enabled = true;

                lbSend2Srvs.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CREDIT_S_PRC")) && !HasStateDataReInput;
                lbFinishSrvAnalyse.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CREDIT_S_SRVANALYSE")) && !HasStateDataReInput && !HasStateSrvsReInput;
                lbFinishCcAnalyse.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CREDIT_S_CCANALYSE")) && !HasStateDataReInput;
                lbDataReInput.Enabled = ((1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CREDIT_S_PRC")) || (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CREDIT_S_SRVANALYSE")) || (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CREDIT_S_CCANALYSE"))) && !HasStateDataReInput && !HasStateSrvsReInput;
                lbDeny.Enabled = ((1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CREDIT_S_PRC")) || (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CREDIT_S_SRVANALYSE")) || (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CREDIT_S_CCANALYSE"))) && !HasStateDataReInput && !HasStateSrvsReInput;
                lb2SrvsReInput.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CREDIT_S_SRVANALYSE")) && !HasStateDataReInput && !HasStateSrvsReInput;
                break;
            case "RU":
                lbPROCCESS.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_RU_CREDIT_S_PRC")) && !HasStateDataReInput;
                lbDOCS.Enabled = true;

                lbSend2Srvs.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_RU_CREDIT_S_PRC")) && !HasStateDataReInput;
                lbFinishSrvAnalyse.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_RU_CREDIT_S_SRVANALYSE")) && !HasStateDataReInput && !HasStateSrvsReInput;
                lbFinishCcAnalyse.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_RU_CREDIT_S_CCANALYSE")) && !HasStateDataReInput;
                lbDataReInput.Enabled = ((1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_RU_CREDIT_S_PRC")) || (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_RU_CREDIT_S_SRVANALYSE")) || (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_RU_CREDIT_S_CCANALYSE"))) && !HasStateDataReInput && !HasStateSrvsReInput;
                lbDeny.Enabled = ((1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_RU_CREDIT_S_PRC")) || (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_RU_CREDIT_S_SRVANALYSE")) || (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_RU_CREDIT_S_CCANALYSE"))) && !HasStateDataReInput && !HasStateSrvsReInput;
                lb2SrvsReInput.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_RU_CREDIT_S_SRVANALYSE")) && !HasStateDataReInput && !HasStateSrvsReInput;
                break;
            case "CA":
                lbPROCCESS.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CA_CREDIT_S_PRC")) && !HasStateDataReInput;
                lbDOCS.Enabled = true;

                lbSend2Srvs.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CA_CREDIT_S_PRC")) && !HasStateDataReInput;
                lbFinishSrvAnalyse.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CA_CREDIT_S_SRVANALYSE")) && !HasStateDataReInput && !HasStateSrvsReInput;
                lbFinishCcAnalyse.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CA_CREDIT_S_CCANALYSE")) && !HasStateDataReInput;
                lbDataReInput.Enabled = ((1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CA_CREDIT_S_PRC")) || (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CA_CREDIT_S_SRVANALYSE")) || (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CA_CREDIT_S_CCANALYSE"))) && !HasStateDataReInput && !HasStateSrvsReInput;
                lbDeny.Enabled = ((1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CA_CREDIT_S_PRC")) || (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CA_CREDIT_S_SRVANALYSE")) || (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_CA_CREDIT_S_CCANALYSE"))) && !HasStateDataReInput && !HasStateSrvsReInput;
                lb2SrvsReInput.Enabled = (1 == cmn.wu.HAS_BID_STATE(Master.BID_ID, "NEW_RU_CREDIT_S_SRVANALYSE")) && !HasStateDataReInput && !HasStateSrvsReInput;
                break;
        }
    }
    private Boolean Validate(BbConnection con, Decimal? BID_ID)
    {
        Common cmn = new Common(con, BID_ID);

        // проверки
        Master.HideError();

        // вопросы группы
        List<VWcsCrdsrvBidInfoqueriesRecord> lstInfoqueries = (new VWcsCrdsrvBidInfoqueries(con)).SelectCrdsrvBidInfoqueries(BID_ID, Master.SRV_HIERARCHY);
        foreach (VWcsCrdsrvBidInfoqueriesRecord rec in lstInfoqueries)
        {
            // проверяем что обязательный запрос обработан (2 - Виконано)
            if (1 == rec.IS_REQUIRED && (2 != rec.STATUS || !rec.STATUS.HasValue))
            {
                Master.ShowError(String.Format(Resources.credit.StringConstants.text_incomplete_iquery, rec.IQUERY_ID, rec.IQUERY_NAME));
                return false;
            }
        }

        // сканкопии печатных документов
        List<VWcsCrdsrvBidTemplatesRecord> lstTemplates = (new VWcsCrdsrvBidTemplates(con)).SelectCrdsrvBidTemplates(BID_ID);
        foreach (VWcsCrdsrvBidTemplatesRecord rec in lstTemplates)
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
    private String GetCrdSrvConclusion(BbConnection con, Decimal? BID_ID)
    {
        Common cmn = new Common(con, BID_ID);
        String CrdSrvConclusion = String.Empty;

        List<VWcsCrdsrvBidInfoqueriesRecord> lst = (new VWcsCrdsrvBidInfoqueries(con)).SelectCrdsrvBidInfoquery(BID_ID, Master.SRV_HIERARCHY, "IQ_CONCL_CREDIT_S");
        if (lst.Count > 0 && lst[0].STATUS == 2)
        {
            VWcsCrdsrvBidInfoqueriesRecord rec = lst[0];
            List<VWcsBidInfoqueryQuestionsRecord> lst0 = (new VWcsBidInfoqueryQuestions(con)).SelectBidInfoqueryQuestion(BID_ID, rec.IQUERY_ID, "IQ_CONCL_CREDIT_S_Q4");
            if (lst0.Count > 0 && cmn.wu.HAS_ANSW(BID_ID, lst0[0].QUESTION_ID, lst[0].WS_ID, 0) == 1)
            {
                CrdSrvConclusion = cmn.wu.GET_ANSW(BID_ID, lst0[0].QUESTION_ID, lst[0].WS_ID, 0);
            }
        }

        return "Висновок: " + CrdSrvConclusion;
    }
    private String GetCCConclusion(BbConnection con, Decimal? BID_ID)
    {
        Common cmn = new Common(con, BID_ID);
        String CCConclusion = String.Empty;

        List<VWcsCrdsrvBidInfoqueriesRecord> lst = (new VWcsCrdsrvBidInfoqueries(con)).SelectCrdsrvBidInfoquery(BID_ID, Master.SRV_HIERARCHY, "IQ_CONCL_CREDIT_S");
        String WS_ID = (lst.Count > 0 ? lst[0].WS_ID : "MAIN");

        if (cmn.wu.HAS_ANSW(BID_ID, "IQ_CC_DECISION_Q1", WS_ID, 0) == 1 &&
                        cmn.wu.HAS_ANSW(BID_ID, "IQ_CC_DECISION_Q2", WS_ID, 0) == 1 &&
                        cmn.wu.HAS_ANSW(BID_ID, "IQ_CC_DECISION_Q3", WS_ID, 0) == 1)
        {
            DateTime? IQ_CC_DECISION_Q1 = cmn.wu.GET_ANSW_DATE(BID_ID, "IQ_CC_DECISION_Q1", WS_ID, 0);
            String IQ_CC_DECISION_Q2 = cmn.wu.GET_ANSW_TEXT(BID_ID, "IQ_CC_DECISION_Q2", WS_ID, 0);
            String IQ_CC_DECISION_Q3 = cmn.wu.GET_ANSW_LIST_TEXT(BID_ID, "IQ_CC_DECISION_Q3", WS_ID, 0);
            String IQ_CC_DECISION_Q4 = cmn.wu.GET_ANSW_TEXT(BID_ID, "IQ_CC_DECISION_Q4", WS_ID, 0);

            CCConclusion = String.Format("Рішення №{0} від {1:dd/MM/yyyy}: {2}; {3}", IQ_CC_DECISION_Q2, IQ_CC_DECISION_Q1, IQ_CC_DECISION_Q3, IQ_CC_DECISION_Q4);
        }

        return CCConclusion;
    }
    private void FinishCurrentCreditS(Common cmn, String SRV_HIERARCHY, Decimal? BID_ID)
    {
        switch (SRV_HIERARCHY)
        {
            case "TOBO":
                cmn.wp.BID_STATE_CHECK_IN(BID_ID, "NEW_CREDIT_S", (String)null);
                cmn.wp.BID_STATE_DEL(BID_ID, "NEW_CREDIT_S");
                break;
            case "RU":
                cmn.wp.BID_STATE_CHECK_IN(BID_ID, "NEW_RU_CREDIT_S", (String)null);
                cmn.wp.BID_STATE_DEL(BID_ID, "NEW_RU_CREDIT_S");
                break;
            case "CA":
                cmn.wp.BID_STATE_CHECK_IN(BID_ID, "NEW_CA_CREDIT_S", (String)null);
                cmn.wp.BID_STATE_DEL(BID_ID, "NEW_CA_CREDIT_S");
                break;
        }
    }
    private void FinishCurrentCreditSCCAnalyse(Common cmn, String SRV_HIERARCHY, Decimal? BID_ID)
    {
        // завершаем состояние Кредитна служба - аналіз рішення КК
        switch (SRV_HIERARCHY)
        {
            case "TOBO":
                cmn.wp.BID_STATE_CHECK_IN(BID_ID, "NEW_CREDIT_S_CCANALYSE", (String)null);
                cmn.wp.BID_STATE_DEL(BID_ID, "NEW_CREDIT_S_CCANALYSE");
                break;
            case "RU":
                cmn.wp.BID_STATE_CHECK_IN(BID_ID, "NEW_RU_CREDIT_S_CCANALYSE", (String)null);
                cmn.wp.BID_STATE_DEL(BID_ID, "NEW_RU_CREDIT_S_CCANALYSE");
                break;
            case "CA":
                cmn.wp.BID_STATE_CHECK_IN(BID_ID, "NEW_CA_CREDIT_S_CCANALYSE", (String)null);
                cmn.wp.BID_STATE_DEL(BID_ID, "NEW_CA_CREDIT_S_CCANALYSE");
                break;
        }
    }
    private void FinishWithHLAnalyse(BbConnection con, Common cmn, String SRV_HIERARCHY, Decimal? BID_ID)
    {
        // принятие с расмотрением на высшем уровне
        switch (SRV_HIERARCHY)
        {
            case "TOBO":
                cmn.wp.BID_STATE_SET(BID_ID, "NEW_RU_CREDIT_S", GetCCConclusion(con, BID_ID));
                break;
            case "RU":
                cmn.wp.BID_STATE_SET(BID_ID, "NEW_CA_CREDIT_S", GetCCConclusion(con, BID_ID));
                break;
            default:
                cmn.wp.BID_STATE_SET(BID_ID, "NEW_REGISTRATION", (String)null);
                break;
        }
    }
    private void FinishWithAnalysedLimit(BbConnection con, Common cmn, Decimal? SumLimit, Decimal? SUMM, String SRV_HIERARCHY, Decimal? BID_ID)
    {
        // проверяем нарушение лимита и вслучае чего оправляем на уровень вверх
        if (SumLimit < SUMM)
        {
            # region Лимит принятия решения НАРУШЕН
            FinishWithHLAnalyse(con, cmn, SRV_HIERARCHY, BID_ID);
            # endregion
        }
        else
        {
            # region Лимит принятия решения НЕ НАРУШЕН
            cmn.wp.BID_STATE_SET(BID_ID, "NEW_REGISTRATION", (String)null);
            # endregion
        }
    }
    # endregion
}