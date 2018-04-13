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

public partial class credit_manager_auth : Bars.BarsPage
{
    # region Приватные свойства
    private Boolean _IsDataSaved = false;
    private Boolean _SaveResult = false;
    private Boolean _IsDataFilled = false;
    private Boolean _IsValuesChangedEvent = false;

    private Decimal? BID_ID
    {
        get
        {
            return Convert.ToDecimal(Request.Params.Get("bid_id"));
        }
    }
    # endregion

    # region Публичные свойства
    public Boolean IsDataSaved
    {
        get { return _IsDataSaved; }
        set { _IsDataSaved = value; }
    }
    public Boolean SaveResult
    {
        get { return _SaveResult; }
        set { _SaveResult = value; }
    }
    public Boolean IsDataFilled
    {
        get { return _IsDataFilled; }
        set { _IsDataFilled = value; }
    }
    public Boolean IsValuesChangedEvent
    {
        get { return _IsValuesChangedEvent; }
        set { _IsValuesChangedEvent = value; }
    }
    # endregion

    # region События
    protected override void OnInit(EventArgs e)
    {
        // чистим сессию при входе
        if (!IsPostBack)
        {
            Master.ClearSessionScans();
        }

        base.OnInit(e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        // заголовок
        Master.SetPageTitle(String.Format(this.Title, Convert.ToString(BID_ID)), true);

        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        try
        {
            // чекаут состояния
            cmn.wp.BID_STATE_CHECK_OUT(BID_ID, "NEW_AUTH", (String)null);

            // создаем контролы
            GenerateControls(con, BID_ID, tdContainer);
        }
        finally
        {
            con.CloseConnection();
        }
    }
    protected void bNext_Click(object sender, EventArgs e)
    {
        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        try
        {
            // если ошибки при сохранении
            if (!SaveData(con, BID_ID, tdContainer)) return;

            // чекин состояния
            cmn.wp.BID_STATE_CHECK_IN(BID_ID, "NEW_AUTH", (String)null);

            // завершаем состояние и переходим на след
            cmn.wp.BID_STATE_DEL(BID_ID, "NEW_AUTH");

            // чистим сессию при выходе
            Master.ClearSessionScans();

            // возвращаемся в карточку заявки
            Response.Redirect(String.Format("/barsroot/credit/manager/bid_card.aspx?bid_id={0}", BID_ID.ToString()));
        }
        finally
        {
            con.CloseConnection();
        }
    }
    protected override void OnPreRender(EventArgs e)
    {
        BbConnection con = new BbConnection();

        try
        {
            // заполняем данные
            FillData(con, BID_ID, tdContainer);
        }
        finally
        {
            con.CloseConnection();
        }

        base.OnPreRender(e);
    }
    # endregion

    # region Приватные методы
    private void GenerateControls(BbConnection con, Decimal? BID_ID, Control Container)
    {
        Common cmn = new Common(con);

        // контейнер вопросов
        HtmlTable ht = new HtmlTable();
        ht.Border = 0;
        ht.CellPadding = 0;
        ht.CellSpacing = 0;
        Container.Controls.Add(ht);

        // вопросы
        List<VWcsBidAuthsQuestsRecord> recs = (new VWcsBidAuthsQuests(con)).SelectBidAuthsQuests(BID_ID);
        foreach (VWcsBidAuthsQuestsRecord rec in recs)
        {
            // строчка вопроса
            HtmlTableRow htr = new HtmlTableRow();

            HtmlTableCell htcTitle = new HtmlTableCell("td");
            htcTitle.Attributes.Add("class", "questionTitle");
            htcTitle.InnerText = rec.QUESTION_NAME + " : ";

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

            cmn.wu.GET_QUEST_PARAMS(BID_ID, rec.QUESTION_ID, out TEXT_LENG_MIN, out TEXT_LENG_MAX, out TEXT_VAL_DEFAULT, out TEXT_WIDTH, out TEXT_ROWS, out NMBDEC_VAL_MIN, out NMBDEC_VAL_MAX, out NMBDEC_VAL_DEFAULT, out DAT_VAL_MIN, out DAT_VAL_MAX, out DAT_VAL_DEFAULT, out LIST_SID_DEFAULT, out REFER_SID_DEFAULT, out TAB_ID, out KEY_FIELD, out SEMANTIC_FIELD, out SHOW_FIELDS, out WHERE_CLAUSE, out BOOL_VAL_DEFAULT);

            // создаем контрол
            UserControl uc = new UserControl();

            # region Switch TYPE_ID
            switch (rec.TYPE_ID)
            {
                case "TEXT":
                    # region TEXT
                    uc = (UserControl)Page.LoadControl("~/credit/usercontrols/TextBoxString.ascx");

                    TextBoxString TEXT = (TextBoxString)uc;
                    TEXT.ID = rec.QUESTION_ID;
                    TEXT.IsRequired = (rec.IS_REQUIRED == 0 ? false : true);
                    TEXT.ReadOnly = (rec.IS_CALCABLE == 0 ? false : true);

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
                    NUMB.ID = rec.QUESTION_ID;
                    NUMB.IsRequired = (rec.IS_REQUIRED == 0 ? false : true);
                    NUMB.ReadOnly = (rec.IS_CALCABLE == 0 ? false : true);

                    NUMB.MinValue = (NMBDEC_VAL_MIN == null ? NUMB.MinValue : Convert.ToInt32(NMBDEC_VAL_MIN));
                    NUMB.MaxValue = (NMBDEC_VAL_MAX == null ? NUMB.MaxValue : Convert.ToInt32(NMBDEC_VAL_MAX));
                    # endregion

                    break;
                case "DECIMAL":
                    # region DECIMAL
                    uc = (UserControl)Page.LoadControl("~/credit/usercontrols/TextBoxDecimal.ascx");

                    TextBoxDecimal DECIMAL = (TextBoxDecimal)uc;
                    DECIMAL.ID = rec.QUESTION_ID;
                    DECIMAL.IsRequired = (rec.IS_REQUIRED == 0 ? false : true);
                    DECIMAL.ReadOnly = (rec.IS_CALCABLE == 0 ? false : true);

                    DECIMAL.MinValue = (NMBDEC_VAL_MIN == null ? DECIMAL.MinValue : Convert.ToInt32(NMBDEC_VAL_MIN));
                    DECIMAL.MaxValue = (NMBDEC_VAL_MAX == null ? DECIMAL.MaxValue : Convert.ToInt32(NMBDEC_VAL_MAX));
                    # endregion

                    break;
                case "DATE":
                    # region DATE
                    uc = (UserControl)Page.LoadControl("~/credit/usercontrols/TextBoxDate.ascx");

                    TextBoxDate DATE = (TextBoxDate)uc;
                    DATE.ID = rec.QUESTION_ID;
                    DATE.IsRequired = (rec.IS_REQUIRED == 0 ? false : true);
                    DATE.ReadOnly = (rec.IS_CALCABLE == 0 ? false : true);

                    DATE.MinValue = (DAT_VAL_MIN == null ? DATE.MinValue : DAT_VAL_MIN.Value);
                    DATE.MaxValue = (DAT_VAL_MAX == null ? DATE.MaxValue : DAT_VAL_MAX.Value);
                    # endregion

                    break;
                case "LIST":
                    # region LIST
                    uc = (UserControl)Page.LoadControl("~/credit/usercontrols/DDLList.ascx");

                    DDLList LIST = (DDLList)uc;
                    LIST.ID = rec.QUESTION_ID;
                    LIST.IsRequired = (rec.IS_REQUIRED == 0 ? false : true);
                    LIST.Enabled = !(rec.IS_CALCABLE == 0 ? false : true);

                    LIST.DataValueField = "ORD";
                    LIST.DataTextField = "TEXT";

                    VWcsQuestionListItems qli = new VWcsQuestionListItems(con);
                    List<VWcsQuestionListItemsRecord> qliRecords = qli.SelectQuestionListItems(rec.QUESTION_ID);

                    LIST.DataSource = qliRecords;
                    LIST.DataBind();
                    # endregion

                    break;
                case "REFER":
                    # region REFER
                    uc = (UserControl)Page.LoadControl("~/credit/usercontrols/TextBoxRefer.ascx");

                    TextBoxRefer REFER = (TextBoxRefer)uc;
                    REFER.ID = rec.QUESTION_ID;
                    REFER.BID_ID = BID_ID;
                    REFER.QUESTION_ID = rec.QUESTION_ID;
                    REFER.IsRequired = (rec.IS_REQUIRED == 0 ? false : true);
                    REFER.ReadOnly = (rec.IS_CALCABLE == 0 ? false : true);
                    # endregion

                    break;
                case "BOOL":
                    # region BOOL
                    uc = (UserControl)Page.LoadControl("~/credit/usercontrols/RBLFlag.ascx");

                    RBLFlag BOOL = (RBLFlag)uc;
                    BOOL.ID = rec.QUESTION_ID;
                    BOOL.IsRequired = (rec.IS_REQUIRED == 0 ? false : true);
                    BOOL.ReadOnly = (rec.IS_CALCABLE == 0 ? false : true);

                    BOOL.DefaultValue = (!BOOL_VAL_DEFAULT.HasValue ? BOOL.DefaultValue : (BOOL_VAL_DEFAULT.Value == 0 ? false : true));
                    # endregion

                    break;
            }
            # endregion

            // дабавляем в контейнер
            htcControl.Controls.Add(uc);
        }
    }
    void ucItf_ValueChanged(object sender, EventArgs e)
    {
        BbConnection con = new BbConnection();

        try
        {
            String QUESTION_ID = (sender as UserControl).ID;
            List<VWcsBidAuthsQuestsRecord> recs = (new VWcsBidAuthsQuests(con)).SelectBidAuthsQuest(BID_ID, QUESTION_ID);

            if (recs.Count > 0)
            {
                VWcsBidAuthsQuestsRecord rec = recs[0];

                // отображаем сканкопию, если она есть
                if (rec.SCOPY_QID != null)
                {
                    Common cmn = new Common(con);
                    imgSc.Value = cmn.wu.GET_ANSW_BLOB(BID_ID, rec.SCOPY_QID);
                }
            }
        }
        finally
        {
            con.CloseConnection();
        }
    }
    private void FillData(BbConnection con, Decimal? BID_ID, Control Container)
    {
        Common cmn = new Common(con);

        if (IsDataFilled) return;

        // вопросы
        List<VWcsBidAuthsQuestsRecord> recs = (new VWcsBidAuthsQuests(con)).SelectBidAuthsQuests(BID_ID);
        foreach (VWcsBidAuthsQuestsRecord rec in recs)
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

            cmn.wu.GET_QUEST_PARAMS(BID_ID, rec.QUESTION_ID, out TEXT_LENG_MIN, out TEXT_LENG_MAX, out TEXT_VAL_DEFAULT, out TEXT_WIDTH, out TEXT_ROWS, out NMBDEC_VAL_MIN, out NMBDEC_VAL_MAX, out NMBDEC_VAL_DEFAULT, out DAT_VAL_MIN, out DAT_VAL_MAX, out DAT_VAL_DEFAULT, out LIST_SID_DEFAULT, out REFER_SID_DEFAULT, out TAB_ID, out KEY_FIELD, out SEMANTIC_FIELD, out SHOW_FIELDS, out WHERE_CLAUSE, out BOOL_VAL_DEFAULT);

            // если вопрос вычисляемый, то вычисляем его
            if (rec.IS_CALCABLE == 1) cmn.wu.CALC_ANSW(BID_ID, rec.QUESTION_ID);
            Decimal? HasAnsw = cmn.wu.HAS_ANSW(BID_ID, rec.QUESTION_ID);

            // контрол
            UserControl uc = (Container.FindControl(rec.QUESTION_ID) as UserControl);

            # region Switch TYPE_ID
            switch (rec.TYPE_ID)
            {
                case "TEXT":
                    # region TEXT
                    TextBoxString TEXT = (TextBoxString)uc;

                    if (HasAnsw == 1) TEXT.Value = cmn.wu.GET_ANSW_TEXT(BID_ID, rec.QUESTION_ID);
                    else TEXT.Value = TEXT_VAL_DEFAULT;
                    # endregion

                    break;
                case "NUMB":
                    # region NUMB
                    TextBoxNumb NUMB = (TextBoxNumb)uc;

                    if (HasAnsw == 1) NUMB.Value = cmn.wu.GET_ANSW_NUMB(BID_ID, rec.QUESTION_ID);
                    else NUMB.Value = NMBDEC_VAL_DEFAULT;
                    # endregion

                    break;
                case "DECIMAL":
                    # region DECIMAL
                    TextBoxDecimal DECIMAL = (TextBoxDecimal)uc;

                    if (HasAnsw == 1) DECIMAL.Value = cmn.wu.GET_ANSW_DECIMAL(BID_ID, rec.QUESTION_ID);
                    else DECIMAL.Value = NMBDEC_VAL_DEFAULT;
                    # endregion

                    break;
                case "DATE":
                    # region DATE
                    TextBoxDate DATE = (TextBoxDate)uc;

                    if (HasAnsw == 1) DATE.Value = cmn.wu.GET_ANSW_DATE(BID_ID, rec.QUESTION_ID);
                    else DATE.Value = DAT_VAL_DEFAULT;
                    # endregion

                    break;
                case "LIST":
                    # region LIST
                    DDLList LIST = (DDLList)uc;

                    if (HasAnsw == 1) LIST.Value = cmn.wu.GET_ANSW_LIST(BID_ID, rec.QUESTION_ID);
                    else LIST.Value = LIST_SID_DEFAULT;
                    # endregion

                    break;
                case "REFER":
                    # region REFER
                    TextBoxRefer REFER = (TextBoxRefer)uc;

                    if (HasAnsw == 1) REFER.Value = cmn.wu.GET_ANSW_REFER(BID_ID, rec.QUESTION_ID);
                    else REFER.Value = REFER_SID_DEFAULT;
                    # endregion

                    break;
                case "BOOL":
                    # region BOOL
                    RBLFlag BOOL = (RBLFlag)uc;

                    if (HasAnsw == 1) BOOL.Value = cmn.wu.GET_ANSW_BOOL(BID_ID, rec.QUESTION_ID);
                    else BOOL.Value = BOOL_VAL_DEFAULT;
                    # endregion

                    break;
            }
            # endregion

            // запрещаем менять если значенее задано ранее и если оно проходит проверку
            if (!IsPostBack &&
                HasAnsw == 1 &&
                (rec.IS_CHECKABLE == 1 && cmn.wu.EXEC_CHECK(BID_ID, rec.CHECK_PROC) == null || rec.IS_CHECKABLE == 0)
                && uc is IBarsUserControl)
            {
                IBarsUserControl ucItf = (IBarsUserControl)uc;
                // закоментировано по заявке от 21.06.2011
                // ucItf.ReadOnly = true;
            }

            // отображаем сканкопию, если она есть
            // добаляем отображение сканкопии
            if (uc is IBarsUserControl)
            {
                IBarsUserControl ucItf = (IBarsUserControl)uc;
                if (rec.SCOPY_QID != null && cmn.wu.HAS_ANSW(BID_ID, rec.SCOPY_QID) == 1)
                {
                    // задаем значение компоненты
                    String ImageDataSessionID = String.Format(imgSc.SessionIDPattern, rec.SCOPY_QID);
                    this.Session[ImageDataSessionID] = cmn.wu.GET_ANSW_BLOB(BID_ID, rec.SCOPY_QID);

                    ucItf.BaseAttributes.Add("onfocus", "if (document.getElementById('" + imgSc.BaseClientID + "').sid != '" + ImageDataSessionID + "') { " + String.Format(imgSc.InitScriptPattern, imgSc.BaseClientID, ImageDataSessionID, imgSc.PCountClientID, String.Empty, String.Empty) + " } ");
                }
                else
                {
                    //ucItf.BaseAttributes.Add("onfocus", "DeleteAllFromMemory('" + imgSc.BaseClientID + "'); ");
                }
            }
        }

        IsDataFilled = true;
    }
    private Boolean SaveData(BbConnection con, Decimal? BID_ID, Control Container)
    {
        Common cmn = new Common(con);

        if (IsDataSaved) return SaveResult;

        // проверки
        Boolean GlobalCheckResult = true;
        Master.HideError();

        // вопросы
        List<VWcsBidAuthsQuestsRecord> recs = (new VWcsBidAuthsQuests(con)).SelectBidAuthsQuests(BID_ID);
        foreach (VWcsBidAuthsQuestsRecord rec in recs)
        {
            // если вопрос вычисляемый, то вычисляем его
            if (rec.IS_CALCABLE == 1) cmn.wu.CALC_ANSW(BID_ID, rec.QUESTION_ID);

            // контрол
            UserControl uc = (Container.FindControl(rec.QUESTION_ID) as UserControl);

            # region Switch TYPE_ID
            switch (rec.TYPE_ID)
            {
                case "TEXT":
                    # region TEXT
                    TextBoxString TEXT = (TextBoxString)uc;
                    cmn.wp.ANSW_TEXT_SET(BID_ID, rec.QUESTION_ID, TEXT.Value);
                    # endregion

                    break;
                case "NUMB":
                    # region NUMB
                    TextBoxNumb NUMB = (TextBoxNumb)uc;
                    cmn.wp.ANSW_NUMB_SET(BID_ID, rec.QUESTION_ID, NUMB.Value);
                    # endregion

                    break;
                case "DECIMAL":
                    # region DECIMAL
                    TextBoxDecimal DECIMAL = (TextBoxDecimal)uc;
                    cmn.wp.ANSW_DEC_SET(BID_ID, rec.QUESTION_ID, DECIMAL.Value);
                    # endregion

                    break;
                case "DATE":
                    # region DATE
                    TextBoxDate DATE = (TextBoxDate)uc;
                    cmn.wp.ANSW_DAT_SET(BID_ID, rec.QUESTION_ID, DATE.Value);
                    # endregion

                    break;
                case "LIST":
                    # region LIST
                    DDLList LIST = (DDLList)uc;
                    cmn.wp.ANSW_LIST_SET(BID_ID, rec.QUESTION_ID, LIST.Value);
                    # endregion

                    break;
                case "REFER":
                    # region REFER
                    TextBoxRefer REFER = (TextBoxRefer)uc;
                    cmn.wp.ANSW_REF_SET(BID_ID, rec.QUESTION_ID, REFER.Value);
                    # endregion

                    break;
                case "BOOL":
                    # region BOOL
                    RBLFlag BOOL = (RBLFlag)uc;
                    cmn.wp.ANSW_BOOL_SET(BID_ID, rec.QUESTION_ID, BOOL.Value);
                    # endregion

                    break;
            }
            # endregion

            Trace.Write(rec.QUESTION_ID + " saved");
            Decimal? HasAnsw = cmn.wu.HAS_ANSW(BID_ID, rec.QUESTION_ID);

            // проверочная фукнция
            if (HasAnsw == 1 && rec.IS_CHECKABLE == 1)
            {
                String CheckResult = cmn.wu.EXEC_CHECK(BID_ID, rec.CHECK_PROC);
                if (CheckResult != null)
                {
                    Master.ShowError(String.Format(Resources.credit.StringConstants.text_question_check_error_ptrn, rec.QUESTION_ID, rec.QUESTION_NAME, CheckResult));
                    GlobalCheckResult = false;
                    Trace.Write(rec.QUESTION_ID + " checked");
                }
            }
        }

        IsDataSaved = true;

        if (!GlobalCheckResult)
        {
            SaveResult = false;
            return false;
        }

        SaveResult = true;
        return true;
    }
    # endregion
}