﻿using System;
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

public partial class credit_manager_survey : Bars.BarsPage
{
    # region Приватные свойства
    private ArrayList PreFilledQuestions
    {
        get
        {
            if (Session["PREFILLEDQUESTIONS"] == null) Session["PREFILLEDQUESTIONS"] = new ArrayList();
            return (ArrayList)Session["PREFILLEDQUESTIONS"];
        }
        set
        {
            Session["PREFILLEDQUESTIONS"] = value;
        }
    }

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
        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        try
        {
            // чекаут состояния
            if (!IsPostBack) cmn.wp.BID_STATE_CHECK_OUT(BID_ID, "NEW_SURVEY", (String)null);

            // наполняем шаги опросника
            GenerateWizardSteps(con, wzd);

            // показываем первый шаг
            if (!IsPostBack) wzd.ActiveStepIndex = 0;
        }
        finally
        {
            con.CloseConnection();
        }

        base.OnInit(e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        // заголовок
        Master.SetPageTitle(this.Title + Convert.ToString(BID_ID), true);

        BbConnection con = new BbConnection();

        try
        {
            // создаем контролы текущего шага (если раз то полное создание)
            GenerateStepControls(con, wzd, wzd.ActiveStepIndex);
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
            // наполняем данными
            FillData(con, wzd, wzd.ActiveStepIndex);
        }
        finally
        {
            con.CloseConnection();
        }

        // блокировка страницы после каждого нажатия, чтоб избежать повторного постбека
        ScriptManager.RegisterOnSubmitStatement(this, this.GetType(), "disable_controls", "if (!DisableControl()) return false; ");

        base.OnPreRender(e);
    }

    protected void wzd_NextButtonClick(object sender, WizardNavigationEventArgs e)
    {
        if (IsValuesChangedEvent)
        {
            e.Cancel = true;
            return;
        }

        BbConnection con = new BbConnection();

        try
        {
            // сохраняем изменения если нет ошибок при заполнении
            if (SaveData(con, wzd, e.CurrentStepIndex))
            {
                Master.HideError();
                // создаем контролы будущего шага
                GenerateStepControls(con, wzd, e.NextStepIndex);
            }
            else e.Cancel = true;
        }
        finally
        {
            con.CloseConnection();
        }
    }
    protected void wzd_PreviousButtonClick(object sender, WizardNavigationEventArgs e)
    {
        if (IsValuesChangedEvent)
        {
            e.Cancel = true;
            return;
        }

        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        try
        {
            // сохраняем изменения если нет ошибок при заполнении
            if (SaveData(con, wzd, e.CurrentStepIndex))
            {
                Master.HideError();
                // создаем контролы будущего шага
                GenerateStepControls(con, wzd, e.NextStepIndex);
            }
            else e.Cancel = true;
        }
        finally
        {
            con.CloseConnection();
        }
    }
    protected void wzd_FinishButtonClick(object sender, WizardNavigationEventArgs e)
    {
        if (IsValuesChangedEvent)
        {
            e.Cancel = true;
            return;
        }

        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        try
        {
            // сохраняем изменения если нет ошибок при заполнении
            if (SaveData(con, wzd, e.CurrentStepIndex))
            {
                // чекин состояния
                cmn.wp.BID_STATE_CHECK_IN(BID_ID, "NEW_SURVEY", (String)null);

                // завершаем состояние и переходим на след
                cmn.wp.BID_STATE_DEL(BID_ID, "NEW_SURVEY");

                // возвращаемся в карточку заявки
                Response.Redirect(String.Format("/barsroot/credit/manager/bid_card.aspx?bid_id={0}", BID_ID.ToString()));
            }
            else e.Cancel = true;
        }
        finally
        {
            con.CloseConnection();
        }
    }
    protected void wzd_SideBarButtonClick(object sender, WizardNavigationEventArgs e)
    {
        if (IsValuesChangedEvent)
        {
            e.Cancel = true;
            return;
        }

        BbConnection con = new BbConnection();
        Common cmn = new Common(con, BID_ID);

        try
        {
            // смотрим заполнялась ли закладка
            if (cmn.BidSurveyGroups[e.NextStepIndex].IS_FILLED != 1)
            {
                e.Cancel = true;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert_survey_wrong_step", String.Format("alert('{0}');", Resources.credit.StringConstants.text_survey_wrong_step), true);
            }
            else
            {
                // сохраняем изменения если нет ошибок при заполнении
                if (SaveData(con, wzd, e.CurrentStepIndex))
                {
                    Master.HideError();
                    // создаем контролы будущего шага
                    GenerateStepControls(con, wzd, e.NextStepIndex);
                }
                else e.Cancel = true;
            }
        }
        finally
        {
            con.CloseConnection();
        }
    }
    protected void wzd_ActiveStepChanged(object sender, EventArgs e)
    {
        Master.SetPageTitle(wzd.ActiveStep.Name);
    }

