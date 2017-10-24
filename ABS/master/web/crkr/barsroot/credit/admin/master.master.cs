using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using System.Collections.Generic;
using Bars.Exception;
using credit;

using ibank.core;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Classes;
using Bars.UserControls;

public partial class master_admin : System.Web.UI.MasterPage
{
    # region Приватные свойства
    # endregion

    # region Публичные свойства
    public String AlertPattern = "alert('{0}');";
    public String TitleFormat = "{0} - {1}";
    # endregion

    # region Публичные методы
    /// <summary>
    /// Заголовок страницы
    /// </summary>
    public void SetPageTitle(String Title, Boolean OverWrite)
    {
        if (String.IsNullOrEmpty(lbPageTitle.Text) || OverWrite)
            lbPageTitle.Text = Title;
    }
    public void SetPageTitle(String Title)
    {
        SetPageTitle(Title, false);
    }

    /// <summary>
    /// Отображение ошибок
    /// </summary>
    public void ShowError(String ErrorText)
    {
        dvErrorBlock.Style.Add(HtmlTextWriterStyle.Display, "block");
        lbErrorText.Text += (String.IsNullOrEmpty(lbErrorText.Text) ? "" : "<br/>") + ErrorText;
    }
    public void HideError()
    {
        dvErrorBlock.Style.Add(HtmlTextWriterStyle.Display, "none");
        lbErrorText.Text = "";
    }

    /// <summary>
    /// Чистка временных параметров сессии
    /// </summary>
    public void ClearSessionScans()
    {
        String Prefix1 = "IMAGE_DATA_";
        String Prefix2 = "SCANER_DATA_";

        System.Collections.ArrayList SessionKeys = new System.Collections.ArrayList(Session.Keys);
        for (int i = 0; i < SessionKeys.Count; i++)
        {
            String key = (String)SessionKeys[i];
            if (key.StartsWith(Prefix1) || key.StartsWith(Prefix2))
            {
                Object obj = Session[key];
                if (obj is IDisposable)
                    (obj as IDisposable).Dispose();
                Session.Remove(key);
            }
        }

    }

    /*public String get_SUBPRODUCT_ID(BbConnection con, Decimal? BID_ID)
    {
        WcsBids tab = new WcsBids(con);
        List<WcsBidsRecord> recs = tab.Select(BID_ID.Value);

        if (recs.Count == 0) throw new BarsException("Заявка №" + Convert.ToString(BID_ID) + " не найдена");
        else return recs[0].SUBPRODUCT_ID;
    }
    public String get_ParsedFormHtml(BbConnection con, Decimal? BID_ID, String FORM_ID)
    {
        WcsForms tab = new WcsForms(con);
        List<WcsFormsRecord> recs = tab.Select(FORM_ID, (String)null);

        if (recs.Count > 0)
        {
            WcsUtl wu = get_wu(con);
            return wu.PARSE_SQL(BID_ID, recs[0].HTML);
        }
        else
        {
            return "Form " + FORM_ID + " not defined";
        }
    }
    public VWcsAnswersRecord get_AnswerObj(BbConnection con, Decimal? BID_ID, String QUESTION_ID)
    {
        // берем параметры вопроса
        VWcsQuestions tab = new VWcsQuestions(con);
        List<VWcsQuestionsRecord> recs = tab.SelectQuestions(QUESTION_ID);

        if (recs.Count == 0) throw new BarsException("Вопрос " + QUESTION_ID + " не найден");
        VWcsQuestionsRecord rec = recs[0];

        // вычисляем вычисляемые вопросы
        if (rec.IS_CALCABLE == 1)
        {
            WcsUtl wu = get_wu(con);
            wu.CALC_ANSW(BID_ID, QUESTION_ID);
        }

        // берем ответ
        VWcsAnswers tab1 = new VWcsAnswers(con);
        List<VWcsAnswersRecord> recs1 = tab1.SelectAnswers(BID_ID, QUESTION_ID);
        VWcsAnswersRecord rec1 = (recs1.Count > 0 ? recs1[0] : null);

        return rec1;
    }
    public VWcsSubproductMacsRecord get_MACObject(BbConnection con, Decimal? BID_ID, String MAC_ID)
    {
        VWcsSubproductMacs tab = new VWcsSubproductMacs(con);
        List<VWcsSubproductMacsRecord> recs = tab.SelectSubproductMac(get_SUBPRODUCT_ID(con, BID_ID), MAC_ID);

        return (recs.Count > 0 ? recs[0] : null);
    }


    public void CheckSessionParams(List<String> SessionParams)
    {
        foreach (String SessionParam in SessionParams)
        {
            if (Session[SessionParam] == null) throw new BarsException("Не заданы необходимые параметры");
        }
    }



    public void RejectBid(BbConnection con, Decimal? BID_ID, String STATE_ID)
    {
        WcsPack wp = get_wp(con);
        Bl bl = get_bl(con);

        // отменяем заполнение заявки
        // код постановки в блок лист
        Decimal Blk = 161;

        // комментарий
        String Comment = "Менеджер нажал кнопку 'Отклонить' при вводе заявки";

        // чекин состояния
        wp.BID_STATE_CHECK_IN(BID_ID, STATE_ID, Comment);

        // постановка в блок лист
        bl.SETBLOCKLIST((String)null, Blk, Comment, BID_ID, 0, (DateTime?)null, (String)null, (String)null, (String)null, (DateTime?)null, (String)null, (String)null, (DateTime?)null, (String)null);

        // ставим заявке состояние отказать
        wp.BID_STATE_SET_IMMEDIATE(BID_ID, "NEW_DENY", Comment);

        // чекаут состояния
        wp.BID_STATE_CHECK_OUT(BID_ID, "NEW_DENY", Comment);
    }

    public Boolean HasState(BbConnection con, Decimal? BID_ID, String STATE_ID)
    {
        List<VWcsBidStatesRecord> BsRecords = (new VWcsBidStates()).SelectBidStates(BID_ID);
        foreach (VWcsBidStatesRecord bsRecord in BsRecords)
            if (bsRecord.STATE_ID == STATE_ID) return true;

        return false;
    }
    public Boolean HasState(BbConnection con, Decimal? BID_ID, ArrayList STATES_ID)
    {
        List<VWcsBidStatesRecord> BsRecords = (new VWcsBidStates()).SelectBidStates(BID_ID);
        foreach (VWcsBidStatesRecord bsRecord in BsRecords)
            if (STATES_ID.Contains(bsRecord.STATE_ID)) return true;

        return false;
    }*/
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected override void OnPreRender(EventArgs e)
    {
        // устанавливаем заголовок страницы если он не пустой
        if (!String.IsNullOrEmpty(Page.Header.Title))
            SetPageTitle(Page.Header.Title);

        base.OnPreRender(e);
    }
    # endregion
}
