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

public partial class credit_manager_bid_create : Bars.BarsPage
{
    # region Приватные свойства
    private Boolean _IsDataSaved = false;
    private Boolean _SaveResult = false;
    private Boolean _IsDataFilled = false;
    private Boolean _IsValuesChangedEvent = false;

    private Decimal? _BID_ID;
    private VWcsBidsRecord _BidRecord;
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

    public String SUBPRODUCT_ID
    {
        get
        {
            return ViewState["SUBPRODUCT_ID"] == null ? (String)null : (String)ViewState["SUBPRODUCT_ID"];
        }
        set
        {
            ViewState["SUBPRODUCT_ID"] = value;
        }
    }
    public Decimal? BID_ID
    {
        get
        {
            return ViewState["BID_ID"] == null ? (Decimal?)null : (Decimal?)ViewState["BID_ID"];
        }
        set
        {
            ViewState["BID_ID"] = value;
        }
    }
    public VWcsBidsRecord BidRecord
    {
        get
        {
            if (_BidRecord == null)
            {
                List<VWcsBidsRecord> lst = (new VWcsBids()).SelectBid(BID_ID);
                if (lst.Count > 0) _BidRecord = lst[0];
            }

            return _BidRecord;
        }
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        sds.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
    }

    protected void btSearch_Click(object sender, EventArgs e)
    {
        gv.DataBind();
    }
    protected void gv_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        String SUBPRODUCT_ID;
        String PRT_TPL;

