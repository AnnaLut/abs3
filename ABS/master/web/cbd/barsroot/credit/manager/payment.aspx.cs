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

public partial class credit_manager_payment : Bars.BarsPage
{
    # region Приватные свойства
    private Decimal? BID_ID
    {
        get
        {
            return Convert.ToDecimal(Request.Params.Get("bid_id"));
        }
    }
    # endregion

    # region Публичные свойства
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        // заголовок
        Master.SetPageTitle(this.Title + Convert.ToString(BID_ID), true);

        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        try
        {
            // чекаут состояния
            if (!IsPostBack) cmn.wp.BID_STATE_CHECK_OUT(BID_ID, "NEW_PARTNER", (String)null);
        }
        finally
        {
            con.CloseConnection();
        }
    }
    protected void rblPaymentTypes_SelectedIndexChanged(object sender, EventArgs e)
    {
        switch (rblPaymentTypes.SelectedValue)
        {
            case "CURACC":
                mv.ActiveViewIndex = 0;
                break;
            case "CARDACC":
                PI_CARDACC_ACCNO.BID_ID = BID_ID;
                mv.ActiveViewIndex = 1;
                break;
            case "PARTNER":
                mv.ActiveViewIndex = 2;
                break;
            case "FREE":
                mv.ActiveViewIndex = 3;
                break;
            case "CASH":
                PI_CASH_BRANCH.BID_ID = BID_ID;
                mv.ActiveViewIndex = 4;
                break;
        }
    }
    public void PARTNER_TYPE_ValueChanged(object sender, EventArgs e)
    {
        PI_PARTNER_ID.DataBind();
    }
    protected void bNext_Click(object sender, EventArgs e)
    {
        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        try
        {
            // сохраняем если нет ошибок при заполнении
            if (SaveData(con, BID_ID))
            {
                // чекин состояния и чистка сессии
                cmn.wp.BID_STATE_CHECK_IN(BID_ID, "NEW_PARTNER", (String)null);

                // завершаем состояние и переходим на след
                cmn.wp.BID_STATE_DEL(BID_ID, "NEW_PARTNER");

                // возвращаемся в карточку заявки
                Response.Redirect(String.Format("/barsroot/credit/manager/bid_card.aspx?bid_id={0}", BID_ID.ToString()));
            }
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
            if (!IsPostBack) FillData(con, BID_ID);
        }
        finally
        {
            con.CloseConnection();
        }

        base.OnPreRender(e);
    }
    # endregion

    # region Приватные методы
    private void FillData(BbConnection con, Decimal? BID_ID)
    {
        Common cmn = new Common(con, BID_ID);

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

        //Параметры "Рахунок"
        cmn.wu.GET_QUEST_PARAMS(BID_ID, PI_FREE_NLS.ID, out TEXT_LENG_MIN, out TEXT_LENG_MAX, out TEXT_VAL_DEFAULT, out TEXT_WIDTH, out TEXT_ROWS, out NMBDEC_VAL_MIN, out NMBDEC_VAL_MAX, out NMBDEC_VAL_DEFAULT, out DAT_VAL_MIN, out DAT_VAL_MAX, out DAT_VAL_DEFAULT, out LIST_SID_DEFAULT, out REFER_SID_DEFAULT, out TAB_ID, out KEY_FIELD, out SEMANTIC_FIELD, out SHOW_FIELDS, out WHERE_CLAUSE, out BOOL_VAL_DEFAULT);
        PI_FREE_NLS.MinLength = (TEXT_LENG_MIN == null ? PI_FREE_NLS.MinLength : Convert.ToInt32(TEXT_LENG_MIN));
        PI_FREE_NLS.MaxLength = (TEXT_LENG_MAX == null ? PI_FREE_NLS.MaxLength : Convert.ToInt32(TEXT_LENG_MAX));
        PI_FREE_NLS.Width = (TEXT_WIDTH == null ? PI_FREE_NLS.Width : Convert.ToInt32(TEXT_WIDTH));
        PI_FREE_NLS.Rows = (TEXT_ROWS == null ? PI_FREE_NLS.Rows : Convert.ToInt32(TEXT_ROWS));

        //Параметры "Найменування"
        cmn.wu.GET_QUEST_PARAMS(BID_ID, PI_FREE_NAME.ID, out TEXT_LENG_MIN, out TEXT_LENG_MAX, out TEXT_VAL_DEFAULT, out TEXT_WIDTH, out TEXT_ROWS, out NMBDEC_VAL_MIN, out NMBDEC_VAL_MAX, out NMBDEC_VAL_DEFAULT, out DAT_VAL_MIN, out DAT_VAL_MAX, out DAT_VAL_DEFAULT, out LIST_SID_DEFAULT, out REFER_SID_DEFAULT, out TAB_ID, out KEY_FIELD, out SEMANTIC_FIELD, out SHOW_FIELDS, out WHERE_CLAUSE, out BOOL_VAL_DEFAULT);
        PI_FREE_NAME.MinLength = (TEXT_LENG_MIN == null ? PI_FREE_NAME.MinLength : Convert.ToInt32(TEXT_LENG_MIN));
        PI_FREE_NAME.MaxLength = (TEXT_LENG_MAX == null ? PI_FREE_NAME.MaxLength : Convert.ToInt32(TEXT_LENG_MAX));
        PI_FREE_NAME.Width = (TEXT_WIDTH == null ? PI_FREE_NAME.Width : Convert.ToInt32(TEXT_WIDTH));
        PI_FREE_NAME.Rows = (TEXT_ROWS == null ? PI_FREE_NAME.Rows : Convert.ToInt32(TEXT_ROWS));
        
        // заполняем форму
        rblPaymentTypes.DataBind();

        if (1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_SIGNDOCS"))
        {
            pnlPaymentTypes.Enabled = false;
            PI_FREE_MFO.IsRequired = true;
            PI_FREE_NLS.IsRequired = true;
            PI_FREE_OKPO.IsRequired = true;
            PI_FREE_NAME.IsRequired = true;
        }

        if (cmn.wu.GET_ANSW_BOOL(BID_ID, "PI_CURACC_SELECTED") == 1)
        {
            rblPaymentTypes.Items.FindByValue("CURACC").Selected = true;
        }
        if (cmn.wu.GET_ANSW_BOOL(BID_ID, "PI_CARDACC_SELECTED") == 1)
        {
            rblPaymentTypes.Items.FindByValue("CARDACC").Selected = true;
            PI_CARDACC_ACCNO.BID_ID = BID_ID;
            PI_CARDACC_ACCNO.Value = cmn.wu.GET_ANSW_REFER(BID_ID, "PI_CARDACC_ACCNO");
        }
        if (cmn.wu.GET_ANSW_BOOL(BID_ID, "PI_PARTNER_SELECTED") == 1)
        {
            rblPaymentTypes.Items.FindByValue("PARTNER").Selected = true;
            Decimal? PARTNER_ID = cmn.wu.GET_ANSW_NUMB(BID_ID, "PI_PARTNER_ID");

            PARTNER_TYPE.DataBind();
            if (PARTNER_ID.HasValue)
                PARTNER_TYPE.SelectedValue = (new VWcsBidPartners()).SelectBidPartner(BID_ID, PARTNER_ID)[0].TYPE_ID;

            PI_PARTNER_ID.DataBind();
            if (PARTNER_ID.HasValue)
                PI_PARTNER_ID.Value = PARTNER_ID;
        }
        if (cmn.wu.GET_ANSW_BOOL(BID_ID, "PI_FREE_SELECTED") == 1)
        {
            rblPaymentTypes.Items.FindByValue("FREE").Selected = true;
            PI_FREE_MFO.Value = cmn.wu.GET_ANSW_TEXT(BID_ID, "PI_FREE_MFO");
            PI_FREE_NLS.Value = cmn.wu.GET_ANSW_TEXT(BID_ID, "PI_FREE_NLS");
            PI_FREE_OKPO.Value = cmn.wu.GET_ANSW_TEXT(BID_ID, "PI_FREE_OKPO");
            PI_FREE_NAME.Value = cmn.wu.GET_ANSW_TEXT(BID_ID, "PI_FREE_NAME");

        }
        if (cmn.wu.GET_ANSW_BOOL(BID_ID, "PI_CASH_SELECTED") == 1)
        {
            cmn.wu.GET_QUEST_PARAMS(BID_ID, PI_CASH_BRANCH.QUESTION_ID, out TEXT_LENG_MIN, out TEXT_LENG_MAX, out TEXT_VAL_DEFAULT, out TEXT_WIDTH, out TEXT_ROWS, out NMBDEC_VAL_MIN, out NMBDEC_VAL_MAX, out NMBDEC_VAL_DEFAULT, out DAT_VAL_MIN, out DAT_VAL_MAX, out DAT_VAL_DEFAULT, out LIST_SID_DEFAULT, out REFER_SID_DEFAULT, out TAB_ID, out KEY_FIELD, out SEMANTIC_FIELD, out SHOW_FIELDS, out WHERE_CLAUSE, out BOOL_VAL_DEFAULT);

            rblPaymentTypes.Items.FindByValue("CASH").Selected = true;
            PI_CASH_BRANCH.BID_ID = BID_ID;
            PI_CASH_BRANCH.Value = cmn.wu.GET_ANSW_REFER(BID_ID, PI_CASH_BRANCH.QUESTION_ID);
        }

        rblPaymentTypes_SelectedIndexChanged(rblPaymentTypes, null);
    }
    private Boolean Validate(BbConnection con, Decimal? BID_ID)
    {
        Common cmn = new Common(con, BID_ID);

        // проверки
        Master.HideError();

        // проверяем
        switch (rblPaymentTypes.SelectedValue)
        {
            case "CURACC":
                break;
            case "CARDACC":
                // !!! Добавить проверку карточного счета на принадлежность клиенту, балонсовый счет, контрольную сумму
                // PI_CARDACC_ACCNO.Value;
                break;
            case "PARTNER":
                // вроде проверок нет
                break;
            case "FREE":
                // проверить МФО на справочник (а лучше дать выбор МФО из справочника)
                // проверить контрольный разряд ОКПО
                // дать возможность ввода назначения и нескольких платежей

                String FREE_MFO = PI_FREE_MFO.Value;
                if (PI_FREE_NLS.Value != CheckNLSByMFO(PI_FREE_MFO.Value, PI_FREE_NLS.Value))
                {
                    Master.ShowError("Неверный контрольный разряд счета");
                    return false;
                }
                break;
            case "CASH":
                // вроде проверок нет
                if (String.IsNullOrEmpty(PI_CASH_BRANCH.Value))
                {
                    return false;
                }
                break;
        }

        return true;
    }
    private void ClearData(BbConnection con, Decimal? BID_ID)
    {
        Common cmn = new Common(con, BID_ID);

        cmn.wp.ANSW_BOOL_SET(BID_ID, "PI_CURACC_SELECTED", 0);

        cmn.wp.ANSW_BOOL_SET(BID_ID, "PI_CARDACC_SELECTED", 0);
        cmn.wp.ANSW_DEL(BID_ID, "PI_CARDACC_ACCNO");

        cmn.wp.ANSW_BOOL_SET(BID_ID, "PI_PARTNER_SELECTED", 0);
        cmn.wp.ANSW_DEL(BID_ID, "PI_PARTNER_ID");

        cmn.wp.ANSW_BOOL_SET(BID_ID, "PI_FREE_SELECTED", 0);
        cmn.wp.ANSW_DEL(BID_ID, "PI_FREE_MFO");
        cmn.wp.ANSW_DEL(BID_ID, "PI_FREE_NLS");
        cmn.wp.ANSW_DEL(BID_ID, "PI_FREE_OKPO");
        cmn.wp.ANSW_DEL(BID_ID, "PI_FREE_NAME");

        cmn.wp.ANSW_BOOL_SET(BID_ID, "PI_CASH_SELECTED", 0);
        cmn.wp.ANSW_DEL(BID_ID, "PI_CASH_BRANCH");
    }
    private Boolean SaveData(BbConnection con, Decimal? BID_ID)
    {
        Common cmn = new Common(con, BID_ID);

        // проверки
        if (!Validate(con, BID_ID)) return false;

        // чистим системные вопросы
        ClearData(con, BID_ID);

        // сохраняем системные вопросы
        Trace.Write("rblPaymentTypes.SelectedValue = " + rblPaymentTypes.SelectedValue);
        switch (rblPaymentTypes.SelectedValue)
        {
            case "CURACC":
                cmn.wp.ANSW_BOOL_SET(BID_ID, "PI_CURACC_SELECTED", 1);
                break;
            case "CARDACC":
                cmn.wp.ANSW_BOOL_SET(BID_ID, "PI_CARDACC_SELECTED", 1);
                cmn.wp.ANSW_REF_SET(BID_ID, "PI_CARDACC_ACCNO", PI_CARDACC_ACCNO.Value);
                break;
            case "PARTNER":
                cmn.wp.ANSW_BOOL_SET(BID_ID, "PI_PARTNER_SELECTED", 1);
                cmn.wp.ANSW_NUMB_SET(BID_ID, "PI_PARTNER_ID", PI_PARTNER_ID.Value);
                break;
            case "FREE":
                cmn.wp.ANSW_BOOL_SET(BID_ID, "PI_FREE_SELECTED", 1);
                cmn.wp.ANSW_TEXT_SET(BID_ID, "PI_FREE_MFO", PI_FREE_MFO.Value);
                cmn.wp.ANSW_TEXT_SET(BID_ID, "PI_FREE_NLS", PI_FREE_NLS.Value);
                cmn.wp.ANSW_TEXT_SET(BID_ID, "PI_FREE_OKPO", PI_FREE_OKPO.Value);
                cmn.wp.ANSW_TEXT_SET(BID_ID, "PI_FREE_NAME", PI_FREE_NAME.Value);
                break;
            case "CASH":
                cmn.wp.ANSW_BOOL_SET(BID_ID, "PI_CASH_SELECTED", 1);
                cmn.wp.ANSW_REF_SET(BID_ID, "PI_CASH_BRANCH", PI_CASH_BRANCH.Value);
                break;
        }

        return true;
    }
    private String CheckNLSByMFO(string MFO, string NLS)
    {
        string sNewNLS = String.IsNullOrEmpty(NLS) ? "": NLS.Substring(0, 4) + "0" + NLS.Substring(5);
        MFO = String.IsNullOrEmpty(MFO) ? "" : MFO;
        string m1 = "137130";
        string m2 = "37137137137137";
        int j = 0;
            for (int i = 0; i < MFO.Length; i++)
            {
                j = j + Convert.ToInt16(MFO.Substring(i, 1)) * Convert.ToInt16(m1.Substring(i, 1)); 
            }

            for (int i = 0; i < sNewNLS.Length; i++)
            { 
                j = j + Convert.ToInt16(sNewNLS.Substring(i, 1)) * Convert.ToInt16(m2.Substring(i, 1)); 
            }

            if (String.IsNullOrEmpty(sNewNLS))
            {
                return null;
            }

            return sNewNLS.Substring(0, 4) +
               Convert.ToString((((j + sNewNLS.Length) * 7) % 10)) +
               sNewNLS.Substring(5);
        }
    # endregion
}