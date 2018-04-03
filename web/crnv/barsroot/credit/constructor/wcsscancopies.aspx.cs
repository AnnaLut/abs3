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

public partial class credit_constructor_wcsscancopies : Bars.BarsPage
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

            TextBoxQuestion_ID QUESTION_ID = fv.FindControl("QUESTION_ID") as TextBoxQuestion_ID;
            TextBoxString QUESTION_NAME = fv.FindControl("QUESTION_NAME") as TextBoxString;
            DDLList ddllTYPE_ID = fv.FindControl("ddllTYPE_ID") as DDLList;
            RBLFlag IS_REQUIREDRBLFlag = fv.FindControl("IS_REQUIREDRBLFlag") as RBLFlag;

            lb.SelectedIndex = -1;

            QUESTION_ID.QUESTION_ID = (String)null;
            QUESTION_NAME.Value = (String)null;
            ddllTYPE_ID.SelectedValue = (String)null;
            IS_REQUIREDRBLFlag.Value = (Decimal?)null;

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
                wp.SCOPY_QUEST_DEL(Convert.ToString(gv.SelectedValue), QUESTION_ID.QUESTION_ID);

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
            DDLList ddllTYPE_ID = fv.FindControl("ddllTYPE_ID") as DDLList;
            RBLFlag IS_REQUIREDRBLFlag = fv.FindControl("IS_REQUIREDRBLFlag") as RBLFlag;

            int Idx = lb.SelectedIndex;
            if (Idx != -1)
            {
                // обновляем
                WcsPack wp = new WcsPack(new BbConnection());
                wp.SCOPY_QUEST_SET(Convert.ToString(gv.SelectedValue), QUESTION_ID.QUESTION_ID, ddllTYPE_ID.SelectedValue, IS_REQUIREDRBLFlag.Value);

                lb.DataBind();
                lb.SelectedIndex = Idx;
                lb_DataBound(lb, null);
            }
            else
            {
                // создаем
                WcsPack wp = new WcsPack(new BbConnection());
                wp.SCOPY_QUEST_SET(Convert.ToString(gv.SelectedValue), QUESTION_ID.QUESTION_ID, ddllTYPE_ID.SelectedValue, IS_REQUIREDRBLFlag.Value);

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
                VWcsScancopyQuestionsRecord SelectedItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsScancopyQuestionsRecord>)[lb.SelectedIndex];
                VWcsScancopyQuestionsRecord UpItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsScancopyQuestionsRecord>)[lb.SelectedIndex - 1];

                WcsPack wp = new WcsPack(new BbConnection());
                wp.SCOPY_QUEST_MOVE(Convert.ToString(gv.SelectedValue), SelectedItem.QUESTION_ID, UpItem.QUESTION_ID);

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
                VWcsScancopyQuestionsRecord SelectedItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsScancopyQuestionsRecord>)[lb.SelectedIndex];
                VWcsScancopyQuestionsRecord DownItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsScancopyQuestionsRecord>)[lb.SelectedIndex + 1];

                WcsPack wp = new WcsPack(new BbConnection());
                wp.SCOPY_QUEST_MOVE(Convert.ToString(gv.SelectedValue), SelectedItem.QUESTION_ID, DownItem.QUESTION_ID);

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

            TextBoxQuestion_ID QUESTION_ID = fv.FindControl("QUESTION_ID") as TextBoxQuestion_ID;
            TextBoxString QUESTION_NAME = fv.FindControl("QUESTION_NAME") as TextBoxString;
            DDLList ddllTYPE_ID = fv.FindControl("ddllTYPE_ID") as DDLList;
            RBLFlag IS_REQUIREDRBLFlag = fv.FindControl("IS_REQUIREDRBLFlag") as RBLFlag;

            if (lb.Items.Count > 0 && lb.SelectedIndex == -1)
                lb.SelectedIndex = 0;

            if (lb.SelectedIndex != -1)
            {
                VWcsScancopyQuestionsRecord SelectedItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsScancopyQuestionsRecord>)[lb.SelectedIndex];

                QUESTION_ID.QUESTION_ID = SelectedItem.QUESTION_ID;
                QUESTION_NAME.Value = SelectedItem.QUESTION_NAME;
                ddllTYPE_ID.SelectedValue = SelectedItem.TYPE_ID;
                IS_REQUIREDRBLFlag.Value = SelectedItem.IS_REQUIRED;
            }
            else
            {
                QUESTION_ID.QUESTION_ID = (String)null;
                QUESTION_NAME.Value = (String)null;
                ddllTYPE_ID.SelectedValue = (String)null;
                IS_REQUIREDRBLFlag.Value = (Decimal?)null;
            }
        }
    }
    protected void lb_SelectedIndexChanged(object sender, EventArgs e)
    {
        lb_DataBound(sender, null);
    }


    # endregion
}