        switch (e.CommandName)
        {
            case "PrintDetails":
                SUBPRODUCT_ID = Convert.ToString(e.CommandArgument).Split(';')[0];
                PRT_TPL = Convert.ToString(e.CommandArgument).Split(';')[1];

                FrxParameters pars = new FrxParameters();
                pars.Add(new FrxParameter("p_subproduct_id", TypeCode.String, SUBPRODUCT_ID));
                FrxDoc doc = new FrxDoc(
                    FrxDoc.GetTemplatePathByFileName(FrxDoc.GetTemplateFileNameByID(PRT_TPL)),
                    pars,
                    this.Page);

                doc.Print(FrxExportTypes.Pdf);

                break;

            case "Select":
                BbConnection con = new BbConnection();
                Common cmn = new Common(con);

                // обнуляем переменные
                _BidRecord = null;
                SUBPRODUCT_ID = (String)null;
                BID_ID = (Decimal?)null;

                // создаем системную заявку
                SUBPRODUCT_ID = Convert.ToString(e.CommandArgument);
                BID_ID = cmn.wp.BID_CREATE(SUBPRODUCT_ID);

                // устанавливаем стутус "выбор условий"
                cmn.wp.BID_STATE_DEL(BID_ID, "NEW_START");
                cmn.wp.BID_STATE_SET_IMMEDIATE(BID_ID, "NEW_SBP_SELECTING", (String)null);

                // предустановленные параметры кредита
                if (PropertyCost.Value.HasValue)
                {
                    List<VWcsBidCreditdataQuestsRecord> ssqRecords = (new VWcsBidCreditdataQuests(con)).SelectBidCreditdataQuests(BID_ID, "PROPERTY_COST");
                    if (ssqRecords.Count > 0)
                        cmn.wp.ANSW_NUMB_SET(BID_ID, ssqRecords[0].QUESTION_ID, PropertyCost.Value);
                }
                if (String.IsNullOrEmpty(CreditCurrency.Value))
                {
                    List<VWcsBidCreditdataQuestsRecord> ssqRecords = (new VWcsBidCreditdataQuests(con)).SelectBidCreditdataQuests(BID_ID, "CREDIT_CURRENCY");
                    if (ssqRecords.Count > 0)
                        cmn.wp.ANSW_REF_SET(BID_ID, ssqRecords[0].QUESTION_ID, CreditCurrency.Value);
                }
                if (CreditSum.Value.HasValue)
                {
                    List<VWcsBidCreditdataQuestsRecord> ssqRecords = (new VWcsBidCreditdataQuests(con)).SelectBidCreditdataQuests(BID_ID, "CREDIT_SUM");
                    if (ssqRecords.Count > 0)
                        cmn.wp.ANSW_NUMB_SET(BID_ID, ssqRecords[0].QUESTION_ID, CreditSum.Value);
                }
                if (OwnFunds.Value.HasValue)
                {
                    List<VWcsBidCreditdataQuestsRecord> ssqRecords = (new VWcsBidCreditdataQuests(con)).SelectBidCreditdataQuests(BID_ID, "OWN_FUNDS");
                    if (ssqRecords.Count > 0)
                        cmn.wp.ANSW_NUMB_SET(BID_ID, ssqRecords[0].QUESTION_ID, OwnFunds.Value);
                }
                if (CreditTerm.Value.HasValue)
                {
                    List<VWcsBidCreditdataQuestsRecord> ssqRecords = (new VWcsBidCreditdataQuests(con)).SelectBidCreditdataQuests(BID_ID, "CREDIT_TERM");
                    if (ssqRecords.Count > 0)
                        cmn.wp.ANSW_NUMB_SET(BID_ID, ssqRecords[0].QUESTION_ID, CreditTerm.Value);
                }

                // создание контролов
                tpCalc_Load(sender, null);
                tc.ActiveTabIndex = 1;

                break;
        }
    }

    protected void tpCalc_Load(object sender, EventArgs e)
    {
        if (BID_ID.HasValue)
        {
            // заголовок
            lSbpTitle.Text = BidRecord.SUBPRODUCT_NAME;

            BbConnection con = new BbConnection();
            Common cmn = new Common(con);

            try
            {
                // создаем контролы
                GenerateControls(con, BID_ID, tdContainer);
            }
            finally
            {
                con.CloseConnection();
            }
        }
    }
    protected void tpCalc_PreRender(object sender, EventArgs e)
    {
        if (BID_ID.HasValue)
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
        }
    }

    public void ValueChanged(object sender, EventArgs e)
    {
        IsValuesChangedEvent = true;

        BbConnection con = new BbConnection();

        try
        {
            // сохраняем изменения если нет ошибок при заполнении
            SaveData(con, BID_ID, tdContainer);
            Master.HideError();

            // создаем контролы
            GenerateControls(con, BID_ID, tdContainer);
        }
        finally
        {
            con.CloseConnection();
        }
    }

    protected void bCalc_Click(object sender, EventArgs e)
    {
        if (IsValuesChangedEvent)
        {
            return;
        }

        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        try
        {
            // если ошибки при сохранении
            if (!SaveData(con, BID_ID, tdContainer)) return;

            // строим ГПК в таблицу
            con.InitConnection();
            Oracle.DataAccess.Client.OracleCommand cmd = con.CreateCommand("wcs_utl.store_gpk");
            
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("p_bid_id", Oracle.DataAccess.Client.OracleDbType.Decimal, BID_ID, ParameterDirection.Input);
            cmd.ExecuteNonQuery();

            sds.SelectParameters["BID_ID"].DefaultValue = Convert.ToString(BID_ID);
            gvGPK.DataBind();
        }
        finally
        {
            con.CloseConnection();
        }
    }
    protected void bPrint_Click(object sender, EventArgs e)
    {
        if (IsValuesChangedEvent)
        {
            return;
        }

        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        try
        {
            // если ошибки при сохранении
            if (!SaveData(con, BID_ID, tdContainer)) return;

            String PRT_TPL = cmn.wu.GET_SBP_MAC(BidRecord.SUBPRODUCT_ID, "MAC_PRINT_GPK_TEMPLATE");

            FrxParameters pars = new FrxParameters();
            pars.Add(new FrxParameter("p_subproduct_id", TypeCode.String, BidRecord.SUBPRODUCT_ID));
            pars.Add(new FrxParameter("p_bid_id", TypeCode.Decimal, BidRecord.BID_ID));

            FrxDoc doc = new FrxDoc(
                FrxDoc.GetTemplatePathByFileName(FrxDoc.GetTemplateFileNameByID(PRT_TPL)),
                pars,
                this.Page);

            doc.Print(FrxExportTypes.Pdf);
        }
        finally
        {
            con.CloseConnection();
        }
    }
    protected void bPreScoring_Click(object sender, EventArgs e)
    {
        if (IsValuesChangedEvent)
        {
            return;
        }

        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        try
        {
            // если ошибки при сохранении
            if (!SaveData(con, BID_ID, tdContainer)) return;

            ScriptManager.RegisterStartupScript(this, typeof(String), "redirect", "location.replace('/barsroot/credit/manager/bid_card.aspx?bid_id=" + Convert.ToString(BID_ID) + "');", true);
            cmn.wp.BID_STATE_DEL(BID_ID, "NEW_SBP_SELECTING");
        }
        finally
        {
            con.CloseConnection();
        }
    }

    protected override void OnPreRender(EventArgs e)
    {
        tpCalc.Visible = BID_ID.HasValue;

        base.OnPreRender(e);
    }
    # endregion

    # region Приватные методы
    private void GenerateControls(BbConnection con, Decimal? BID_ID, Control Container)
    {
        Common cmn = new Common(con, BID_ID);

        // контейнер вопросов
        HtmlTable ht = (Container.FindControl("containerTable") as HtmlTable);
        if (ht != null)
        {
            Container.Controls.Remove(ht);
            ht.Dispose();
        }

        ht = new HtmlTable();
        ht.ID = "containerTable";

        ht.Border = 0;
        ht.CellPadding = 0;
        ht.CellSpacing = 0;

        ht.Width = "99%";

        Container.Controls.Add(ht);

        // вопросы
        List<VWcsBidCreditdataQuestsRecord> ssqRecords = (new VWcsBidCreditdataQuests(con)).SelectBidCreditdataQuests(BID_ID);
        foreach (VWcsBidCreditdataQuestsRecord ssqRecord in ssqRecords)
        {
            // строчка вопроса
            HtmlTableRow htr = new HtmlTableRow();
            htr.ID = "htr_" + ssqRecord.CRDDATA_ID;

            HtmlTableCell htcTitle = new HtmlTableCell("td");
            htcTitle.Attributes.Add("class", "questionTitle");
            htcTitle.InnerText = ssqRecord.CRDDATA_NAME + " : ";

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
                    TEXT.IsRequired = true;
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
                    NUMB.IsRequired = true;
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
                    DECIMAL.IsRequired = true;
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
                    DATE.IsRequired = true;
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
                    LIST.IsRequired = true;
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
                    REFER.IsRequired = true;
                    REFER.ReadOnly = (ssqRecord.IS_CALCABLE == 0 ? false : true);
                    # endregion

                    break;
                case "BOOL":
                    # region BOOL
                    uc = (UserControl)Page.LoadControl("~/credit/usercontrols/RBLFlag.ascx");

                    RBLFlag BOOL = (RBLFlag)uc;
                    BOOL.ID = ssqRecord.QUESTION_ID;
                    BOOL.IsRequired = true;
                    BOOL.ReadOnly = (ssqRecord.IS_CALCABLE == 0 ? false : true);

                    BOOL.DefaultValue = (!BOOL_VAL_DEFAULT.HasValue ? BOOL.DefaultValue : (BOOL_VAL_DEFAULT.Value == 0 ? false : true));
                    # endregion

                    break;
            }
            # endregion

            // если вопрос имеет зависимые
            if (ssqRecord.HAS_REL == 1 && uc is IHasRelControls)
            {
                (uc as IHasRelControls).ValueChanged += new EventHandler(ValueChanged);
            }

            // дабавляем в контейнер
            htcControl.Controls.Add(uc);
        }
    }
    private void FillData(BbConnection con, Decimal? BID_ID, Control Container)
    {
        Common cmn = new Common(con);

        if (IsDataFilled) return;

        // вопросы
        List<VWcsBidCreditdataQuestsRecord> ssqRecords = (new VWcsBidCreditdataQuests(con)).SelectBidCreditdataQuests(BID_ID);
        foreach (VWcsBidCreditdataQuestsRecord ssqRecord in ssqRecords)
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

            cmn.wu.GET_QUEST_PARAMS(BID_ID, ssqRecord.QUESTION_ID, out TEXT_LENG_MIN, out TEXT_LENG_MAX, out TEXT_VAL_DEFAULT, out TEXT_WIDTH, out TEXT_ROWS, out NMBDEC_VAL_MIN, out NMBDEC_VAL_MAX, out NMBDEC_VAL_DEFAULT, out DAT_VAL_MIN, out DAT_VAL_MAX, out DAT_VAL_DEFAULT, out LIST_SID_DEFAULT, out REFER_SID_DEFAULT, out TAB_ID, out KEY_FIELD, out SEMANTIC_FIELD, out SHOW_FIELDS, out WHERE_CLAUSE, out BOOL_VAL_DEFAULT);

            // удаляем неправильные значения
            if (ssqRecord.IS_CHECKABLE == 1)
            {
                String CheckResult = cmn.wu.EXEC_CHECK(BID_ID, ssqRecord.CHECK_PROC);
                if (CheckResult != null)
                {
                    cmn.wp.ANSW_DEL(BID_ID, ssqRecord.QUESTION_ID);
                }
            }

            // если вопрос вычисляемый, то вычисляем его
            if (ssqRecord.IS_CALCABLE == 1) cmn.wu.CALC_ANSW(BID_ID, ssqRecord.QUESTION_ID);
            Decimal? HasAnsw = cmn.wu.HAS_ANSW(BID_ID, ssqRecord.QUESTION_ID);

            // контрол
            UserControl uc = (Container.FindControl(ssqRecord.QUESTION_ID) as UserControl);

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

        IsDataFilled = true;
    }
    private Boolean SaveData(BbConnection con, Decimal? BID_ID, Control Container)
    {
        Common cmn = new Common(con, BID_ID);

        if (IsDataSaved) return SaveResult;

        // проверки
        Master.HideError();

        // вопросы группы
        List<VWcsBidCreditdataQuestsRecord> ssqRecords = (new VWcsBidCreditdataQuests(con)).SelectBidCreditdataQuests(BID_ID);
        foreach (VWcsBidCreditdataQuestsRecord ssqRecord in ssqRecords)
        {
            // если вопрос вычисляемый, то вычисляем его
            if (ssqRecord.IS_CALCABLE == 1)
            {
                cmn.wu.CALC_ANSW(BID_ID, ssqRecord.QUESTION_ID);
            }

            // контрол
            UserControl uc = (Container.FindControl(ssqRecord.QUESTION_ID) as UserControl);

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

            // проверочная фукнция
            if (ssqRecord.IS_CHECKABLE == 1)
            {
                String CheckResult = cmn.wu.EXEC_CHECK(BID_ID, ssqRecord.CHECK_PROC);
                if (CheckResult != null)
                {
                    Master.ShowError(String.Format(Resources.credit.StringConstants.text_question_check_error_ptrn, ssqRecord.QUESTION_ID, ssqRecord.QUESTION_NAME, CheckResult));
                    IsDataSaved = true;
                    SaveResult = false;
                    return false;
                }
            }
        }

        IsDataSaved = true;
        SaveResult = true;
        return true;
    }
    # endregion
}