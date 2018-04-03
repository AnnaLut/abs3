using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

using Bars.Extenders.Controls;
using Bars.Classes;
using Bars.DataComponents;
using ibank.core;
using credit;

public partial class credit_constructor_wcsscoringballs : System.Web.UI.Page
{
    # region Приватные свойства
    private VWcsQuestionsRecord _QuestionRecord;
    # endregion

    # region Публичные свойства
    public String SCORING_ID
    {
        get
        {
            return Request.Params.Get("scoring_id");
        }
    }
    public String QUESTION_ID
    {
        get
        {
            return Request.Params.Get("question_id");
        }
    }
    public VWcsQuestionsRecord QuestionRecord
    {
        get
        {
            if (_QuestionRecord == null)
            {
                List<VWcsQuestionsRecord> lst = (new VWcsQuestions()).SelectQuestion(QUESTION_ID);
                if (lst.Count > 0)
                    _QuestionRecord = lst[0];
            }

            return _QuestionRecord;
        }
    }
    public String BackPageUrl
    {
        get
        {
            return Convert.ToString(ViewState["BackPageUrl"]);
        }
        set
        {
            ViewState.Add("BackPageUrl", value);
        }
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.UrlReferrer != null)
                BackPageUrl = Request.UrlReferrer.PathAndQuery;
        }

        Master.SetPageTitle(this.Title + " вопроса " + QUESTION_ID + " (карта " + SCORING_ID + ")", true);
        Master.SetPageTitleUrl(BackPageUrl, true);

        // пределяем тип вопроса
        switch (QuestionRecord.TYPE_ID)
        {
            case "NUMB":
                mvTypes.ActiveViewIndex = 0;
                break;
            case "DECIMAL":
                mvTypes.ActiveViewIndex = 1;
                break;
            case "DATE":
                mvTypes.ActiveViewIndex = 2;
                break;
            case "LIST":
                mvTypes.ActiveViewIndex = 3;
                break;
            case "BOOL":
                mvTypes.ActiveViewIndex = 4;
                break;
        }
    }

    protected void fvWcsScoringQsNumb_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        gvVWcsScoringQsNumb.DataBind();
    }
    protected void fvWcsScoringQsNumb_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        gvVWcsScoringQsNumb.DataBind();
    }
    protected void fvWcsScoringQsNumb_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        gvVWcsScoringQsNumb.DataBind();
    }
    protected void fvWcsScoringQsNumb_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        e.Values["SCORING_ID"] = SCORING_ID;
        e.Values["QUESTION_ID"] = QUESTION_ID;
        e.Values["ORD"] = (Decimal?)null;
    }

    protected void fvWcsScoringQsDecimal_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        gvVWcsScoringQsDecimal.DataBind();
    }
    protected void fvWcsScoringQsDecimal_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        gvVWcsScoringQsDecimal.DataBind();
    }
    protected void fvWcsScoringQsDecimal_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        gvVWcsScoringQsDecimal.DataBind();
    }
    protected void fvWcsScoringQsDecimal_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        e.Values["SCORING_ID"] = SCORING_ID;
        e.Values["QUESTION_ID"] = QUESTION_ID;
        e.Values["ORD"] = (Decimal?)null;
    }

    protected void fvWcsScoringQsDate_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        gvVWcsScoringQsDate.DataBind();
    }
    protected void fvWcsScoringQsDate_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        gvVWcsScoringQsDate.DataBind();
    }
    protected void fvWcsScoringQsDate_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        gvVWcsScoringQsDate.DataBind();
    }
    protected void fvWcsScoringQsDate_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        e.Values["SCORING_ID"] = SCORING_ID;
        e.Values["QUESTION_ID"] = QUESTION_ID;
        e.Values["ORD"] = (Decimal?)null;
    }
    /*
    protected void gvVWcsScoringQsDecimal_DataBound(object sender, EventArgs e)
    {
        if (!IsPostBack && gvVWcsScoringQsDecimal.Rows.Count > 0) gvVWcsScoringQsDecimal.SelectedIndex = 0;
    }
    protected void fvVWcsScoringQsDecimal_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        gvVWcsScoringQsDecimal.DataBind();
    }
    protected void fvVWcsScoringQsDecimal_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        gvVWcsScoringQsDecimal.DataBind();
    }
    protected void fvVWcsScoringQsDecimal_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        e.Values.Add("SCORING_ID", Master.SCORING_ID);
        e.Values.Add("QUESTION_ID", Master.QUESTION_ID);
    }
    protected void fvVWcsScoringQsDecimal_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        gvVWcsScoringQsDecimal.DataBind();
    }

    protected void gvVWcsScoringQsDate_DataBound(object sender, EventArgs e)
    {
        if (!IsPostBack && gvVWcsScoringQsDate.Rows.Count > 0) gvVWcsScoringQsDate.SelectedIndex = 0;
    }
    protected void fvVWcsScoringQsDate_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        gvVWcsScoringQsDate.DataBind();
    }
    protected void fvVWcsScoringQsDate_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        gvVWcsScoringQsDate.DataBind();
    }
    protected void fvVWcsScoringQsDate_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        e.Values.Add("SCORING_ID", Master.SCORING_ID);
        e.Values.Add("QUESTION_ID", Master.QUESTION_ID);
    }
    protected void fvVWcsScoringQsDate_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        gvVWcsScoringQsDate.DataBind();
    }

    protected void gvVWcsScoringQsList_DataBound(object sender, EventArgs e)
    {
        if (!IsPostBack && gvVWcsScoringQsList.Rows.Count > 0) gvVWcsScoringQsList.SelectedIndex = 0;
    }
    protected void fvVWcsScoringQsList_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        gvVWcsScoringQsList.DataBind();
    }
    protected void fvVWcsScoringQsList_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        gvVWcsScoringQsList.DataBind();
    }
    protected void fvVWcsScoringQsList_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        e.Values.Add("SCORING_ID", Master.SCORING_ID);
        e.Values.Add("QUESTION_ID", Master.QUESTION_ID);
    }
    protected void fvVWcsScoringQsList_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        gvVWcsScoringQsList.DataBind();
    }

    protected void gvVWcsQuestionMatrixParams_DataBound(object sender, EventArgs e)
    {
        if (!IsPostBack && gvVWcsQuestionMatrixParams.Rows.Count > 0) gvVWcsQuestionMatrixParams.SelectedIndex = 0;
    }
    protected void fvVWcsQuestionMatrixParams_DataBound(object sender, EventArgs e)
    {
        FormView fv = (sender as FormView);
        String TYPE_ID = (fv.DataItem as VWcsQuestionMatrixParamsRecord).TYPE_ID;
        MultiView mvMatrixTypes = (fvVWcsQuestionMatrixParams.FindControl("mvMatrixTypes") as MultiView);

        switch (TYPE_ID)
        {
            case "NUMB":
                mvMatrixTypes.ActiveViewIndex = 0;
                break;
            case "DECIMAL":
                mvMatrixTypes.ActiveViewIndex = 1;
                break;
            case "DATE":
                mvMatrixTypes.ActiveViewIndex = 2;
                break;
            case "LIST":
                mvMatrixTypes.ActiveViewIndex = 3;
                break;
            case "BOOL":
                mvMatrixTypes.ActiveViewIndex = 4;
                break;
        }
    }

    protected void gvVWcsScoringQsMatrixNumb_DataBound(object sender, EventArgs e)
    {
        BarsGridViewEx gv = (sender as BarsGridViewEx);
        if (!IsPostBack && gv.Rows.Count > 0) gv.SelectedIndex = 0;
    }
    protected void fvVWcsScoringQsMatrixNumb_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        BarsGridViewEx gv = (fvVWcsQuestionMatrixParams.FindControl("gvVWcsScoringQsMatrixNumb") as BarsGridViewEx);
        gv.DataBind();
    }
    protected void fvVWcsScoringQsMatrixNumb_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        BarsGridViewEx gv = (fvVWcsQuestionMatrixParams.FindControl("gvVWcsScoringQsMatrixNumb") as BarsGridViewEx);
        gv.DataBind();
    }
    protected void fvVWcsScoringQsMatrixNumb_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        e.Values.Add("SCORING_ID", Master.SCORING_ID);
        e.Values.Add("QUESTION_ID", Master.QUESTION_ID);
        e.Values.Add("AXIS_QID", gvVWcsQuestionMatrixParams.SelectedValue.ToString());
    }
    protected void fvVWcsScoringQsMatrixNumb_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        BarsGridViewEx gv = (fvVWcsQuestionMatrixParams.FindControl("gvVWcsScoringQsMatrixNumb") as BarsGridViewEx);
        gv.DataBind();
    }

    protected void gvVWcsScoringQsMatrixDec_DataBound(object sender, EventArgs e)
    {
        BarsGridViewEx gv = (sender as BarsGridViewEx);
        if (!IsPostBack && gv.Rows.Count > 0) gv.SelectedIndex = 0;
    }
    protected void fvVWcsScoringQsMatrixDec_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        BarsGridViewEx gv = (fvVWcsQuestionMatrixParams.FindControl("gvVWcsScoringQsMatrixDec") as BarsGridViewEx);
        gv.DataBind();
    }
    protected void fvVWcsScoringQsMatrixDec_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        BarsGridViewEx gv = (fvVWcsQuestionMatrixParams.FindControl("gvVWcsScoringQsMatrixDec") as BarsGridViewEx);
        gv.DataBind();
    }
    protected void fvVWcsScoringQsMatrixDec_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        e.Values.Add("SCORING_ID", Master.SCORING_ID);
        e.Values.Add("QUESTION_ID", Master.QUESTION_ID);
        e.Values.Add("AXIS_QID", gvVWcsQuestionMatrixParams.SelectedValue.ToString());
    }
    protected void fvVWcsScoringQsMatrixDec_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        BarsGridViewEx gv = (fvVWcsQuestionMatrixParams.FindControl("gvVWcsScoringQsMatrixDec") as BarsGridViewEx);
        gv.DataBind();
    }

    protected void gvVWcsScoringQsMatrixDate_DataBound(object sender, EventArgs e)
    {
        BarsGridViewEx gv = (sender as BarsGridViewEx);
        if (!IsPostBack && gv.Rows.Count > 0) gv.SelectedIndex = 0;
    }
    protected void fvVWcsScoringQsMatrixDate_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        BarsGridViewEx gv = (fvVWcsQuestionMatrixParams.FindControl("gvVWcsScoringQsMatrixDate") as BarsGridViewEx);
        gv.DataBind();
    }
    protected void fvVWcsScoringQsMatrixDate_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        BarsGridViewEx gv = (fvVWcsQuestionMatrixParams.FindControl("gvVWcsScoringQsMatrixDate") as BarsGridViewEx);
        gv.DataBind();
    }
    protected void fvVWcsScoringQsMatrixDate_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        e.Values.Add("SCORING_ID", Master.SCORING_ID);
        e.Values.Add("QUESTION_ID", Master.QUESTION_ID);
        e.Values.Add("AXIS_QID", gvVWcsQuestionMatrixParams.SelectedValue.ToString());
    }
    protected void fvVWcsScoringQsMatrixDate_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        BarsGridViewEx gv = (fvVWcsQuestionMatrixParams.FindControl("gvVWcsScoringQsMatrixDate") as BarsGridViewEx);
        gv.DataBind();
    }

    protected void gvWcsQuestionBoolItems_OnPreRender(object sender, EventArgs e)
    {
        BarsGridViewEx gv = (sender as BarsGridViewEx);
        if (gv.Rows.Count == 0)
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("ORD", typeof(Decimal));
            dt.Columns.Add("TEXT", typeof(String));

            dt.Rows.Add(0, "Нет");
            dt.Rows.Add(1, "Да");

            gv.DataSource = dt;
            gv.DataBind();
        }
    }
    protected void ibSaveBOOL_Click(object sender, ImageClickEventArgs e)
    {
        WcsScoringQsBool.SCORE_IF_0 = SCORE_IF_0TextBox.Value;
        WcsScoringQsBool.SCORE_IF_1 = SCORE_IF_1TextBox.Value;
        (new VWcsScoringQsBool()).Update(WcsScoringQsBool);
    }

    protected void gvVWcsScoringQsMatrix_DataBound(object sender, EventArgs e)
    {
        // выделяем первую строчку
        BarsGridViewEx gv = (sender as BarsGridViewEx);

        // управляем колонками
        String QUESTION_ID = Master.QUESTION_ID;
        List<VWcsQuestionMatrixParamsRecord> qmpRecords = (new VWcsQuestionMatrixParams()).SelectQuestionMatrixParams(QUESTION_ID);

        for (int i = 0; i < qmpRecords.Count; i++)
        {
            VWcsQuestionMatrixParamsRecord rec = qmpRecords[i];
            gv.Columns[i + 1].HeaderText = rec.AXIS_QID;
        }

        for (int i = qmpRecords.Count; i < 5; i++)
        {
            gv.Columns[i + 1].Visible = false;
        }
    }
    */
    # endregion

    # region Приватные методы
    # endregion
}