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

public partial class credit_manager_grt_ins_survey : Bars.BarsPage
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

    private VWcsBidGrtInsurancesRecord _BidGrtInsurance;

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
    private String INSURANCE_ID
    {
        get
        {
            return Request.Params.Get("insurance_id");
        }
    }
    private Decimal? INSURANCE_NUM
    {
        get
        {
            return Convert.ToDecimal(Request.Params.Get("insurance_num"));
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

    public VWcsBidGrtInsurancesRecord BidGrtInsurance
    {
        get
        {
            if (_BidGrtInsurance == null)
                _BidGrtInsurance = (new VWcsBidGrtInsurances()).SelectBidGrtInsurance(BID_ID, GARANTEE_ID, GARANTEE_NUM, INSURANCE_ID, INSURANCE_NUM)[0];

            return _BidGrtInsurance;
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
    protected override void OnInit(EventArgs e)
    {
        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        try
        {
            // переводим страховку в состояние Заповнення анкети
            if (BidGrtInsurance.STATUS_ID == 0) // Новий
                cmn.wp.BID_GRT_INSURANCE_STATUS_SET(BID_ID, GARANTEE_ID, GARANTEE_NUM, INSURANCE_ID, INSURANCE_NUM, 1); // Заповнення анкети

            // устанавливаем ответ на вопрос "Ідентифікатор типу забезпечення до якого прив`язується страховка"
            cmn.wp.ANSW_TEXT_SET(BID_ID, "INS_GARANTEE_ID", BidGrtInsurance.GARANTEE_ID, BidGrtInsurance.WS_ID, INSURANCE_NUM);

            // устанавливаем ответ на вопрос "Номер забезпечення до якого прив`язується страховка"
            cmn.wp.ANSW_NUMB_SET(BID_ID, "INS_GARANTEE_NUM", BidGrtInsurance.GARANTEE_NUM, BidGrtInsurance.WS_ID, INSURANCE_NUM);

            // устанавливаем ответ на вопрос "Тип страхового договору"
            cmn.wp.ANSW_REF_SET(BID_ID, "INS_TYPE_ID", Convert.ToString(BidGrtInsurance.INS_TYPE_ID), BidGrtInsurance.WS_ID, INSURANCE_NUM);

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
        // заголовок Анкета обеспечения {0} - {1} заявки №{2}
        Master.SetPageTitle(String.Format(this.Title, BidGrtInsurance.GARANTEE_NAME, BidGrtInsurance.GARANTEE_NUM, BidGrtInsurance.INSURANCE_NAME, Convert.ToString(INSURANCE_NUM), Convert.ToString(BID_ID)), true);

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
                // переводим обеспечение в след состояние
                if (BidGrtInsurance.STATUS_ID == 1) // Заповнення анкети
                    cmn.wp.BID_GRT_INSURANCE_STATUS_SET(BID_ID, GARANTEE_ID, GARANTEE_NUM, INSURANCE_ID, INSURANCE_NUM, 2); // Заведено

                // возвращаемся в карточку заявки
                Response.Redirect(String.Format("/barsroot/credit/manager/grt_insurances.aspx?bid_id={0}&garantee_id={1}&garantee_num={2}&readonly={3}", BID_ID.ToString(), GARANTEE_ID, Convert.ToString(GARANTEE_NUM), (ReadOnly.Value ? 1 : 0)));
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
        Common cmn = new Common(con, BID_ID, GARANTEE_ID, GARANTEE_NUM, INSURANCE_ID, INSURANCE_NUM);

        try
        {
            // смотрим заполнялась ли закладка
            if (cmn.BidGrtInsSurGroups[e.NextStepIndex].IS_FILLED != 1)
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
        Common cmn = new Common(con, BID_ID, GARANTEE_ID, GARANTEE_NUM, INSURANCE_ID, INSURANCE_NUM);

        try
        {
            // группы вопросов
            foreach (VWcsBidGrtInsSurGroupsRecord recs in cmn.BidGrtInsSurGroups)
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
        Common cmn = new Common(con, BID_ID, GARANTEE_ID, GARANTEE_NUM, INSURANCE_ID, INSURANCE_NUM);

        // проставляем рабочее пространство
        cmn.wu.SET_WS_ID(BidGrtInsurance.WS_ID);
        cmn.wu.SET_WS_NUM(INSURANCE_NUM);

        // группы вопросов
        VWcsBidGrtInsSurGroupsRecord ssgRecord = cmn.BidGrtInsSurGroups[StepIndex];

        // шаг
        WizardStep ws = (WizardStep)wzd.WizardSteps[StepIndex];

        // контейнер вопросов
        HtmlTable ht = (ws.FindControl("containerTable_" + StepIndex.ToString()) as HtmlTable);
        if (ht != null) ws.Controls.Remove(ht);

        ht = new HtmlTable();
        ht.ID = "containerTable_" + StepIndex.ToString();

        ht.Border = 0;
        ht.CellPadding = 0;
        ht.CellSpacing = 0;

        ht.Width = "99%";

        ws.Controls.Add(ht);

        // вопросы группы
        List<VWcsBidGrtInsSurGrpQsRecord> ssqRecords = (new VWcsBidGrtInsSurGrpQs(con)).SelectBidGrtInsSurGrpQs(BID_ID, GARANTEE_ID, GARANTEE_NUM, INSURANCE_ID, INSURANCE_NUM, ssgRecord.SURVEY_ID, ssgRecord.GROUP_ID);
        foreach (VWcsBidGrtInsSurGrpQsRecord ssqRecord in ssqRecords)
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

            cmn.wu.GET_QUEST_PARAMS(BID_ID, ssqRecord.QUESTION_ID, out TEXT_LENG_MIN, out TEXT_LENG_MAX, out TEXT_VAL_DEFAULT, out TEXT_WIDTH, out TEXT_ROWS, out NMBDEC_VAL_MIN, out NMBDEC_VAL_MAX, out NMBDEC_VAL_DEFAULT, out DAT_VAL_MIN, out DAT_VAL_MAX, out DAT_VAL_DEFAULT, out LIST_SID_DEFAULT, out REFER_SID_DEFAULT, out TAB_ID, out KEY_FIELD, out SEMANTIC_FIELD, out SHOW_FIELDS, out WHERE_CLAUSE, out BOOL_VAL_DEFAULT, BidGrtInsurance.WS_ID, INSURANCE_NUM);

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
                    REFER.WS_ID = BidGrtInsurance.WS_ID;
                    REFER.WS_NUM = INSURANCE_NUM;
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
        Common cmn = new Common(con, BID_ID, GARANTEE_ID, GARANTEE_NUM, INSURANCE_ID, INSURANCE_NUM);

        if (IsDataFilled) return;

        // проставляем рабочее пространство
        cmn.wu.SET_WS_ID(BidGrtInsurance.WS_ID);
        cmn.wu.SET_WS_NUM(INSURANCE_NUM);

        // группы вопросов
        VWcsBidGrtInsSurGroupsRecord ssgRecord = cmn.BidGrtInsSurGroups[StepIndex];

        // вопросы группы
        List<VWcsBidGrtInsSurGrpQsRecord> ssqRecords = (new VWcsBidGrtInsSurGrpQs(con)).SelectBidGrtInsSurGrpQs(BID_ID, GARANTEE_ID, GARANTEE_NUM, INSURANCE_ID, INSURANCE_NUM, ssgRecord.SURVEY_ID, ssgRecord.GROUP_ID);
        foreach (VWcsBidGrtInsSurGrpQsRecord ssqRecord in ssqRecords)
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

            cmn.wu.GET_QUEST_PARAMS(BID_ID, ssqRecord.QUESTION_ID, out TEXT_LENG_MIN, out TEXT_LENG_MAX, out TEXT_VAL_DEFAULT, out TEXT_WIDTH, out TEXT_ROWS, out NMBDEC_VAL_MIN, out NMBDEC_VAL_MAX, out NMBDEC_VAL_DEFAULT, out DAT_VAL_MIN, out DAT_VAL_MAX, out DAT_VAL_DEFAULT, out LIST_SID_DEFAULT, out REFER_SID_DEFAULT, out TAB_ID, out KEY_FIELD, out SEMANTIC_FIELD, out SHOW_FIELDS, out WHERE_CLAUSE, out BOOL_VAL_DEFAULT, BidGrtInsurance.WS_ID, INSURANCE_NUM);

            // если вопрос вычисляемый, то вычисляем его
            if (ssqRecord.IS_CALCABLE == 1) cmn.wu.CALC_ANSW(BID_ID, ssqRecord.QUESTION_ID, BidGrtInsurance.WS_ID, INSURANCE_NUM);
            Decimal? HasAnsw = cmn.wu.HAS_ANSW(BID_ID, ssqRecord.QUESTION_ID, BidGrtInsurance.WS_ID, INSURANCE_NUM);

            // контрол
            UserControl uc = (wzd.FindControl(ssqRecord.QUESTION_ID) as UserControl);

            // запоминаем то что вопрос пришел к нам пустым
            if (HasAnsw == 0) PreFilledQuestions.Add(ssqRecord.QUESTION_ID);

            // если есть ответ на вопрос и запрещена перезапись и ответ на него получен 
            // (а не заполнен на этой форме), то запрещаем редактирование
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

                    if (HasAnsw == 1) TEXT.Value = cmn.wu.GET_ANSW_TEXT(BID_ID, ssqRecord.QUESTION_ID, BidGrtInsurance.WS_ID, INSURANCE_NUM);
                    else TEXT.Value = TEXT_VAL_DEFAULT;
                    # endregion

                    break;
                case "NUMB":
                    # region NUMB
                    TextBoxNumb NUMB = (TextBoxNumb)uc;

                    if (HasAnsw == 1) NUMB.Value = cmn.wu.GET_ANSW_NUMB(BID_ID, ssqRecord.QUESTION_ID, BidGrtInsurance.WS_ID, INSURANCE_NUM);
                    else NUMB.Value = NMBDEC_VAL_DEFAULT;
                    # endregion

                    break;
                case "DECIMAL":
                    # region DECIMAL
                    TextBoxDecimal DECIMAL = (TextBoxDecimal)uc;

                    if (HasAnsw == 1) DECIMAL.Value = cmn.wu.GET_ANSW_DECIMAL(BID_ID, ssqRecord.QUESTION_ID, BidGrtInsurance.WS_ID, INSURANCE_NUM);
                    else DECIMAL.Value = NMBDEC_VAL_DEFAULT;
                    # endregion

                    break;
                case "DATE":
                    # region DATE
                    TextBoxDate DATE = (TextBoxDate)uc;

                    if (HasAnsw == 1) DATE.Value = cmn.wu.GET_ANSW_DATE(BID_ID, ssqRecord.QUESTION_ID, BidGrtInsurance.WS_ID, INSURANCE_NUM);
                    else DATE.Value = DAT_VAL_DEFAULT;
                    # endregion

                    break;
                case "LIST":
                    # region LIST
                    DDLList LIST = (DDLList)uc;

                    if (HasAnsw == 1) LIST.Value = cmn.wu.GET_ANSW_LIST(BID_ID, ssqRecord.QUESTION_ID, BidGrtInsurance.WS_ID, INSURANCE_NUM);
                    else LIST.Value = LIST_SID_DEFAULT;
                    # endregion

                    break;
                case "REFER":
                    # region REFER
                    TextBoxRefer REFER = (TextBoxRefer)uc;

                    if (HasAnsw == 1) REFER.Value = cmn.wu.GET_ANSW_REFER(BID_ID, ssqRecord.QUESTION_ID, BidGrtInsurance.WS_ID, INSURANCE_NUM);
                    else REFER.Value = REFER_SID_DEFAULT;
                    # endregion

                    break;
                case "BOOL":
                    # region BOOL
                    RBLFlag BOOL = (RBLFlag)uc;

                    if (HasAnsw == 1) BOOL.Value = cmn.wu.GET_ANSW_BOOL(BID_ID, ssqRecord.QUESTION_ID, BidGrtInsurance.WS_ID, INSURANCE_NUM);
                    else BOOL.Value = BOOL_VAL_DEFAULT;
                    # endregion

                    break;
            }
            # endregion
        }

        // запоминаем шаг как заполненый
        cmn.wp.ANSW_BOOL_SET(BID_ID, ssgRecord.RESULT_QID, 1, BidGrtInsurance.WS_ID, INSURANCE_NUM);

        IsDataFilled = true;
    }
    private Boolean SaveData(BbConnection con, Wizard wzd, Int32 StepIndex)
    {
        Common cmn = new Common(con, BID_ID, GARANTEE_ID, GARANTEE_NUM, INSURANCE_ID, INSURANCE_NUM);

        if (IsDataSaved) return SaveResult;

        // проставляем рабочее пространство
        cmn.wu.SET_WS_ID(BidGrtInsurance.WS_ID);
        cmn.wu.SET_WS_NUM(INSURANCE_NUM);

        // группы вопросов
        VWcsBidGrtInsSurGroupsRecord ssgRecord = cmn.BidGrtInsSurGroups[StepIndex];

        // шаг
        WizardStep ws = (WizardStep)wzd.WizardSteps[StepIndex];
        // контейнер вопросов
        HtmlTable ht = (ws.Controls[0] as HtmlTable);

        // проверки
        Boolean GlobalCheckResult = true;
        Master.HideError();

        // вопросы группы
        List<VWcsBidGrtInsSurGrpQsRecord> ssqRecords = (new VWcsBidGrtInsSurGrpQs(con)).SelectBidGrtInsSurGrpQs(BID_ID, GARANTEE_ID, GARANTEE_NUM, INSURANCE_ID, INSURANCE_NUM, ssgRecord.SURVEY_ID, ssgRecord.GROUP_ID);
        foreach (VWcsBidGrtInsSurGrpQsRecord ssqRecord in ssqRecords)
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
                cmn.wu.CALC_ANSW(BID_ID, ssqRecord.QUESTION_ID, BidGrtInsurance.WS_ID, INSURANCE_NUM);
            }

            // контрол                
            UserControl uc = (htcControl.Controls[0] as UserControl);

            # region Switch TYPE_ID
            switch (ssqRecord.TYPE_ID)
            {
                case "TEXT":
                    # region TEXT
                    TextBoxString TEXT = (TextBoxString)uc;
                    cmn.wp.ANSW_TEXT_SET(BID_ID, ssqRecord.QUESTION_ID, TEXT.Value, BidGrtInsurance.WS_ID, INSURANCE_NUM);
                    # endregion

                    break;
                case "NUMB":
                    # region NUMB
                    TextBoxNumb NUMB = (TextBoxNumb)uc;
                    cmn.wp.ANSW_NUMB_SET(BID_ID, ssqRecord.QUESTION_ID, NUMB.Value, BidGrtInsurance.WS_ID, INSURANCE_NUM);
                    # endregion

                    break;
                case "DECIMAL":
                    # region DECIMAL
                    TextBoxDecimal DECIMAL = (TextBoxDecimal)uc;
                    cmn.wp.ANSW_DEC_SET(BID_ID, ssqRecord.QUESTION_ID, DECIMAL.Value, BidGrtInsurance.WS_ID, INSURANCE_NUM);
                    # endregion

                    break;
                case "DATE":
                    # region DATE
                    TextBoxDate DATE = (TextBoxDate)uc;
                    cmn.wp.ANSW_DAT_SET(BID_ID, ssqRecord.QUESTION_ID, DATE.Value, BidGrtInsurance.WS_ID, INSURANCE_NUM);
                    # endregion

                    break;
                case "LIST":
                    # region LIST
                    DDLList LIST = (DDLList)uc;
                    cmn.wp.ANSW_LIST_SET(BID_ID, ssqRecord.QUESTION_ID, LIST.Value, BidGrtInsurance.WS_ID, INSURANCE_NUM);
                    # endregion

                    break;
                case "REFER":
                    # region REFER
                    TextBoxRefer REFER = (TextBoxRefer)uc;
                    cmn.wp.ANSW_REF_SET(BID_ID, ssqRecord.QUESTION_ID, REFER.Value, BidGrtInsurance.WS_ID, INSURANCE_NUM);
                    # endregion

                    break;
                case "BOOL":
                    # region BOOL
                    RBLFlag BOOL = (RBLFlag)uc;
                    cmn.wp.ANSW_BOOL_SET(BID_ID, ssqRecord.QUESTION_ID, BOOL.Value, BidGrtInsurance.WS_ID, INSURANCE_NUM);
                    # endregion

                    break;
            }
            # endregion

            Decimal? HasAnsw = cmn.wu.HAS_ANSW(BID_ID, ssqRecord.QUESTION_ID);
            Trace.Write(ssqRecord.QUESTION_ID + " saved");

            // проверочная фукнция
            if (HasAnsw == 1 && ssqRecord.IS_CHECKABLE == 1)
            {
                String CheckResult = cmn.wu.EXEC_CHECK(BID_ID, ssqRecord.CHECK_PROC, BidGrtInsurance.WS_ID, INSURANCE_NUM);
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
        cmn.wu.SET_NULL_2_HIDED_QUESTS(BID_ID, ssgRecord.SURVEY_ID, ssgRecord.GROUP_ID, BidGrtInsurance.WS_ID, INSURANCE_NUM);

        SaveResult = true;
        return true;
    }
    # endregion
}