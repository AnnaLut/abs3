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

public partial class credit_constructor_wcsinfoqueries : Bars.BarsPage
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
            TextBoxString TYPE_NAME = fv.FindControl("TYPE_NAME") as TextBoxString;
            RBLFlag IS_REQUIRED = fv.FindControl("IS_REQUIRED") as RBLFlag;
            RBLFlag IS_CHECKABLE = fv.FindControl("IS_CHECKABLE") as RBLFlag;
            TextBoxSQLBlock CHECK_PROC = fv.FindControl("CHECK_PROC") as TextBoxSQLBlock;

            lb.SelectedIndex = -1;

            QUESTION_ID.QUESTION_ID = (String)null;
            QUESTION_NAME.Value = (String)null;
            TYPE_NAME.Value = (String)null;
            IS_REQUIRED.Value = (Decimal?)null;
            IS_CHECKABLE.Value = (Decimal?)null;
            CHECK_PROC.Value = (String)null;

            QUESTION_ID.AllowNew = true;
            QUESTION_ID.AllowNewFromRef = true;

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
                wp.IQUERY_QUEST_DEL(Convert.ToString(gv.SelectedValue), QUESTION_ID.QUESTION_ID);

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
            RBLFlag IS_REQUIRED = fv.FindControl("IS_REQUIRED") as RBLFlag;
            RBLFlag IS_CHECKABLE = fv.FindControl("IS_CHECKABLE") as RBLFlag;
            TextBoxSQLBlock CHECK_PROC = fv.FindControl("CHECK_PROC") as TextBoxSQLBlock;

            int Idx = lb.SelectedIndex;
            if (Idx != -1)
            {
                // обновляем
                WcsPack wp = new WcsPack(new BbConnection());
                wp.IQUERY_QUEST_SET(Convert.ToString(gv.SelectedValue), QUESTION_ID.QUESTION_ID, IS_REQUIRED.Value, IS_CHECKABLE.Value, CHECK_PROC.Value);

                lb.DataBind();
                lb.SelectedIndex = Idx;
                lb_DataBound(lb, null);
            }
            else
            {
                // создаем
                WcsPack wp = new WcsPack(new BbConnection());
                wp.IQUERY_QUEST_SET(Convert.ToString(gv.SelectedValue), QUESTION_ID.QUESTION_ID, IS_REQUIRED.Value, IS_CHECKABLE.Value, CHECK_PROC.Value);

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
                 VWcsInfoqueryQuestionsRecord SelectedItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsInfoqueryQuestionsRecord>)[lb.SelectedIndex];
                 VWcsInfoqueryQuestionsRecord UpItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsInfoqueryQuestionsRecord>)[lb.SelectedIndex - 1];

                 WcsPack wp = new WcsPack(new BbConnection());
                 wp.IQUERY_QUEST_MOVE(Convert.ToString(gv.SelectedValue), SelectedItem.QUESTION_ID, UpItem.QUESTION_ID);

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
                VWcsInfoqueryQuestionsRecord SelectedItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsInfoqueryQuestionsRecord>)[lb.SelectedIndex];
                VWcsInfoqueryQuestionsRecord DownItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsInfoqueryQuestionsRecord>)[lb.SelectedIndex + 1];

                WcsPack wp = new WcsPack(new BbConnection());
                wp.IQUERY_QUEST_MOVE(Convert.ToString(gv.SelectedValue), SelectedItem.QUESTION_ID, DownItem.QUESTION_ID);

                lb.DataBind();
                lb.SelectedIndex = Idx + 1;
                lb_DataBound(lb, null);
            }
        }
    }
    protected void lb_DataBound(object sender, EventArgs e)
    {
        if (fv.CurrentMode == FormViewMode.Edit)
        {
            ListBox lb = sender as ListBox;

            TextBoxQuestion_ID QUESTION_ID = fv.FindControl("QUESTION_ID") as TextBoxQuestion_ID;
            TextBoxString QUESTION_NAME = fv.FindControl("QUESTION_NAME") as TextBoxString;
            TextBoxString TYPE_NAME = fv.FindControl("TYPE_NAME") as TextBoxString;
            RBLFlag IS_REQUIRED = fv.FindControl("IS_REQUIRED") as RBLFlag;
            RBLFlag IS_CHECKABLE = fv.FindControl("IS_CHECKABLE") as RBLFlag;
            TextBoxSQLBlock CHECK_PROC = fv.FindControl("CHECK_PROC") as TextBoxSQLBlock;

            if (lb.Items.Count > 0 && lb.SelectedIndex == -1)
                lb.SelectedIndex = 0;

            if (lb.SelectedIndex != -1)
            {
                VWcsInfoqueryQuestionsRecord SelectedItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsInfoqueryQuestionsRecord>)[lb.SelectedIndex];

                QUESTION_ID.QUESTION_ID = SelectedItem.QUESTION_ID;
                QUESTION_NAME.Value = SelectedItem.QUESTION_NAME;
                TYPE_NAME.Value = SelectedItem.TYPE_NAME;
                IS_REQUIRED.Value = SelectedItem.IS_REQUIRED;
                IS_CHECKABLE.Value = SelectedItem.IS_CHECKABLE;
                CHECK_PROC.Value = SelectedItem.CHECK_PROC;

                QUESTION_ID.AllowNew = false;
                QUESTION_ID.AllowNewFromRef = false;                
            }
            else
            {
                QUESTION_ID.QUESTION_ID = (String)null;
                QUESTION_NAME.Value = (String)null;
                TYPE_NAME.Value = (String)null;
                IS_REQUIRED.Value = (Decimal?)null;
                IS_CHECKABLE.Value = (Decimal?)null;
                CHECK_PROC.Value = (String)null;

                QUESTION_ID.AllowNew = true;
                QUESTION_ID.AllowNewFromRef = true;
            }
        }
    }
    protected void lb_SelectedIndexChanged(object sender, EventArgs e)
    {
        lb_DataBound(sender, null);
    }

    public void IS_CHECKABLE_ValueChanged(object sender, EventArgs e)
    {
        if (fv.CurrentMode == FormViewMode.Edit || fv.CurrentMode == FormViewMode.Insert)
        {
            RBLFlag IS_CHECKABLE = sender as RBLFlag;
            TextBoxSQLBlock CHECK_PROC = fv.FindControl("CHECK_PROC") as TextBoxSQLBlock;

            CHECK_PROC.Enabled = IS_CHECKABLE.Value == 0 ? false : true;
        }
    }
    protected void IS_CHECKABLE_PreRender(object sender, EventArgs e)
    {
        IS_CHECKABLE_ValueChanged(sender, e);
    }
    # endregion
}
