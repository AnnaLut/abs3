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

using Bars.Classes;
using ibank.core;

public partial class credit_crdsrv_process : Bars.BarsPage
{
    # region Приватные свойства
    public String SRV_HIERARCHY
    {
        get
        {
            return Convert.ToString(Request.Params.Get("srvhr"));
        }
    }
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
        // заголовок
        Master.SetPageTitle(String.Format(this.Title, Convert.ToString(BID_ID)), true);
    }
    protected void fv_ItemCreated(object sender, EventArgs e)
    {
        String IQUERY_ID = (String)gv.SelectedDataKey["IQUERY_ID"];
        String WS_ID = (String)gv.SelectedDataKey["WS_ID"];
        Control ph = fv.FindControl("ph");

        if (!String.IsNullOrEmpty(IQUERY_ID))
        {
            BbConnection con = new BbConnection();
            try
            {
                // создаем контролы
                GenerateControls(con, BID_ID, IQUERY_ID, WS_ID, ph);
            }
            finally
            {
                con.CloseConnection();
            }
        }
    }
    protected void fv_PreRender(object sender, EventArgs e)
    {
        String IQUERY_ID = (String)gv.SelectedDataKey["IQUERY_ID"];
        String WS_ID = (String)gv.SelectedDataKey["WS_ID"];
        Control ph = fv.FindControl("ph");

        if (!String.IsNullOrEmpty(IQUERY_ID))
        {
            BbConnection con = new BbConnection();
            try
            {
                // заполняем данные
                FillData(con, BID_ID, IQUERY_ID, WS_ID, ph);
            }
            finally
            {
                con.CloseConnection();
            }
        }
    }
    protected void fv_ItemCommand(object sender, FormViewCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "Finish":
        String IQUERY_ID = (String)gv.SelectedDataKey["IQUERY_ID"];
        String WS_ID = (String)gv.SelectedDataKey["WS_ID"];
                PlaceHolder ph = (fv.FindControl("ph") as PlaceHolder);

                BbConnection con = new BbConnection();
                Common cmn = new Common(con, BID_ID);

                // сохраняем ответы
                SaveData(con, BID_ID, IQUERY_ID, WS_ID, ph);

                // завершаем запрос
                cmn.wu.STOP_IQUERY(BID_ID, IQUERY_ID, WS_ID, "DONE");

                // перезагрузка грида
                gv.DataBind();

                // если все заполнено то переходим в карточку
                List<VWcsCrdsrvBidInfoqueriesRecord> lst = (new VWcsCrdsrvBidInfoqueries(con)).SelectCrdsrvBidInfoqueries(BID_ID, SRV_HIERARCHY);
                Int32 cnt = lst.Count;

                foreach (VWcsCrdsrvBidInfoqueriesRecord rec in lst)
                    if (rec.STATUS == 2)
                        cnt--;

                if (cnt == 0)
                    Response.Redirect(String.Format("/barsroot/credit/crdsrv/bid_card.aspx?srvhr={0}&bid_id={1}", SRV_HIERARCHY, BID_ID.ToString()));

                break;
        }
    }
    # endregion

    # region Приватные методы
    private void GenerateControls(BbConnection con, Decimal? BID_ID, String IQUERY_ID, String WS_ID, Control Container)
    {
        Common cmn = new Common(con, BID_ID);

        // контейнер вопросов
        Trace.Write("containerTable = " + Container.FindControl("containerTable"));
        HtmlTable ht = (Container.FindControl("containerTable") as HtmlTable);
        if (ht != null) Container.Controls.Remove(ht);

        ht = new HtmlTable();
        ht.ID = "containerTable";

        ht.Border = 0;
        ht.CellPadding = 0;
        ht.CellSpacing = 0;

        ht.Width = "99%";

        Container.Controls.Add(ht);

        // вопросы
        List<VWcsBidInfoqueryQuestionsRecord> ssqRecords = (new VWcsBidInfoqueryQuestions(con)).SelectBidInfoqueryQuestions(BID_ID, IQUERY_ID);
        foreach (VWcsBidInfoqueryQuestionsRecord ssqRecord in ssqRecords)
        {
            // строчка вопроса
            HtmlTableRow htr = new HtmlTableRow();
            htr.ID = "htr_" + ssqRecord.QUESTION_ID;

            HtmlTableCell htcTitle = new HtmlTableCell("td");
            htcTitle.Attributes.Add("class", "questionTitle");
            htcTitle.InnerText = ssqRecord.QUESTION_NAME + " : ";

            HtmlTableCell htcControl = new HtmlTableCell();
            htcControl.Attributes.Add("class", "questionValue");

            htr.Cells.Add(htcTitle);
            htr.Cells.Add(htcControl);
            ht.Rows.Add(htr);

            // параметры вопроса
            Decimal? TEXT_LENG_MIN = (Decimal?)null;
            Decimal? TEXT_LENG_MAX = (Decimal?)null;
            String TEXT_VAL_DEFAULT = (String)null;
            Decimal? TEXT_WIDTH = (Decimal?)null;
            Decimal? TEXT_ROWS = (Decimal?)null;
            Decimal? NMBDEC_VAL_MIN = (Decimal?)null;
            Decimal? NMBDEC_VAL_MAX = (Decimal?)null;
            Decimal? NMBDEC_VAL_DEFAULT = (Decimal?)null;
            DateTime? DAT_VAL_MIN = (DateTime?)null;
            DateTime? DAT_VAL_MAX = (DateTime?)null;
            DateTime? DAT_VAL_DEFAULT = (DateTime?)null;
            Decimal? LIST_SID_DEFAULT = (Decimal?)null;
            String REFER_SID_DEFAULT = (String)null;
            Decimal? TAB_ID = (Decimal?)null;
            String KEY_FIELD = (String)null;
            String SEMANTIC_FIELD = (String)null;
            String SHOW_FIELDS = (String)null;
            String WHERE_CLAUSE = (String)null;
            Decimal? BOOL_VAL_DEFAULT = (Decimal?)null;

            cmn.wu.GET_QUEST_PARAMS(BID_ID, ssqRecord.QUESTION_ID, out TEXT_LENG_MIN, out TEXT_LENG_MAX, out TEXT_VAL_DEFAULT, out TEXT_WIDTH, out TEXT_ROWS, out NMBDEC_VAL_MIN, out NMBDEC_VAL_MAX, out NMBDEC_VAL_DEFAULT, out DAT_VAL_MIN, out DAT_VAL_MAX, out DAT_VAL_DEFAULT, out LIST_SID_DEFAULT, out REFER_SID_DEFAULT, out TAB_ID, out KEY_FIELD, out SEMANTIC_FIELD, out SHOW_FIELDS, out WHERE_CLAUSE, out BOOL_VAL_DEFAULT, WS_ID, 0);

            // создаем контрол
            UserControl uc = new UserControl();

            # region Switch TYPE_ID
            switch (ssqRecord.TYPE_ID)
            {
                case "TEXT":
                    # region TEXT
                    uc = (UserControl)Page.LoadControl("~/credit/usercontrols/TextBoxString.ascx");

                    TextBoxString TEXT = (TextBoxString)uc;
                    TEXT.ID = ssqRecord.QUESTION_ID;
                    TEXT.IsRequired = (ssqRecord.IS_REQUIRED == 1);
                    TEXT.ReadOnly = (ssqRecord.IS_CALCABLE == 0 ? false : true);

                    TEXT.MinLength = (TEXT_LENG_MIN == null ? TEXT.MinLength : Convert.ToInt32(TEXT_LENG_MIN));
                    TEXT.MaxLength = (TEXT_LENG_MAX == null ? TEXT.MaxLength : Convert.ToInt32(TEXT_LENG_MAX));
                    TEXT.Width = (TEXT_WIDTH == null ? TEXT.Width : Convert.ToInt32(TEXT_WIDTH));
                    TEXT.Rows = (TEXT_ROWS == null ? TEXT.Rows : Convert.ToInt32(TEXT_ROWS));
                    # endregion

                    break;
                case "NUMB":
                    # region NUMB
                    uc = (UserControl)Page.LoadControl("~/credit/usercontrols/TextBoxNumb.ascx");

                    TextBoxNumb NUMB = (TextBoxNumb)uc;
                    NUMB.ID = ssqRecord.QUESTION_ID;
                    NUMB.IsRequired = (ssqRecord.IS_REQUIRED == 1);
                    NUMB.ReadOnly = (ssqRecord.IS_CALCABLE == 0 ? false : true);

                    NUMB.MinValue = (NMBDEC_VAL_MIN == null ? NUMB.MinValue : Convert.ToInt32(NMBDEC_VAL_MIN));
                    NUMB.MaxValue = (NMBDEC_VAL_MAX == null ? NUMB.MaxValue : Convert.ToInt32(NMBDEC_VAL_MAX));
                    # endregion

                    break;
                case "DECIMAL":
                    # region DECIMAL
                    uc = (UserControl)Page.LoadControl("~/credit/usercontrols/TextBoxDecimal.ascx");

                    TextBoxDecimal DECIMAL = (TextBoxDecimal)uc;
                    DECIMAL.ID = ssqRecord.QUESTION_ID;
                    DECIMAL.IsRequired = (ssqRecord.IS_REQUIRED == 1);
                    DECIMAL.ReadOnly = (ssqRecord.IS_CALCABLE == 0 ? false : true);

                    DECIMAL.MinValue = (NMBDEC_VAL_MIN == null ? DECIMAL.MinValue : NMBDEC_VAL_MIN);
                    DECIMAL.MaxValue = (NMBDEC_VAL_MAX == null ? DECIMAL.MaxValue : NMBDEC_VAL_MAX);
                    # endregion

                    break;
                case "DATE":
                    # region DATE
                    uc = (UserControl)Page.LoadControl("~/credit/usercontrols/TextBoxDate.ascx");

                    TextBoxDate DATE = (TextBoxDate)uc;
                    DATE.ID = ssqRecord.QUESTION_ID;
                    DATE.IsRequired = (ssqRecord.IS_REQUIRED == 1);
                    DATE.ReadOnly = (ssqRecord.IS_CALCABLE == 0 ? false : true);

                    DATE.MinValue = (DAT_VAL_MIN == null ? DATE.MinValue : DAT_VAL_MIN.Value);
                    DATE.MaxValue = (DAT_VAL_MAX == null ? DATE.MaxValue : DAT_VAL_MAX.Value);
                    # endregion

                    break;
                case "LIST":
                    # region LIST
                    uc = (UserControl)Page.LoadControl("~/credit/usercontrols/DDLList.ascx");

                    DDLList LIST = (DDLList)uc;
                    LIST.ID = ssqRecord.QUESTION_ID;
                    LIST.IsRequired = (ssqRecord.IS_REQUIRED == 1);
                    LIST.ReadOnly = (ssqRecord.IS_CALCABLE == 0 ? false : true);

                    LIST.DataValueField = "ORD";
                    LIST.DataTextField = "TEXT";

                    List<VWcsQuestionListItemsRecord> qliRecords = (new VWcsQuestionListItems(con)).SelectQuestionListItems(ssqRecord.QUESTION_ID);
                    LIST.DataSource = qliRecords;
                    LIST.DataBind();
                    # endregion

                    break;
                case "REFER":
                    # region REFER
                    uc = (UserControl)Page.LoadControl("~/credit/usercontrols/TextBoxRefer.ascx");

                    TextBoxRefer REFER = (TextBoxRefer)uc;
                    REFER.ID = ssqRecord.QUESTION_ID;
                    REFER.BID_ID = BID_ID;
                    REFER.QUESTION_ID = ssqRecord.QUESTION_ID;
                    REFER.IsRequired = (ssqRecord.IS_REQUIRED == 1);
                    REFER.ReadOnly = (ssqRecord.IS_CALCABLE == 0 ? false : true);
                    # endregion

                    break;
                case "BOOL":
                    # region BOOL
                    uc = (UserControl)Page.LoadControl("~/credit/usercontrols/RBLFlag.ascx");

                    RBLFlag BOOL = (RBLFlag)uc;
                    BOOL.ID = ssqRecord.QUESTION_ID;
                    BOOL.IsRequired = (ssqRecord.IS_REQUIRED == 1);
                    BOOL.ReadOnly = (ssqRecord.IS_CALCABLE == 0 ? false : true);

                    BOOL.DefaultValue = (!BOOL_VAL_DEFAULT.HasValue ? BOOL.DefaultValue : (BOOL_VAL_DEFAULT.Value == 0 ? false : true));
                    # endregion

                    break;
            }
            # endregion

            // дабавляем в контейнер
            Trace.Write("uc Added " + uc);
            htcControl.Controls.Add(uc);
        }
    }
    private void FillData(BbConnection con, Decimal? BID_ID, String IQUERY_ID, String WS_ID, Control Container)
    {
        Common cmn = new Common(con, BID_ID);

        // вопросы
        List<VWcsBidInfoqueryQuestionsRecord> ssqRecords = (new VWcsBidInfoqueryQuestions(con)).SelectBidInfoqueryQuestions(BID_ID, IQUERY_ID);
        foreach (VWcsBidInfoqueryQuestionsRecord ssqRecord in ssqRecords)
        {
            // параметры вопроса
            Decimal? TEXT_LENG_MIN = (Decimal?)null;
            Decimal? TEXT_LENG_MAX = (Decimal?)null;
            String TEXT_VAL_DEFAULT = (String)null;
            Decimal? TEXT_WIDTH = (Decimal?)null;
            Decimal? TEXT_ROWS = (Decimal?)null;
            Decimal? NMBDEC_VAL_MIN = (Decimal?)null;
            Decimal? NMBDEC_VAL_MAX = (Decimal?)null;
            Decimal? NMBDEC_VAL_DEFAULT = (Decimal?)null;
            DateTime? DAT_VAL_MIN = (DateTime?)null;
            DateTime? DAT_VAL_MAX = (DateTime?)null;
            DateTime? DAT_VAL_DEFAULT = (DateTime?)null;
            Decimal? LIST_SID_DEFAULT = (Decimal?)null;
            String REFER_SID_DEFAULT = (String)null;
            Decimal? TAB_ID = (Decimal?)null;
            String KEY_FIELD = (String)null;
            String SEMANTIC_FIELD = (String)null;
            String SHOW_FIELDS = (String)null;
            String WHERE_CLAUSE = (String)null;
            Decimal? BOOL_VAL_DEFAULT = (Decimal?)null;

            cmn.wu.GET_QUEST_PARAMS(BID_ID, ssqRecord.QUESTION_ID, out TEXT_LENG_MIN, out TEXT_LENG_MAX, out TEXT_VAL_DEFAULT, out TEXT_WIDTH, out TEXT_ROWS, out NMBDEC_VAL_MIN, out NMBDEC_VAL_MAX, out NMBDEC_VAL_DEFAULT, out DAT_VAL_MIN, out DAT_VAL_MAX, out DAT_VAL_DEFAULT, out LIST_SID_DEFAULT, out REFER_SID_DEFAULT, out TAB_ID, out KEY_FIELD, out SEMANTIC_FIELD, out SHOW_FIELDS, out WHERE_CLAUSE, out BOOL_VAL_DEFAULT, WS_ID, 0);

            // если вопрос вычисляемый, то вычисляем его
            if (ssqRecord.IS_CALCABLE == 1) cmn.wu.CALC_ANSW(BID_ID, ssqRecord.QUESTION_ID, WS_ID, 0);
            Decimal? HasAnsw = cmn.wu.HAS_ANSW(BID_ID, ssqRecord.QUESTION_ID, WS_ID, 0);

            // контрол
            UserControl uc = (Container.FindControl(ssqRecord.QUESTION_ID) as UserControl);
            Trace.Write("uc = " + uc);
            # region Switch TYPE_ID
            switch (ssqRecord.TYPE_ID)
            {
                case "TEXT":
                    # region TEXT
                    TextBoxString TEXT = (TextBoxString)uc;

                    if (HasAnsw == 1) TEXT.Value = cmn.wu.GET_ANSW_TEXT(BID_ID, ssqRecord.QUESTION_ID, WS_ID, 0);
                    else TEXT.Value = TEXT_VAL_DEFAULT;
                    # endregion

                    break;
                case "NUMB":
                    # region NUMB
                    TextBoxNumb NUMB = (TextBoxNumb)uc;

                    if (HasAnsw == 1) NUMB.Value = cmn.wu.GET_ANSW_NUMB(BID_ID, ssqRecord.QUESTION_ID, WS_ID, 0);
                    else NUMB.Value = NMBDEC_VAL_DEFAULT;
                    # endregion

                    break;
                case "DECIMAL":
                    # region DECIMAL
                    TextBoxDecimal DECIMAL = (TextBoxDecimal)uc;

                    if (HasAnsw == 1) DECIMAL.Value = cmn.wu.GET_ANSW_DECIMAL(BID_ID, ssqRecord.QUESTION_ID, WS_ID, 0);
                    else DECIMAL.Value = NMBDEC_VAL_DEFAULT;
                    # endregion

                    break;
                case "DATE":
                    # region DATE
                    TextBoxDate DATE = (TextBoxDate)uc;

                    if (HasAnsw == 1) DATE.Value = cmn.wu.GET_ANSW_DATE(BID_ID, ssqRecord.QUESTION_ID, WS_ID, 0);
                    else DATE.Value = DAT_VAL_DEFAULT;
                    # endregion

                    break;
                case "LIST":
                    # region LIST
                    DDLList LIST = (DDLList)uc;

                    if (HasAnsw == 1) LIST.Value = cmn.wu.GET_ANSW_LIST(BID_ID, ssqRecord.QUESTION_ID, WS_ID, 0);
                    else LIST.Value = LIST_SID_DEFAULT;
                    # endregion

                    break;
                case "REFER":
                    # region REFER
                    TextBoxRefer REFER = (TextBoxRefer)uc;

                    if (HasAnsw == 1) REFER.Value = cmn.wu.GET_ANSW_REFER(BID_ID, ssqRecord.QUESTION_ID, WS_ID, 0);
                    else REFER.Value = REFER_SID_DEFAULT;
                    # endregion

                    break;
                case "BOOL":
                    # region BOOL
                    RBLFlag BOOL = (RBLFlag)uc;

                    if (HasAnsw == 1) BOOL.Value = cmn.wu.GET_ANSW_BOOL(BID_ID, ssqRecord.QUESTION_ID, WS_ID, 0);
                    else BOOL.Value = BOOL_VAL_DEFAULT;
                    # endregion

                    break;
            }
            # endregion
        }
    }
    private Boolean SaveData(BbConnection con, Decimal? BID_ID, String IQUERY_ID, String WS_ID, Control Container)
    {
        Common cmn = new Common(con, BID_ID);

        // проверки
        Boolean GlobalCheckResult = true;
        Master.HideError();

        // вопросы группы
        List<VWcsBidInfoqueryQuestionsRecord> ssqRecords = (new VWcsBidInfoqueryQuestions(con)).SelectBidInfoqueryQuestions(BID_ID, IQUERY_ID);
        foreach (VWcsBidInfoqueryQuestionsRecord ssqRecord in ssqRecords)
        {
            // если вопрос вычисляемый, то вычисляем его
            if (ssqRecord.IS_CALCABLE == 1)
            {
                cmn.wu.CALC_ANSW(BID_ID, ssqRecord.QUESTION_ID, WS_ID, 0);
            }

            // контрол
            UserControl uc = (Container.FindControl(ssqRecord.QUESTION_ID) as UserControl);

            # region Switch TYPE_ID
            switch (ssqRecord.TYPE_ID)
            {
                case "TEXT":
                    # region TEXT
                    TextBoxString TEXT = (TextBoxString)uc;
                    cmn.wp.ANSW_TEXT_SET(BID_ID, ssqRecord.QUESTION_ID, TEXT.Value, WS_ID, 0);
                    # endregion

                    break;
                case "NUMB":
                    # region NUMB
                    TextBoxNumb NUMB = (TextBoxNumb)uc;
                    cmn.wp.ANSW_NUMB_SET(BID_ID, ssqRecord.QUESTION_ID, NUMB.Value, WS_ID, 0);
                    # endregion

                    break;
                case "DECIMAL":
                    # region DECIMAL
                    TextBoxDecimal DECIMAL = (TextBoxDecimal)uc;
                    cmn.wp.ANSW_DEC_SET(BID_ID, ssqRecord.QUESTION_ID, DECIMAL.Value, WS_ID, 0);
                    # endregion

                    break;
                case "DATE":
                    # region DATE
                    TextBoxDate DATE = (TextBoxDate)uc;
                    cmn.wp.ANSW_DAT_SET(BID_ID, ssqRecord.QUESTION_ID, DATE.Value, WS_ID, 0);
                    # endregion

                    break;
                case "LIST":
                    # region LIST
                    DDLList LIST = (DDLList)uc;
                    cmn.wp.ANSW_LIST_SET(BID_ID, ssqRecord.QUESTION_ID, LIST.Value, WS_ID, 0);
                    # endregion

                    break;
                case "REFER":
                    # region REFER
                    TextBoxRefer REFER = (TextBoxRefer)uc;
                    cmn.wp.ANSW_REF_SET(BID_ID, ssqRecord.QUESTION_ID, REFER.Value, WS_ID, 0);
                    # endregion

                    break;
                case "BOOL":
                    # region BOOL
                    RBLFlag BOOL = (RBLFlag)uc;
                    cmn.wp.ANSW_BOOL_SET(BID_ID, ssqRecord.QUESTION_ID, BOOL.Value, WS_ID, 0);
                    # endregion

                    break;
            }
            # endregion

            // проверочная фукнция
            if (ssqRecord.IS_CHECKABLE == 1)
            {
                String CheckResult = cmn.wu.EXEC_CHECK(BID_ID, ssqRecord.CHECK_PROC, WS_ID, 0);
                if (CheckResult != null)
                {
                    Master.ShowError(String.Format(Resources.credit.StringConstants.text_question_check_error_ptrn, ssqRecord.QUESTION_ID, ssqRecord.QUESTION_NAME, CheckResult));
                    GlobalCheckResult = false;
                }
            }
        }

        if (!GlobalCheckResult)
        {
            return false;
        }

        return true;
    }
    # endregion
}