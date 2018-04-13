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

using System.Collections.Generic;
using credit;
using Bars.UserControls;
using System.Drawing;

using Bars.Classes;
using ibank.core;

public partial class credit_secretarycc_queries : Bars.BarsPage
{
    # region Публичные свойства
    public String SRV_HIERARCHY
    {
        get
        {
            return Convert.ToString(Request.Params.Get("srvhr"));
        }
    }
    public List<Decimal?> BID_IDs
    {
        get
        {
            List<Decimal?> res = new List<Decimal?>();

            foreach (GridViewRow row in gv.Rows)
            {
                CheckBox cb = row.FindControl("cb") as CheckBox;
                if (cb.Checked)
                    res.Add((Decimal?)gv.DataKeys[row.DataItemIndex]["BID_ID"]);
            }

            return res;
        }
    }
    public String strBID_IDs
    {
        get
        {
            String res = String.Empty;

            foreach (Decimal? BID_ID in BID_IDs)
                res += "," + Convert.ToString(BID_ID);

            return res.StartsWith(",") ? res.Substring(1) : res;
        }
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        gv.DataBind();
    }
    protected void lbPROCCESS_Click(object sender, EventArgs e)
    {
        // проверки
        Master.HideError();

        // выбраны ли заявки
        if (BID_IDs.Count == 0)
        {
            Master.ShowError(Resources.credit.StringConstants.text_no_bids_selected);
            return;
        }

        // смотрим чтоб был один субпродукт
        List<VWcsBidsRecord> lst = (new VWcsBids()).SelectBids(BID_IDs);
        for (int i = 1; i < lst.Count; i++)
            if (lst[i - 1].SUBPRODUCT_ID != lst[i].SUBPRODUCT_ID)
            {
                Master.ShowError(Resources.credit.StringConstants.text_selected_bids_have_diff_sbps);
                return;
            }

        // конвертируем
        Response.Redirect(String.Format("/barsroot/credit/secretarycc/process_multi.aspx?srvhr={0}&bid_ids={1}", SRV_HIERARCHY.ToUpper(), strBID_IDs));
    }
    protected void lbDOCS_Click(object sender, EventArgs e)
    {
        // проверки
        Master.HideError();

        // выбраны ли заявки
        if (BID_IDs.Count == 0)
        {
            Master.ShowError(Resources.credit.StringConstants.text_no_bids_selected);
            return;
        }

        // смотрим чтоб был один субпродукт
        List<VWcsBidsRecord> lst = (new VWcsBids()).SelectBids(BID_IDs);
        for (int i = 1; i < lst.Count; i++)
            if (lst[i - 1].SUBPRODUCT_ID != lst[i].SUBPRODUCT_ID)
            {
                Master.ShowError(Resources.credit.StringConstants.text_selected_bids_have_diff_sbps);
                return;
            }

        // конвертируем
        Response.Redirect(String.Format("/barsroot/credit/secretarycc/printdocs_multi.aspx?srvhr={0}&bid_ids={1}", SRV_HIERARCHY.ToUpper(), strBID_IDs));
    }

    protected void lbFinish_Click(object sender, EventArgs e)
    {
        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        // проверки
        if (!Validate(con, BID_IDs)) return;

        // завершаем состояние ... служба - обробка заявки, если все запросы обработаны
        foreach (Decimal? BID_ID in BID_IDs)
        {
            switch (SRV_HIERARCHY.ToUpper())
            {
                case "TOBO":
                    cmn.wp.BID_STATE_CHECK_IN(BID_ID, "NEW_SECRETARYCC", GetCCConclusion(con, BID_ID));
                    cmn.wp.BID_STATE_DEL(BID_ID, "NEW_SECRETARYCC");
                    break;
                case "RU":
                    cmn.wp.BID_STATE_CHECK_IN(BID_ID, "NEW_RU_SECRETARYCC", GetCCConclusion(con, BID_ID));
                    cmn.wp.BID_STATE_DEL(BID_ID, "NEW_RU_SECRETARYCC");
                    break;
                case "CA":
                    cmn.wp.BID_STATE_CHECK_IN(BID_ID, "NEW_CA_SECRETARYCC", GetCCConclusion(con, BID_ID));
                    cmn.wp.BID_STATE_DEL(BID_ID, "NEW_CA_SECRETARYCC");
                    break;
            }
        }

        // делаем рефреш грида
        gv.DataBind();
    }

    protected void cbAll_CheckedChanged(object sender, EventArgs e)
    {
        Boolean chkd = (sender as CheckBox).Checked;

        foreach (GridViewRow row in gv.Rows)
        {
            CheckBox cb = row.FindControl("cb") as CheckBox;
            cb.Checked = chkd;
        }
    }
    # endregion

    # region Приватные методы
    private Boolean Validate(BbConnection con, List<Decimal?> BID_IDs)
    {
        // проверки
        Master.HideError();

        foreach (Decimal? BID_ID in BID_IDs)
        {
            Common cmn = new Common(con, BID_ID);

            // вопросы группы
            List<VWcsCcBidInfoqueriesRecord> lst = (new VWcsCcBidInfoqueries(con)).SelectCcBidInfoqueries(BID_ID, SRV_HIERARCHY);
            foreach (VWcsCcBidInfoqueriesRecord rec in lst)
            {
                // проверяем что обязательный запрос обработан
                if (1 == rec.IS_REQUIRED && (2 != rec.STATUS || !rec.STATUS.HasValue))
                {
                    Master.ShowError(String.Format(Resources.credit.StringConstants.text_bid_incomplete_iquery, BID_ID, rec.IQUERY_ID, rec.IQUERY_NAME));
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
                    Master.ShowError(String.Format(Resources.credit.StringConstants.text_bid_unscaned_document, BID_ID, rec.TEMPLATE_ID, rec.TEMPLATE_NAME));
                    return false;
                }
            }
        }

        return true;
    }
    private String GetCCConclusion(BbConnection con, Decimal? BID_ID)
    {
        Common cmn = new Common(con, BID_ID);
        String CCConclusion = String.Empty;

        List<VWcsCcBidInfoqueriesRecord> lst = (new VWcsCcBidInfoqueries(con)).SelectCcBidInfoqueries(BID_ID, SRV_HIERARCHY);
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