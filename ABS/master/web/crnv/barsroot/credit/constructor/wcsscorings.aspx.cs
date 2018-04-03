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
using Bars.DataComponents;
using Bars.UserControls;
using credit;
using ibank.core;

public partial class credit_constructor_wcsscorings : Bars.BarsPage
{
    # region Приватные свойства
    private int? gvSelectedIndex
    {
        get
        {
            return (Session["gvScoringSelectedIndex"] == null ? (int?)null : (int)Session["gvScoringSelectedIndex"]);
        }
        set
        {
            Session.Add("gvScoringSelectedIndex", value.Value);
        }
    }
    private int? lbSelectedIndex
    {
        get
        {
            return (Session["lbScoringSelectedIndex"] == null ? (int?)null : (int)Session["lbScoringSelectedIndex"]);
        }
        set
        {
            Session.Add("lbScoringSelectedIndex", value.Value);
        }
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (gvSelectedIndex.HasValue)
                gv.SelectedIndex = gvSelectedIndex.Value;
            else
                gv.SelectedIndex = 0;
        }
    }
    protected void gv_SelectedIndexChanged(object sender, EventArgs e)
    {
        gvSelectedIndex = gv.SelectedIndex;
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
    protected void fv_PreRender(object sender, EventArgs e)
    {
        if (fv.CurrentMode == FormViewMode.Edit || fv.CurrentMode == FormViewMode.ReadOnly)
        {
            ListBox lb = fv.FindControl("lb") as ListBox;

            if (lbSelectedIndex.HasValue)
                lb.SelectedIndex = lbSelectedIndex.Value;
            else
                lb.SelectedIndex = 0;
        }
    }

    protected void ibNew_Click(object sender, ImageClickEventArgs e)
    {
        if (fv.CurrentMode == FormViewMode.Edit)
        {
            ListBox lb = fv.FindControl("lb") as ListBox;

            TextBoxQuestion_ID QUESTION_ID = fv.FindControl("QUESTION_ID") as TextBoxQuestion_ID;
            TextBoxString QUESTION_NAME = fv.FindControl("QUESTION_NAME") as TextBoxString;
            TextBoxString TYPE_NAME = fv.FindControl("TYPE_NAME") as TextBoxString;
            TextBoxDecimal MULTIPLIER = fv.FindControl("MULTIPLIER") as TextBoxDecimal;
            TextBoxDecimal ELSE_SCORE = fv.FindControl("ELSE_SCORE") as TextBoxDecimal;

            lb.SelectedIndex = -1;

            QUESTION_ID.QUESTION_ID = (String)null;
            QUESTION_NAME.Value = (String)null;
            TYPE_NAME.Value = (String)null;
            MULTIPLIER.Value = (Decimal?)null;
            ELSE_SCORE.Value = (Decimal?)null;

            QUESTION_ID.ReadOnly = false;

            QUESTION_ID.Focus();
        }
    }
    protected void idDelete_Click(object sender, ImageClickEventArgs e)
    {
        if (fv.CurrentMode == FormViewMode.Edit)
        {
            ListBox lb = fv.FindControl("lb") as ListBox;

            TextBoxQuestion_ID QUESTION_ID = fv.FindControl("QUESTION_ID") as TextBoxQuestion_ID;

            if (lb.SelectedIndex != -1)
            {
                WcsPack wp = new WcsPack(new BbConnection());
                wp.SCOR_QUEST_DEL(Convert.ToString(gv.SelectedValue), QUESTION_ID.QUESTION_ID);

                lb.DataBind();
            }
        }
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        if (fv.CurrentMode == FormViewMode.Edit)
        {
            ListBox lb = fv.FindControl("lb") as ListBox;

            TextBoxQuestion_ID QUESTION_ID = fv.FindControl("QUESTION_ID") as TextBoxQuestion_ID;
            TextBoxDecimal MULTIPLIER = fv.FindControl("MULTIPLIER") as TextBoxDecimal;
            TextBoxDecimal ELSE_SCORE = fv.FindControl("ELSE_SCORE") as TextBoxDecimal;

            int Idx = lb.SelectedIndex;
            if (Idx != -1)
            {
                // обновляем
                WcsPack wp = new WcsPack(new BbConnection());
                wp.SCOR_QUEST_SET(Convert.ToString(gv.SelectedValue), QUESTION_ID.QUESTION_ID, MULTIPLIER.Value, ELSE_SCORE.Value);

                lb.DataBind();
                lb.SelectedIndex = Idx;
                lb_DataBound(lb, null);
            }
            else
            {
                // создаем
                WcsPack wp = new WcsPack(new BbConnection());
                wp.SCOR_QUEST_SET(Convert.ToString(gv.SelectedValue), QUESTION_ID.QUESTION_ID, MULTIPLIER.Value, ELSE_SCORE.Value);

                lb.DataBind();
                lb.SelectedIndex = lb.Items.Count - 1;
                lb_DataBound(lb, null);
            }
        }
    }
    protected void lb_DataBound(object sender, EventArgs e)
    {
        if (fv.CurrentMode == FormViewMode.Edit || fv.CurrentMode == FormViewMode.ReadOnly)
        {
            ListBox lb = sender as ListBox;

            if (lbSelectedIndex.HasValue)
                lb.SelectedIndex = lbSelectedIndex.Value;
            else
                lb.SelectedIndex = 0;

            TextBoxQuestion_ID QUESTION_ID = fv.FindControl("QUESTION_ID") as TextBoxQuestion_ID;
            TextBoxString QUESTION_NAME = fv.FindControl("QUESTION_NAME") as TextBoxString;
            TextBoxString TYPE_NAME = fv.FindControl("TYPE_NAME") as TextBoxString;
            TextBoxDecimal MULTIPLIER = fv.FindControl("MULTIPLIER") as TextBoxDecimal;
            TextBoxDecimal ELSE_SCORE = fv.FindControl("ELSE_SCORE") as TextBoxDecimal;

            if (lb.Items.Count > 0 && lb.SelectedIndex == -1)
                lb.SelectedIndex = 0;

            if (lb.SelectedIndex != -1)
            {
                VWcsScoringQuestionsRecord SelectedItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsScoringQuestionsRecord>)[lb.SelectedIndex];

                QUESTION_ID.QUESTION_ID = SelectedItem.QUESTION_ID;
                QUESTION_NAME.Value = SelectedItem.QUESTION_NAME;
                TYPE_NAME.Value = SelectedItem.TYPE_NAME;
                MULTIPLIER.Value = SelectedItem.MULTIPLIER;
                ELSE_SCORE.Value = SelectedItem.ELSE_SCORE;

                QUESTION_ID.ReadOnly = true;
            }
            else
            {
                QUESTION_ID.QUESTION_ID = (String)null;
                QUESTION_NAME.Value = (String)null;
                TYPE_NAME.Value = (String)null;
                MULTIPLIER.Value = (Decimal?)null;
                ELSE_SCORE.Value = (Decimal?)null;

                QUESTION_ID.ReadOnly = (false || fv.CurrentMode == FormViewMode.ReadOnly);
            }
        }
    }
    protected void lb_SelectedIndexChanged(object sender, EventArgs e)
    {
        ListBox lb = sender as ListBox;
        lbSelectedIndex = lb.SelectedIndex;

        lb_DataBound(sender, null);
    }
    protected void lbBalls_Click(object sender, EventArgs e)
    {
        if (fv.CurrentMode == FormViewMode.Edit)
        {
            ListBox lb = fv.FindControl("lb") as ListBox;

            TextBoxQuestion_ID QUESTION_ID = fv.FindControl("QUESTION_ID") as TextBoxQuestion_ID;

            int Idx = lb.SelectedIndex;
            if (Idx != -1)
            {
                Response.Redirect(String.Format("/barsroot/credit/constructor/wcsscoringballs.aspx?scoring_id={0}&question_id={1}&rnd={2}", (String)gv.SelectedValue, QUESTION_ID.QuestionRecord.ID, (new Random()).Next()));
            }
        }
    }
    # endregion
}
