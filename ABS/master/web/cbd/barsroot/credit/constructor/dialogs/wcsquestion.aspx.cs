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

using Bars.UserControls;
using Bars.Classes;
using Bars.DataComponents;
using ibank.core;
using credit;

public enum Modes
{
    ReadOnly,
    Edit,
    New
}

public partial class credit_constructor_dialogs_wcsquestion : Bars.BarsPage
{
    # region Приватные свойства
    private String _QUESTION_ID;
    private VWcsQuestionParamsRecord _VWcsQuestionParams;
    // private WcsQuestionMatrixParamsRecord _qmprWcsQuestionMatrixParams;
    # endregion

    # region Публичные свойства
    public Modes Mode
    {
        get
        {
            Modes res;
            switch (Request.Params.Get("mode"))
            {
                case "readonly": res = Modes.ReadOnly; break;
                case "edit": res = Modes.Edit; break;
                case "new": res = Modes.New; break;
                default: res = Modes.ReadOnly; break;
            }

            return res;
        }
    }
    public String QUESTION_ID
    {
        get
        {
            return Request.Params.Get("question_id");
        }
    }
    public String QUESTION_TYPES
    {
        get
        {
            return Request.Params.Get("types");
        }
    }
    public VWcsQuestionParamsRecord VWcsQuestionParams
    {
        get
        {
            _VWcsQuestionParams = (fv.DataItem as VWcsQuestionParamsRecord);

            return _VWcsQuestionParams;
        }
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        // если диалог вызвали для создания нового то переводим его в состояние инсер
        if (Mode == Modes.New && String.IsNullOrEmpty(QUESTION_ID))
            fv.DefaultMode = FormViewMode.Insert;

        // если диалог вызвали только для просмотра
        if (Mode == Modes.ReadOnly && !String.IsNullOrEmpty(QUESTION_ID))
        {
            fv.DefaultMode = FormViewMode.ReadOnly;
            
            ImageButton ibEdit = fv.FindControl("ibEdit") as ImageButton;
            ibEdit.Visible = false;
        }
    }
    protected void odsWcsQuestionTypes_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
    {
        if (!String.IsNullOrEmpty(QUESTION_TYPES))
            e.InputParameters["TYPES"] = QUESTION_TYPES;
    }
    protected void fv_ItemCommand(object sender, FormViewCommandEventArgs e)
    {
        /*
        switch (e.CommandName)
        {
            case "Insert":

                break;
        }
         * */
    }
    protected void fv_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        String ID = e.Values["ID"] as String;
        if (e.Exception == null)
        {
            Response.Redirect(String.Format("/barsroot/credit/constructor/dialogs/wcsquestion.aspx?question_id={0}&mode={1}&types={2}&rnd={3}", ID, "edit", QUESTION_TYPES, (new Random()).Next().ToString()));
        }
    }
    protected void fv_DataBound(object sender, EventArgs e)
    {
        Trace.Write("Mode = " + Mode);
        if (Mode != Modes.New)
            Master.SetPageTitle(this.Title + " - " + VWcsQuestionParams.ID + "(" + VWcsQuestionParams.NAME + ")", true);

        if (Mode != Modes.New && fv.CurrentMode == FormViewMode.Edit)
        {
            MultiView mvTypes = fv.FindControl("mvTypes") as MultiView;

            switch (VWcsQuestionParams.TYPE_ID)
            {
                case "TEXT": mvTypes.ActiveViewIndex = 0;
                    break;
                case "NUMB": mvTypes.ActiveViewIndex = 1;
                    break;
                case "DECIMAL": mvTypes.ActiveViewIndex = 1;
                    break;
                case "DATE": mvTypes.ActiveViewIndex = 2;
                    break;
                case "LIST": mvTypes.ActiveViewIndex = 3;
                    break;
                case "REFER": mvTypes.ActiveViewIndex = 4;
                    break;
                case "BOOL": mvTypes.ActiveViewIndex = 5;
                    break;
                case "XML": mvTypes.ActiveViewIndex = 6;
                    break;
            }
        }
    }
    protected void fv_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        if (fv.FindControl("TAB_ID") != null)
        {
            TextBoxNumb TAB_ID = fv.FindControl("TAB_ID") as TextBoxNumb;
            e.NewValues["TAB_ID"] = TAB_ID.Value;
        }
    }

    protected void ibNew_Click(object sender, ImageClickEventArgs e)
    {
        if (fv.CurrentMode == FormViewMode.Edit)
        {
            ListBox lb = fv.FindControl("lb") as ListBox;

            TextBoxNumb ORD = fv.FindControl("ORD") as TextBoxNumb;
            TextBoxString TEXTTextBox = fv.FindControl("TEXTTextBox") as TextBoxString;
            RBLFlag VISIBLE = fv.FindControl("VISIBLE") as RBLFlag;

            lb.SelectedIndex = -1;

            ORD.Value = (Decimal?)null;
            TEXTTextBox.Value = (String)null;
            VISIBLE.Value = (Decimal?)null;

            ORD.Focus();
        }
    }
    protected void idDelete_Click(object sender, ImageClickEventArgs e)
    {
        if (fv.CurrentMode == FormViewMode.Edit)
        {
            ListBox lb = fv.FindControl("lb") as ListBox;

            TextBoxNumb ORD = fv.FindControl("ORD") as TextBoxNumb;

            if (lb.SelectedIndex != -1)
            {
                WcsPack wp = new WcsPack(new BbConnection());
                wp.QUEST_LIST_ITEM_DEL(QUESTION_ID, ORD.Value);

                lb.DataBind();
            }
        }
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        if (fv.CurrentMode == FormViewMode.Edit)
        {
            ListBox lb = fv.FindControl("lb") as ListBox;

            TextBoxNumb ORD = fv.FindControl("ORD") as TextBoxNumb;
            TextBoxString TEXTTextBox = fv.FindControl("TEXTTextBox") as TextBoxString;
            RBLFlag VISIBLE = fv.FindControl("VISIBLE") as RBLFlag;

            int Idx = lb.SelectedIndex;
            if (Idx != -1)
            {
                // обновляем
                WcsPack wp = new WcsPack(new BbConnection());
                wp.QUEST_LIST_ITEM_SET(QUESTION_ID, ORD.Value, TEXTTextBox.Value, VISIBLE.Value);

                lb.DataBind();
                lb.SelectedIndex = Idx;
                lb_DataBound(lb, null);
            }
            else
            {
                // создаем
                WcsPack wp = new WcsPack(new BbConnection());
                wp.QUEST_LIST_ITEM_SET(QUESTION_ID, (Decimal?)null, TEXTTextBox.Value, VISIBLE.Value);

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
                VWcsQuestionListItemsRecord SelectedItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsQuestionListItemsRecord>)[lb.SelectedIndex];
                VWcsQuestionListItemsRecord UpItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsQuestionListItemsRecord>)[lb.SelectedIndex - 1];

                WcsPack wp = new WcsPack(new BbConnection());
                wp.QUEST_LIST_ITEM_MOVE(QUESTION_ID, SelectedItem.ORD, UpItem.ORD);

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
                VWcsQuestionListItemsRecord SelectedItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsQuestionListItemsRecord>)[lb.SelectedIndex];
                VWcsQuestionListItemsRecord DownItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsQuestionListItemsRecord>)[lb.SelectedIndex + 1];

                WcsPack wp = new WcsPack(new BbConnection());
                wp.QUEST_LIST_ITEM_MOVE(QUESTION_ID, SelectedItem.ORD, DownItem.ORD);

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

            TextBoxNumb ORD = fv.FindControl("ORD") as TextBoxNumb;
            TextBoxString TEXTTextBox = fv.FindControl("TEXTTextBox") as TextBoxString;
            RBLFlag VISIBLE = fv.FindControl("VISIBLE") as RBLFlag;

            if (lb.Items.Count > 0 && lb.SelectedIndex == -1)
                lb.SelectedIndex = 0;

            Trace.Write("lb.SelectedIndex  = " + lb.SelectedIndex);
            if (lb.SelectedIndex != -1)
            {
                Trace.Write("(lb.DataSourceObject as BarsObjectDataSource)  = " + (lb.DataSourceObject as BarsObjectDataSource));
                VWcsQuestionListItemsRecord SelectedItem = ((lb.DataSourceObject as BarsObjectDataSource).Select() as List<VWcsQuestionListItemsRecord>)[lb.SelectedIndex];

                ORD.Value = SelectedItem.ORD;
                TEXTTextBox.Value = SelectedItem.TEXT;
                VISIBLE.Value = SelectedItem.VISIBLE;
            }
            else
            {
                ORD.Value = (Decimal?)null;
                TEXTTextBox.Value = (String)null;
                VISIBLE.Value = (Decimal?)null;
            }
        }
    }
    protected void lb_SelectedIndexChanged(object sender, EventArgs e)
    {
        lb_DataBound(sender, null);
    }
    
    public void ValueChanged(object sender, EventArgs e)
    {
        if (fv.CurrentMode == FormViewMode.Edit || fv.CurrentMode == FormViewMode.Insert)
        {
            RBLFlag IS_CALCABLE = sender as RBLFlag;
            TextBoxSQLBlock CALC_PROCTextBox = fv.FindControl("CALC_PROCTextBox") as TextBoxSQLBlock;

            CALC_PROCTextBox.Enabled = IS_CALCABLE.Value == 0 ? false : true;
        }
    }
    protected void IS_CALCABLE_PreRender(object sender, EventArgs e)
    {
        ValueChanged(sender, e);
    }
    # endregion
}