    public void ValueChanged(object sender, EventArgs e)
    {
        IsValuesChangedEvent = true;

        BbConnection con = new BbConnection();

        try
        {
            // сохраняем изменения если нет ошибок при заполнении
            SaveData(con, wzd, wzd.ActiveStepIndex);
            Master.HideError();

            // создаем контролы будущего шага
            GenerateStepControls(con, wzd, wzd.ActiveStepIndex);
        }
        finally
        {
            con.CloseConnection();
        }
    }
    # endregion

    # region Приватные методы
    private void GenerateWizardSteps(BbConnection con, Wizard wzd)
    {
        Common cmn = new Common(con, BID_ID);

        try
        {
            // группы вопросов
            foreach (VWcsBidSurveyGroupsRecord recs in cmn.BidSurveyGroups)
            {
                // шаг
                WizardStep ws = new WizardStep();
                ws.ID = recs.GROUP_ID;
                ws.Title = recs.GROUP_NAME;
                wzd.WizardSteps.Add(ws);
            }
        }
        finally
        {
            con.CloseConnection();
        }
    }
    private void GenerateStepControls(BbConnection con, Wizard wzd, Int32 StepIndex)
    {
        Common cmn = new Common(con, BID_ID);

        // группы вопросов
        VWcsBidSurveyGroupsRecord ssgRecord = cmn.BidSurveyGroups[StepIndex];

        // шаг
        WizardStep ws = (WizardStep)wzd.WizardSteps[StepIndex];

        // контейнер вопросов
        String ContainerIDPtrn = "containerTable_" + StepIndex.ToString();
        HtmlTable ht = (FindControls(ws, ContainerIDPtrn) as HtmlTable);
        if (ht != null) ws.Controls.Remove(ht);

        ht = new HtmlTable();
        ht.ID = ContainerIDPtrn + Guid.NewGuid().ToString();

        ht.Border = 0;
        ht.CellPadding = 0;
        ht.CellSpacing = 0;

        ht.Width = "99%";

        ws.Controls.Add(ht);

        // вопросы группы
        List<VWcsBidSurveyGroupQuestsRecord> ssqRecords = (new VWcsBidSurveyGroupQuests(con)).SelectBidSurveyGroupQuests(BID_ID, ssgRecord.SURVEY_ID, ssgRecord.GROUP_ID);
        foreach (VWcsBidSurveyGroupQuestsRecord ssqRecord in ssqRecords)
        {
            // раздел
            if (ssqRecord.RECTYPE_ID == "SECTION")
            {
                // строчка заголовка раздела
                HtmlTableRow htrSection = new HtmlTableRow();
                htrSection.ID = "htrSection_" + ssqRecord.QUESTION_ID;

                HtmlTableRow htrSeparator = new HtmlTableRow();
                htrSeparator.Height = "20px";

                HtmlTableCell htcSectionTitle = new HtmlTableCell("td");
                htcSectionTitle.Attributes.Add("class", "sectionTitle");
                htcSectionTitle.InnerText = ssqRecord.QUESTION_NAME;
                htcSectionTitle.ColSpan = 2;

                htrSection.Cells.Add(htcSectionTitle);
                ht.Rows.Add(htrSeparator);
                ht.Rows.Add(htrSection);

                continue;
            }

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

            cmn.wu.GET_QUEST_PARAMS(BID_ID, ssqRecord.QUESTION_ID, out TEXT_LENG_MIN, out TEXT_LENG_MAX, out TEXT_VAL_DEFAULT, out TEXT_WIDTH, out TEXT_ROWS, out NMBDEC_VAL_MIN, out NMBDEC_VAL_MAX, out NMBDEC_VAL_DEFAULT, out DAT_VAL_MIN, out DAT_VAL_MAX, out DAT_VAL_DEFAULT, out LIST_SID_DEFAULT, out REFER_SID_DEFAULT, out TAB_ID, out KEY_FIELD, out SEMANTIC_FIELD, out SHOW_FIELDS, out WHERE_CLAUSE, out BOOL_VAL_DEFAULT);

            /*try
            {
                cmn.wu.GET_QUEST_PARAMS(BID_ID, ssqRecord.QUESTION_ID, out TEXT_LENG_MIN, out TEXT_LENG_MAX, out TEXT_VAL_DEFAULT, out TEXT_WIDTH, out TEXT_ROWS, out NMBDEC_VAL_MIN, out NMBDEC_VAL_MAX, out NMBDEC_VAL_DEFAULT, out DAT_VAL_MIN, out DAT_VAL_MAX, out DAT_VAL_DEFAULT, out LIST_SID_DEFAULT, out REFER_SID_DEFAULT, out TAB_ID, out KEY_FIELD, out SEMANTIC_FIELD, out SHOW_FIELDS, out WHERE_CLAUSE, out BOOL_VAL_DEFAULT);
            }
            catch
            {
                throw new System.Exception(ssqRecord.QUESTION_ID);
            }*/

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
                    TEXT.IsRequired = (ssqRecord.IS_REQUIRED == 0 ? false : true);
                    TEXT.ReadOnly = (ssqRecord.IS_CALCABLE == 1 || ssqRecord.IS_READONLY == 1);

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
                    NUMB.IsRequired = (ssqRecord.IS_REQUIRED == 0 ? false : true);
                    NUMB.ReadOnly = (ssqRecord.IS_CALCABLE == 1 || ssqRecord.IS_READONLY == 1);

                    NUMB.MinValue = (NMBDEC_VAL_MIN == null ? NUMB.MinValue : Convert.ToInt32(NMBDEC_VAL_MIN));
                    NUMB.MaxValue = (NMBDEC_VAL_MAX == null ? NUMB.MaxValue : Convert.ToInt32(NMBDEC_VAL_MAX));
                    # endregion

                    break;
                case "DECIMAL":
                    # region DECIMAL
                    uc = (UserControl)Page.LoadControl("~/credit/usercontrols/TextBoxDecimal.ascx");

                    TextBoxDecimal DECIMAL = (TextBoxDecimal)uc;
                    DECIMAL.ID = ssqRecord.QUESTION_ID;
                    DECIMAL.IsRequired = (ssqRecord.IS_REQUIRED == 0 ? false : true);
                    DECIMAL.ReadOnly = (ssqRecord.IS_CALCABLE == 1 || ssqRecord.IS_READONLY == 1);

                    DECIMAL.MinValue = (NMBDEC_VAL_MIN == null ? DECIMAL.MinValue : NMBDEC_VAL_MIN);
                    DECIMAL.MaxValue = (NMBDEC_VAL_MAX == null ? DECIMAL.MaxValue : NMBDEC_VAL_MAX);
                    # endregion

                    break;
                case "DATE":
                    # region DATE
                    uc = (UserControl)Page.LoadControl("~/credit/usercontrols/TextBoxDate.ascx");

                    TextBoxDate DATE = (TextBoxDate)uc;
                    DATE.ID = ssqRecord.QUESTION_ID;
                    DATE.IsRequired = (ssqRecord.IS_REQUIRED == 0 ? false : true);
                    DATE.ReadOnly = (ssqRecord.IS_CALCABLE == 1 || ssqRecord.IS_READONLY == 1);

                    DATE.MinValue = (DAT_VAL_MIN == null ? DATE.MinValue : DAT_VAL_MIN.Value);
                    DATE.MaxValue = (DAT_VAL_MAX == null ? DATE.MaxValue : DAT_VAL_MAX.Value);
                    # endregion

                    break;
                case "LIST":
                    # region LIST
                    uc = (UserControl)Page.LoadControl("~/credit/usercontrols/DDLList.ascx");

                    DDLList LIST = (DDLList)uc;
                    LIST.ID = ssqRecord.QUESTION_ID;
                    LIST.IsRequired = (ssqRecord.IS_REQUIRED == 0 ? false : true);
                    LIST.ReadOnly = (ssqRecord.IS_CALCABLE == 1 || ssqRecord.IS_READONLY == 1);

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
                    REFER.IsRequired = (ssqRecord.IS_REQUIRED == 0 ? false : true);
                    REFER.ReadOnly = (ssqRecord.IS_CALCABLE == 1 || ssqRecord.IS_READONLY == 1);
                    # endregion

                    break;
                case "BOOL":
                    # region BOOL
                    uc = (UserControl)Page.LoadControl("~/credit/usercontrols/RBLFlag.ascx");

                    RBLFlag BOOL = (RBLFlag)uc;
                    BOOL.ID = ssqRecord.QUESTION_ID;
                    BOOL.IsRequired = (ssqRecord.IS_REQUIRED == 0 ? false : true);
                    BOOL.ReadOnly = (ssqRecord.IS_CALCABLE == 1 || ssqRecord.IS_READONLY == 1);

                    BOOL.DefaultValue = (!BOOL_VAL_DEFAULT.HasValue ? BOOL.DefaultValue : (BOOL_VAL_DEFAULT.Value == 0 ? false : true));
                    # endregion

                    break;
            }
            # endregion

            // если вопрос имеет зависимые
            if (cmn.wu.HAS_RELATED_SURVEY(ssqRecord.SURVEY_ID, ssqRecord.GROUP_ID, ssqRecord.QUESTION_ID) == 1 && uc is IHasRelControls)
                (uc as IHasRelControls).ValueChanged += new EventHandler(ValueChanged);

            // дабавляем в контейнер
            htcControl.Controls.Add(uc);
        }
    }
    private void FillData(BbConnection con, Wizard wzd, Int32 StepIndex)
    {
        Common cmn = new Common(con, BID_ID);

        if (IsDataFilled) return;

        // группы вопросов
        VWcsBidSurveyGroupsRecord ssgRecord = cmn.BidSurveyGroups[StepIndex];

        // вопросы группы
        List<VWcsBidSurveyGroupQuestsRecord> ssqRecords = (new VWcsBidSurveyGroupQuests(con)).SelectBidSurveyGroupQuests(BID_ID, ssgRecord.SURVEY_ID, ssgRecord.GROUP_ID);
        foreach (VWcsBidSurveyGroupQuestsRecord ssqRecord in ssqRecords)
        {
            // раздел
            if (ssqRecord.RECTYPE_ID == "SECTION")
            {
                continue;
            }

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

            cmn.wu.GET_QUEST_PARAMS(BID_ID, ssqRecord.QUESTION_ID, out TEXT_LENG_MIN, out TEXT_LENG_MAX, out TEXT_VAL_DEFAULT, out TEXT_WIDTH, out TEXT_ROWS, out NMBDEC_VAL_MIN, out NMBDEC_VAL_MAX, out NMBDEC_VAL_DEFAULT, out DAT_VAL_MIN, out DAT_VAL_MAX, out DAT_VAL_DEFAULT, out LIST_SID_DEFAULT, out REFER_SID_DEFAULT, out TAB_ID, out KEY_FIELD, out SEMANTIC_FIELD, out SHOW_FIELDS, out WHERE_CLAUSE, out BOOL_VAL_DEFAULT);

            // если вопрос вычисляемый, то вычисляем его
            if (ssqRecord.IS_CALCABLE == 1)
            {
                Trace.Write("ssqRecord.IS_CALCABLE == 1, ssqRecord.QUESTION_ID = " + ssqRecord.QUESTION_ID);
                cmn.wu.CALC_ANSW(BID_ID, ssqRecord.QUESTION_ID);
            }
            Decimal? HasAnsw = cmn.wu.HAS_ANSW(BID_ID, ssqRecord.QUESTION_ID);

            // контрол
            UserControl uc = (wzd.FindControl(ssqRecord.QUESTION_ID) as UserControl);

            // запоминаем то что вопрос пришел к нам пустым
            if (HasAnsw == 0) PreFilledQuestions.Add(ssqRecord.QUESTION_ID);

            // если есть ответ на вопрос и запрещена перезапись и ответ на него получен 
            // (а не заполнен на этой форме) и он проходит проверку, то запрещаем редактирование
            if (uc is IBarsUserControl
                && ssqRecord.IS_REWRITABLE == 0
                && HasAnsw == 1
                && (ssqRecord.IS_CHECKABLE == 1 && cmn.wu.EXEC_CHECK(BID_ID, ssqRecord.CHECK_PROC) == null || ssqRecord.IS_CHECKABLE == 0)
                && !PreFilledQuestions.Contains(ssqRecord.QUESTION_ID))
                (uc as IBarsUserControl).ReadOnly = true;

            # region Switch TYPE_ID
            switch (ssqRecord.TYPE_ID)
            {
                case "TEXT":
                    # region TEXT
                    TextBoxString TEXT = (TextBoxString)uc;

                    if (HasAnsw == 1) TEXT.Value = cmn.wu.GET_ANSW_TEXT(BID_ID, ssqRecord.QUESTION_ID);
                    else TEXT.Value = TEXT_VAL_DEFAULT;
                    # endregion

                    break;
                case "NUMB":
                    # region NUMB
                    TextBoxNumb NUMB = (TextBoxNumb)uc;

                    if (HasAnsw == 1) NUMB.Value = cmn.wu.GET_ANSW_NUMB(BID_ID, ssqRecord.QUESTION_ID);
                    else NUMB.Value = NMBDEC_VAL_DEFAULT;
                    # endregion

                    break;
                case "DECIMAL":
                    # region DECIMAL
                    TextBoxDecimal DECIMAL = (TextBoxDecimal)uc;

                    if (HasAnsw == 1) DECIMAL.Value = cmn.wu.GET_ANSW_DECIMAL(BID_ID, ssqRecord.QUESTION_ID);
                    else DECIMAL.Value = NMBDEC_VAL_DEFAULT;
                    # endregion

                    break;
                case "DATE":
                    # region DATE
                    TextBoxDate DATE = (TextBoxDate)uc;

                    if (HasAnsw == 1) DATE.Value = cmn.wu.GET_ANSW_DATE(BID_ID, ssqRecord.QUESTION_ID);
                    else DATE.Value = DAT_VAL_DEFAULT;
                    # endregion

                    break;
                case "LIST":
                    # region LIST
                    DDLList LIST = (DDLList)uc;

                    if (HasAnsw == 1) LIST.Value = cmn.wu.GET_ANSW_LIST(BID_ID, ssqRecord.QUESTION_ID);
                    else LIST.Value = LIST_SID_DEFAULT;
                    # endregion

                    break;
                case "REFER":
                    # region REFER
                    TextBoxRefer REFER = (TextBoxRefer)uc;

                    if (HasAnsw == 1) REFER.Value = cmn.wu.GET_ANSW_REFER(BID_ID, ssqRecord.QUESTION_ID);
                    else REFER.Value = REFER_SID_DEFAULT;
                    # endregion

                    break;
                case "BOOL":
                    # region BOOL
                    RBLFlag BOOL = (RBLFlag)uc;

                    if (HasAnsw == 1) BOOL.Value = cmn.wu.GET_ANSW_BOOL(BID_ID, ssqRecord.QUESTION_ID);
                    else BOOL.Value = BOOL_VAL_DEFAULT;
                    # endregion

                    break;
            }
            # endregion
        }

        // запоминаем шаг как заполненый
        cmn.wp.ANSW_BOOL_SET(BID_ID, ssgRecord.RESULT_QID, 1);

        IsDataFilled = true;
    }
    private Boolean SaveData(BbConnection con, Wizard wzd, Int32 StepIndex)
    {
        Common cmn = new Common(con, BID_ID);

        if (IsDataSaved) return SaveResult;

        // группы вопросов
        VWcsBidSurveyGroupsRecord ssgRecord = cmn.BidSurveyGroups[StepIndex];

        // шаг
        WizardStep ws = (WizardStep)wzd.WizardSteps[StepIndex];
        // контейнер вопросов
        HtmlTable ht = (ws.Controls[0] as HtmlTable);

        // проверки
        Boolean GlobalCheckResult = true;
        Master.HideError();

        // вопросы группы
        List<VWcsBidSurveyGroupQuestsRecord> ssqRecords = (new VWcsBidSurveyGroupQuests(con)).SelectBidSurveyGroupQuests(BID_ID, ssgRecord.SURVEY_ID, ssgRecord.GROUP_ID);
        foreach (VWcsBidSurveyGroupQuestsRecord ssqRecord in ssqRecords)
        {
            // раздел
            if (ssqRecord.RECTYPE_ID == "SECTION")
            {
                continue;
            }

            // строчка вопроса
            HtmlTableRow htr = (ht.FindControl("htr_" + ssqRecord.QUESTION_ID) as HtmlTableRow);
            HtmlTableCell htcTitle = htr.Cells[0];
            HtmlTableCell htcControl = htr.Cells[1];

            // если вопрос вычисляемый, то вычисляем его
            if (ssqRecord.IS_CALCABLE == 1)
            {
                cmn.wu.CALC_ANSW(BID_ID, ssqRecord.QUESTION_ID);
            }

            // контрол                
            UserControl uc = (htcControl.Controls[0] as UserControl);

            # region Switch TYPE_ID
            switch (ssqRecord.TYPE_ID)
            {
                case "TEXT":
                    # region TEXT
                    TextBoxString TEXT = (TextBoxString)uc;
                    cmn.wp.ANSW_TEXT_SET(BID_ID, ssqRecord.QUESTION_ID, TEXT.Value);
                    # endregion

                    break;
                case "NUMB":
                    # region NUMB
                    TextBoxNumb NUMB = (TextBoxNumb)uc;
                    cmn.wp.ANSW_NUMB_SET(BID_ID, ssqRecord.QUESTION_ID, NUMB.Value);
                    # endregion

                    break;
                case "DECIMAL":
                    # region DECIMAL
                    TextBoxDecimal DECIMAL = (TextBoxDecimal)uc;
                    cmn.wp.ANSW_DEC_SET(BID_ID, ssqRecord.QUESTION_ID, DECIMAL.Value);
                    # endregion

                    break;
                case "DATE":
                    # region DATE
                    TextBoxDate DATE = (TextBoxDate)uc;
                    cmn.wp.ANSW_DAT_SET(BID_ID, ssqRecord.QUESTION_ID, DATE.Value);
                    # endregion

                    break;
                case "LIST":
                    # region LIST
                    DDLList LIST = (DDLList)uc;
                    cmn.wp.ANSW_LIST_SET(BID_ID, ssqRecord.QUESTION_ID, LIST.Value);
                    # endregion

                    break;
                case "REFER":
                    # region REFER
                    TextBoxRefer REFER = (TextBoxRefer)uc;
                    cmn.wp.ANSW_REF_SET(BID_ID, ssqRecord.QUESTION_ID, REFER.Value);
                    # endregion

                    break;
                case "BOOL":
                    # region BOOL
                    RBLFlag BOOL = (RBLFlag)uc;
                    cmn.wp.ANSW_BOOL_SET(BID_ID, ssqRecord.QUESTION_ID, BOOL.Value);
                    # endregion

                    break;
            }
            # endregion

            Decimal? HasAnsw = cmn.wu.HAS_ANSW(BID_ID, ssqRecord.QUESTION_ID);

            // проверочная фукнция
            if (HasAnsw == 1 && ssqRecord.IS_CHECKABLE == 1)
            {
                String CheckResult = cmn.wu.EXEC_CHECK(BID_ID, ssqRecord.CHECK_PROC);
                if (CheckResult != null)
                {
                    Master.ShowError(String.Format(Resources.credit.StringConstants.text_question_check_error_ptrn, ssqRecord.QUESTION_ID, ssqRecord.QUESTION_NAME, CheckResult));
                    GlobalCheckResult = false;
                }
            }
        }

        IsDataSaved = true;

        if (!GlobalCheckResult)
        {
            SaveResult = false;
            return false;
        }

        // обнуляем неотображаемые вопросы
        cmn.wu.SET_NULL_2_HIDED_QUESTS(BID_ID, ssgRecord.SURVEY_ID, ssgRecord.GROUP_ID);

        SaveResult = true;
        return true;
    }
    private Control FindControls(Control ctrl, String IDPatrn)
    {
        if (ctrl.ID.StartsWith(IDPatrn)) return ctrl;

        foreach (Control c in ctrl.Controls)
        {
            Control res = FindControls(c, IDPatrn);
            if (res != null) return res;
        }

        return null;
    }
    # endregion
}