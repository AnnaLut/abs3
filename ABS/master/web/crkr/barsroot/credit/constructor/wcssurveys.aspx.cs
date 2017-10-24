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

public partial class credit_constructor_wcssurveys : Bars.BarsPage
{
    # region Приватные свойства
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {

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

    protected void ibNew_Click(object sender, ImageClickEventArgs e)
    {
        if (fv.CurrentMode == FormViewMode.Edit)
        {
            ListBox lb = fv.FindControl("lb") as ListBox;

            TextBoxString GROUP_ID = fv.FindControl("GROUP_ID") as TextBoxString;
            TextBoxString GROUP_NAME = fv.FindControl("GROUP_NAME") as TextBoxString;
            TextBoxSQLBlock DNSHOW_IF = fv.FindControl("DNSHOW_IF") as TextBoxSQLBlock;
            LinkButton lbQuestions = fv.FindControl("lbQuestions") as LinkButton;

            lb.SelectedIndex = -1;

            GROUP_ID.Value = (String)null;
            GROUP_NAME.Value = (String)null;
            DNSHOW_IF.Value = (String)null;

            GROUP_ID.ReadOnly = false;

            GROUP_ID.Focus();
        }
    }
    protected void idDelete_Click(object sender, ImageClickEventArgs e)
    {
        if (fv.CurrentMode == FormViewMode.Edit)
        {
            ListBox lb = fv.FindControl("lb") as ListBox;

            TextBoxString GROUP_ID = fv.FindControl("GROUP_ID") as TextBoxString;

            if (lb.SelectedIndex != -1)
            {
                WcsPack wp = new WcsPack(new BbConnection());
                wp.SURVEY_GROUP_DEL(Convert.ToString(gv.SelectedValue), GROUP_ID.Value);

                lb.DataBind();
            }
        }
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        if (fv.CurrentMode == FormViewMode.Edit)
        {
            ListBox lb = fv.FindControl("lb") as ListBox;

            TextBoxString GROUP_ID = fv.FindControl("GROUP_ID") as TextBoxString;
            TextBoxString GROUP_NAME = fv.FindControl("GROUP_NAME") as TextBoxString;
            TextBoxSQLBlock DNSHOW_IF = fv.FindControl("DNSHOW_IF") as TextBoxSQLBlock;

            int Idx = lb.SelectedIndex;
            if (Idx != -1)
            {
                // обновляем
                WcsPack wp = new WcsPack(new BbConnection());
                wp.SURVEY_GROUP_SET(Convert.ToString(gv.SelectedValue), GROUP_ID.Value, GROUP_NAME.Value, DNSHOW_IF.Value);

                lb.DataBind();
                lb.SelectedIndex = Idx;
                lb_DataBound(lb, null);
            }
            else
            {
                // создаем
                WcsPack wp = new WcsPack(new BbConnection());
                wp.SURVEY_GROUP_SET(Convert.ToString(gv.SelectedValue), GROUP_ID.Value, GROUP_NAME.Value, DNSHOW_IF.Value);

                lb.DataBind();
                lb.SelectedIndex = lb.Items.Count - 1;
                lb_DataBound(lb, null);
            }
        }
    }
    protected void ibUp_Click(object sender, ImageClickEventArgs e)
    {
        if (fv.CurrentMode == FormViewMode.Edit)
        {
            ListBox lb = fv.FindControl("lb") as ListBox;

            int Idx = lb.SelectedIndex;
            if (Idx != -1 && Idx != 0)
            {
                VWcsSurveyGroupsRecord SelectedItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsSurveyGroupsRecord>)[lb.SelectedIndex];
                VWcsSurveyGroupsRecord UpItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsSurveyGroupsRecord>)[lb.SelectedIndex - 1];

                WcsPack wp = new WcsPack(new BbConnection());
                wp.SURVEY_GROUP_MOVE(Convert.ToString(gv.SelectedValue), SelectedItem.GROUP_ID, UpItem.GROUP_ID);

                lb.DataBind();
                lb.SelectedIndex = Idx - 1;
                lb_DataBound(lb, null);
            }
        }
    }
    protected void ibDown_Click(object sender, ImageClickEventArgs e)
    {
        if (fv.CurrentMode == FormViewMode.Edit)
        {
            ListBox lb = fv.FindControl("lb") as ListBox;
            int Idx = lb.SelectedIndex;
            if (Idx != -1 && Idx != lb.Items.Count - 1)
            {
                VWcsSurveyGroupsRecord SelectedItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsSurveyGroupsRecord>)[lb.SelectedIndex];
                VWcsSurveyGroupsRecord DownItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsSurveyGroupsRecord>)[lb.SelectedIndex + 1];

                WcsPack wp = new WcsPack(new BbConnection());
                wp.SURVEY_GROUP_MOVE(Convert.ToString(gv.SelectedValue), SelectedItem.GROUP_ID, DownItem.GROUP_ID);

                lb.DataBind();
                lb.SelectedIndex = Idx + 1;
                lb_DataBound(lb, null);
            }
        }
    }
    protected void lb_DataBound(object sender, EventArgs e)
    {
        if (fv.CurrentMode == FormViewMode.Edit || fv.CurrentMode == FormViewMode.ReadOnly)
        {
            ListBox lb = sender as ListBox;

            TextBoxString GROUP_ID = fv.FindControl("GROUP_ID") as TextBoxString;
            TextBoxString GROUP_NAME = fv.FindControl("GROUP_NAME") as TextBoxString;
            TextBoxSQLBlock DNSHOW_IF = fv.FindControl("DNSHOW_IF") as TextBoxSQLBlock;

            if (lb.Items.Count > 0 && lb.SelectedIndex == -1)
                lb.SelectedIndex = 0;

            if (lb.SelectedIndex != -1)
            {
                VWcsSurveyGroupsRecord SelectedItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsSurveyGroupsRecord>)[lb.SelectedIndex];

                GROUP_ID.Value = SelectedItem.GROUP_ID;
                GROUP_NAME.Value = SelectedItem.GROUP_NAME;
                DNSHOW_IF.Value = SelectedItem.DNSHOW_IF;

                if (fv.CurrentMode == FormViewMode.Edit)
                {
                    Label lQUEST_CNT = fv.FindControl("lQUEST_CNT") as Label;
                    lQUEST_CNT.Text = String.Format(" ({0})", SelectedItem.QUEST_CNT.ToString());
                }
                else if (fv.CurrentMode == FormViewMode.ReadOnly)
                {
                    TextBoxNumb QUEST_CNT = fv.FindControl("QUEST_CNT") as TextBoxNumb;
                    QUEST_CNT.Value = SelectedItem.QUEST_CNT;
                }

                GROUP_ID.ReadOnly = true;
            }
            else
            {
                GROUP_ID.Value = (String)null;
                GROUP_NAME.Value = (String)null;
                DNSHOW_IF.Value = (String)null;

                if (fv.CurrentMode == FormViewMode.Edit)
                {
                    Label lQUEST_CNT = fv.FindControl("lQUEST_CNT") as Label;
                    lQUEST_CNT.Text = String.Empty;
                }
                else if (fv.CurrentMode == FormViewMode.ReadOnly)
                {
                    TextBoxNumb QUEST_CNT = fv.FindControl("QUEST_CNT") as TextBoxNumb;
                    QUEST_CNT.Value = (Decimal?)null;
                }

                GROUP_ID.ReadOnly = (false || fv.CurrentMode == FormViewMode.ReadOnly);
            }
        }
    }
    protected void lb_SelectedIndexChanged(object sender, EventArgs e)
    {
        lb_DataBound(sender, null);
    }
    protected void lbQuestions_Click(object sender, EventArgs e)
    {
        if (fv.CurrentMode == FormViewMode.Edit)
        {
            ListBox lb = fv.FindControl("lb") as ListBox;

            TextBoxString GROUP_ID = fv.FindControl("GROUP_ID") as TextBoxString;

            int Idx = lb.SelectedIndex;
            if (Idx != -1)
            {
                Response.Redirect(String.Format("/barsroot/credit/constructor/wcssurveygroupquestions.aspx?survey_id={0}&group_id={1}&rnd={2}", (String)gv.SelectedValue, GROUP_ID.Value, (new Random()).Next()));
            }
        }
    }
    # endregion
}
