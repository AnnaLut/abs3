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

using Bars.DataComponents;
using Bars.UserControls;
using credit;

public partial class credit_constructor_wcssurveygroupquestions : Bars.BarsPage
{
    # region Приватные свойства
    private VWcsSurveysRecord _Survey;
    private VWcsSurveyGroupsRecord _SurveyGroup;
    # endregion

    # region Публичные свойства
    public String SURVEY_ID
    {
        get
        {
            return Request.Params.Get("survey_id");
        }
    }
    public String GROUP_ID
    {
        get
        {
            return Request.Params.Get("group_id");
        }
    }
    public VWcsSurveysRecord Survey
    {
        get
        {
            if (_Survey == null)
            {
                List<VWcsSurveysRecord> lst = (new VWcsSurveys()).SelectSurvey(SURVEY_ID);
                if (lst.Count > 0)
                    _Survey = lst[0];
            }

            return _Survey;
        }
    }
    public VWcsSurveyGroupsRecord SurveyGroup
    {
        get
        {
            if (_SurveyGroup == null)
            {
                List<VWcsSurveyGroupsRecord> lst = (new VWcsSurveyGroups()).SelectSurveyGroup(SURVEY_ID, GROUP_ID);
                if (lst.Count > 0)
                    _SurveyGroup = lst[0];
            }

            return _SurveyGroup;
        }
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.SetPageTitle(String.Format(this.Title, Survey.SURVEY_NAME, SurveyGroup.GROUP_NAME), true);
    }
    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            VWcsSurveyGroupQuestionsRecord rec = (VWcsSurveyGroupQuestionsRecord)e.Row.DataItem;

            if (rec.RECTYPE_ID == "SECTION")
            {
                e.Row.Style.Add(HtmlTextWriterStyle.FontWeight, "bold");
                e.Row.Style.Add(HtmlTextWriterStyle.Color, "#5178D5");
                e.Row.Style.Add(HtmlTextWriterStyle.Color, "#5178D5");
                e.Row.Style.Add(HtmlTextWriterStyle.BackgroundColor, "#E3EAEB");
            }
        }

    }
    protected void fv_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        gv.DataBind();
    }
    protected void fv_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        gv.DataBind();
    }
    protected void fv_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        gv.DataBind();
    }
    protected void fv_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        e.Values["SURVEY_ID"] = SURVEY_ID;
        e.Values["GROUP_ID"] = GROUP_ID;
    }
    protected void fv_ItemCommand(object sender, FormViewCommandEventArgs e)
    {
        Trace.Write("e.CommandName - " + e.CommandName);
        switch (e.CommandName)
        {
            case "MoveUp":
                if (gv.SelectedIndex > 0)
                {
                    String SelectedItem = (String)gv.DataKeys[gv.SelectedIndex]["QUESTION_ID"];
                    String UpItem = (String)gv.DataKeys[gv.SelectedIndex - 1]["QUESTION_ID"];

                    WcsPack wp = new WcsPack(new ibank.core.BbConnection());
                    wp.SURVEY_GROUP_QUEST_MOVE(SURVEY_ID, GROUP_ID, SelectedItem, UpItem);

                    gv.DataBind();
                    gv.SelectedIndex = gv.SelectedIndex - 1;
                }
                break;
            case "MoveDown":
                if (gv.SelectedIndex < gv.Rows.Count - 1)
                {
                    String SelectedItem = (String)gv.DataKeys[gv.SelectedIndex]["QUESTION_ID"];
                    String DownItem = (String)gv.DataKeys[gv.SelectedIndex + 1]["QUESTION_ID"];

                    WcsPack wp = new WcsPack(new ibank.core.BbConnection());
                    wp.SURVEY_GROUP_QUEST_MOVE(SURVEY_ID, GROUP_ID, SelectedItem, DownItem);

                    gv.DataBind();
                    gv.SelectedIndex = gv.SelectedIndex + 1;
                }
                break;
        }
    }
    protected void RECTYPE_ID_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList RECTYPE_ID = sender as DropDownList;

        TextBoxQuestion_ID QUESTION_ID = fv.FindControl("QUESTION_ID") as TextBoxQuestion_ID;
        TextBoxSQLBlock DNSHOW_IF = fv.FindControl("DNSHOW_IF") as TextBoxSQLBlock;
        TextBoxSQLBlock IS_REQUIRED = fv.FindControl("IS_REQUIRED") as TextBoxSQLBlock;
        TextBoxSQLBlock IS_READONLY = fv.FindControl("IS_READONLY") as TextBoxSQLBlock;
        RBLFlag IS_REWRITABLE = fv.FindControl("IS_REWRITABLE") as RBLFlag;
        RBLFlag IS_CHECKABLE = fv.FindControl("IS_CHECKABLE") as RBLFlag;
        TextBoxSQLBlock CHECK_PROC = fv.FindControl("CHECK_PROC") as TextBoxSQLBlock;

        if (RECTYPE_ID.SelectedValue == "QUESTION")
        {
            QUESTION_ID.SECTIONS = "inc:AUTHS,SURVEYS";
            QUESTION_ID.TYPES = "TEXT,NUMB,DECIMAL,DATE,LIST,REFER,BOOL";
            DNSHOW_IF.Enabled = true;
            IS_REQUIRED.Enabled = true;
            IS_READONLY.Enabled = true;
            IS_REWRITABLE.Enabled = true;
            IS_CHECKABLE.Enabled = true;
            CHECK_PROC.Enabled = true;
        }
        else
        {
            QUESTION_ID.SECTIONS = "inc:SURVEYS";
            QUESTION_ID.TYPES = "SECTION";
            DNSHOW_IF.Enabled = false;
            IS_REQUIRED.Enabled = false;
            IS_READONLY.Enabled = false;
            IS_REWRITABLE.Enabled = false;
            IS_CHECKABLE.Enabled = false;
            CHECK_PROC.Enabled = false;
        }
    }
    protected void RECTYPE_ID_DataBound(object sender, EventArgs e)
    {
        RECTYPE_ID_SelectedIndexChanged(sender, e);
    }
    public void ValueChanged(object sender, EventArgs e)
    {
        if (fv.CurrentMode == FormViewMode.Edit || fv.CurrentMode == FormViewMode.Insert)
        {
            RBLFlag IS_CALCABLE = sender as RBLFlag;
            TextBoxSQLBlock CHECK_PROC = fv.FindControl("CHECK_PROC") as TextBoxSQLBlock;

            CHECK_PROC.Enabled = IS_CALCABLE.Value == 0 ? false : true;
        }
    }
    protected void IS_CALCABLE_PreRender(object sender, EventArgs e)
    {
        ValueChanged(sender, e);
    }
    # endregion
}
