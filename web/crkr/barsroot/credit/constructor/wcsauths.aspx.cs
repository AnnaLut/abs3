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

public partial class credit_constructor_wcsauths : Bars.BarsPage
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
    protected void fv_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        TextBoxString IDTextBox = fv.FindControl("IDTextBox") as TextBoxString;
        TextBoxString NAMETextBox = fv.FindControl("NAMETextBox") as TextBoxString;
        DDLList CLONE_ID = fv.FindControl("CLONE_ID") as DDLList;

        // если выбрана карта для клонирования, то клонируем
        if (!String.IsNullOrEmpty(CLONE_ID.SelectedValue))
        {
            WcsPack wp = new WcsPack(new BbConnection());
            wp.AUTH_CLONE(IDTextBox.Value, NAMETextBox.Value, CLONE_ID.SelectedValue);
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
            TextBoxQuestion_ID SCOPY_QID = fv.FindControl("SCOPY_QID") as TextBoxQuestion_ID;
            RBLFlag IS_REQUIRED = fv.FindControl("IS_REQUIRED") as RBLFlag;
            RBLFlag IS_CHECKABLERBLFlag = fv.FindControl("IS_CHECKABLERBLFlag") as RBLFlag;
            TextBoxSQLBlock CHECK_PROCTextBox = fv.FindControl("CHECK_PROCTextBox") as TextBoxSQLBlock;

            lb.SelectedIndex = -1;

            QUESTION_ID.QUESTION_ID = (String)null;
            QUESTION_NAME.Value = (String)null;
            TYPE_NAME.Value = (String)null;
            SCOPY_QID.QUESTION_ID = (String)null;
            IS_REQUIRED.Value = (Decimal?)null;
            IS_CHECKABLERBLFlag.Value = (Decimal?)null;
            CHECK_PROCTextBox.Value = (String)null;

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
                wp.AUTH_QUEST_DEL(Convert.ToString(gv.SelectedValue), QUESTION_ID.QUESTION_ID);

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
            TextBoxQuestion_ID SCOPY_QID = fv.FindControl("SCOPY_QID") as TextBoxQuestion_ID;
            RBLFlag IS_REQUIRED = fv.FindControl("IS_REQUIRED") as RBLFlag;
            RBLFlag IS_CHECKABLERBLFlag = fv.FindControl("IS_CHECKABLERBLFlag") as RBLFlag;
            TextBoxSQLBlock CHECK_PROCTextBox = fv.FindControl("CHECK_PROCTextBox") as TextBoxSQLBlock;

            int Idx = lb.SelectedIndex;
            if (Idx != -1)
            {
                // обновляем
                WcsPack wp = new WcsPack(new BbConnection());
                wp.AUTH_QUEST_SET(Convert.ToString(gv.SelectedValue), QUESTION_ID.QUESTION_ID, SCOPY_QID.QUESTION_ID, IS_REQUIRED.Value, IS_CHECKABLERBLFlag.Value, CHECK_PROCTextBox.Value);

                lb.DataBind();
                lb.SelectedIndex = Idx;
                lb_DataBound(lb, null);
            }
            else
            {
                // создаем
                WcsPack wp = new WcsPack(new BbConnection());
                wp.AUTH_QUEST_SET(Convert.ToString(gv.SelectedValue), QUESTION_ID.QUESTION_ID, SCOPY_QID.QUESTION_ID, IS_REQUIRED.Value, IS_CHECKABLERBLFlag.Value, CHECK_PROCTextBox.Value);

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
                 VWcsAuthorizationQuestionsRecord SelectedItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsAuthorizationQuestionsRecord>)[lb.SelectedIndex];
                 VWcsAuthorizationQuestionsRecord UpItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsAuthorizationQuestionsRecord>)[lb.SelectedIndex - 1];

                 WcsPack wp = new WcsPack(new BbConnection());
                 wp.AUTH_QUEST_MOVE(Convert.ToString(gv.SelectedValue), SelectedItem.QUESTION_ID, UpItem.QUESTION_ID);

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
                VWcsAuthorizationQuestionsRecord SelectedItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsAuthorizationQuestionsRecord>)[lb.SelectedIndex];
                VWcsAuthorizationQuestionsRecord DownItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsAuthorizationQuestionsRecord>)[lb.SelectedIndex + 1];

                WcsPack wp = new WcsPack(new BbConnection());
                wp.AUTH_QUEST_MOVE(Convert.ToString(gv.SelectedValue), SelectedItem.QUESTION_ID, DownItem.QUESTION_ID);

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
            TextBoxQuestion_ID SCOPY_QID = fv.FindControl("SCOPY_QID") as TextBoxQuestion_ID;
            RBLFlag IS_REQUIRED = fv.FindControl("IS_REQUIRED") as RBLFlag;
            RBLFlag IS_CHECKABLERBLFlag = fv.FindControl("IS_CHECKABLERBLFlag") as RBLFlag;
            TextBoxSQLBlock CHECK_PROCTextBox = fv.FindControl("CHECK_PROCTextBox") as TextBoxSQLBlock;

            if (lb.Items.Count > 0 && lb.SelectedIndex == -1)
                lb.SelectedIndex = 0;

            if (lb.SelectedIndex != -1)
            {
                VWcsAuthorizationQuestionsRecord SelectedItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsAuthorizationQuestionsRecord>)[lb.SelectedIndex];

                QUESTION_ID.QUESTION_ID = SelectedItem.QUESTION_ID;
                QUESTION_NAME.Value = SelectedItem.QUESTION_NAME;
                TYPE_NAME.Value = SelectedItem.TYPE_NAME;
                SCOPY_QID.QUESTION_ID = SelectedItem.SCOPY_QID;
                IS_REQUIRED.Value = SelectedItem.IS_REQUIRED;
                IS_CHECKABLERBLFlag.Value = SelectedItem.IS_CHECKABLE;
                CHECK_PROCTextBox.Value = SelectedItem.CHECK_PROC;

                QUESTION_ID.ReadOnly = true;
            }
            else
            {
                QUESTION_ID.QUESTION_ID = (String)null;
                QUESTION_NAME.Value = (String)null;
                TYPE_NAME.Value = (String)null;
                SCOPY_QID.QUESTION_ID = (String)null;
                IS_REQUIRED.Value = (Decimal?)null;
                IS_CHECKABLERBLFlag.Value = (Decimal?)null;
                CHECK_PROCTextBox.Value = (String)null;

                QUESTION_ID.ReadOnly = false;
            }
        }
    }
    protected void lb_SelectedIndexChanged(object sender, EventArgs e)
    {
        lb_DataBound(sender, null);
    }
    protected void IS_CHECKABLE_ValueChanged(object sender, EventArgs e)
    {
        if (fv.CurrentMode == FormViewMode.Edit || fv.CurrentMode == FormViewMode.Insert)
        {
            RBLFlag IS_CHECKABLE = sender as RBLFlag;
            TextBoxSQLBlock CHECK_PROC = fv.FindControl("CHECK_PROCTextBox") as TextBoxSQLBlock;

            CHECK_PROC.Enabled = IS_CHECKABLE.Value == 0 ? false : true;
        }
    }
    protected void IS_CHECKABLE_PreRender(object sender, EventArgs e)
    {
        IS_CHECKABLE_ValueChanged(sender, e);
    }
    # endregion
}
