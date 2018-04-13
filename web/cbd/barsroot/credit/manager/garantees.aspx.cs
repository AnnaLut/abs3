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

using Bars.DataComponents;
using System.Collections.Generic;
using Bars.Classes;
using credit;
using ibank.core;

public partial class credit_manager_garantees : Bars.BarsPage
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
    public Boolean? ReadOnly
    {
        get
        {
            return Request.Params.Get("readonly") == "1" ? true : false;
        }
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        sds.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        // заголовок
        Master.SetPageTitle(this.Title + Convert.ToString(BID_ID), true);

        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        try
        {
            // чекаут состояния
            if (!IsPostBack)
            {
                if (1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_GUARANTEE"))
                    cmn.wp.BID_STATE_CHECK_OUT(BID_ID, "NEW_GUARANTEE", (String)null);
                if (1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_GUARANTEE1"))
                    cmn.wp.BID_STATE_CHECK_OUT(BID_ID, "NEW_GUARANTEE1", (String)null);
            }
        }
        finally
        {
            con.CloseConnection();
        }

        // проверки
        Master.HideError();
    }
    protected void fv_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        gv.DataBind();
    }
    protected void fv_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        gv.DataBind();
    }
    protected void fv_ItemCommand(object sender, FormViewCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "ScanCopy":
                Response.Redirect(String.Format("/barsroot/credit/manager/grt_scancopy.aspx?bid_id={0}&garantee_id={1}&garantee_num={2}&readonly={3}", BID_ID.ToString(), Convert.ToString(gv.SelectedDataKey["GARANTEE_ID"]), Convert.ToString(gv.SelectedDataKey["GARANTEE_NUM"]), (ReadOnly.Value ? 1 : 0)));
                break;
            case "Survey":
                Response.Redirect(String.Format("/barsroot/credit/manager/grt_survey.aspx?bid_id={0}&garantee_id={1}&garantee_num={2}&readonly={3}", BID_ID.ToString(), Convert.ToString(gv.SelectedDataKey["GARANTEE_ID"]), Convert.ToString(gv.SelectedDataKey["GARANTEE_NUM"]), (ReadOnly.Value ? 1 : 0)));
                break;
            case "Insurance":
                Response.Redirect(String.Format("/barsroot/credit/manager/grt_insurances.aspx?bid_id={0}&garantee_id={1}&garantee_num={2}&readonly={3}", BID_ID.ToString(), Convert.ToString(gv.SelectedDataKey["GARANTEE_ID"]), Convert.ToString(gv.SelectedDataKey["GARANTEE_NUM"]), (ReadOnly.Value ? 1 : 0)));
                break;
        }
    }
    protected void fv_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        e.Values["BID_ID"] = BID_ID;
    }
    protected void bNext_Click(object sender, EventArgs e)
    {
        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        try
        {
            // проверки
            if (!Validate(con, BID_ID)) return;

            if (1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_GUARANTEE"))
            {
                cmn.wp.BID_STATE_CHECK_IN(BID_ID, "NEW_GUARANTEE", (String)null);
                cmn.wp.BID_STATE_DEL(BID_ID, "NEW_GUARANTEE");
            }
            if (1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_GUARANTEE1"))
            {
                cmn.wp.BID_STATE_CHECK_IN(BID_ID, "NEW_GUARANTEE1", (String)null);
                cmn.wp.BID_STATE_DEL(BID_ID, "NEW_GUARANTEE1");
            }

            // возвращаемся в карточку заявки
            Response.Redirect(String.Format("/barsroot/credit/manager/bid_card.aspx?bid_id={0}", BID_ID.ToString()));
        }
        finally
        {
            con.CloseConnection();
        }
    }
    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Int32 STATUS_ID = Convert.ToInt32((e.Row.DataItem as VWcsBidGaranteesRecord).STATUS_ID);

            switch (STATUS_ID)
            {
                case 3 :
                    // Заповнення анкети (остаточне)
                    e.Row.Style.Add(HtmlTextWriterStyle.BackgroundColor, "#C8FFC8");
                    break;
                case 5 :
                    // Заведено
                    e.Row.Style.Add(HtmlTextWriterStyle.BackgroundColor, "#C8FFC8");
                    break;
            }
        }
    }
    protected void fv_DataBound(object sender, EventArgs e)
    {
        VWcsBidGaranteesRecord rec = (fv.DataItem as VWcsBidGaranteesRecord);

        if (fv.CurrentMode == FormViewMode.ReadOnly && fv.Row.RowType != DataControlRowType.EmptyDataRow)
        {
            CheckStateAccess(rec);
        }
    }
    # endregion

    # region Приватные методы
    private Boolean Validate(BbConnection con, Decimal? BID_ID)
    {
        Common cmn = new Common(con, BID_ID);

        // проверки
        Master.HideError();

        // вопросы группы
        List<VWcsBidGaranteesRecord> lst = (new VWcsBidGarantees(con)).SelectBidGarantees(BID_ID);
        foreach (VWcsBidGaranteesRecord rec in lst)
        {
            // проверяем что залог в стостоянии "Заповнення анкети (остаточне)"
            if ((1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_DATAINPUT") || 1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_DATAREINPUT")) && rec.STATUS_ID != 3)
            {
                Master.ShowError(String.Format(Resources.credit.StringConstants.text_grt_must_be_in_status, rec.GARANTEE_NAME, rec.GARANTEE_NUM, "'Заповнення анкети (остаточне)'"));
                return false;
            }
            // проверяем что залог в стостоянии "Заведено"
            if (1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_SIGNDOCS") && rec.STATUS_ID != 5)
            {
                Master.ShowError(String.Format(Resources.credit.StringConstants.text_grt_must_be_in_status, rec.GARANTEE_NAME, rec.GARANTEE_NUM, "'Заведено'"));
                return false;
            }
        }

        return true;
    }
    private void CheckStateAccess(VWcsBidGaranteesRecord rec)
    {
        Common cmn = new Common(new BbConnection());

        LinkButton lbtScanCopies = fv.FindControl("lbtScanCopies") as LinkButton;
        LinkButton lbtSurvey = fv.FindControl("lbtSurvey") as LinkButton;
        LinkButton lbtInsurance = fv.FindControl("lbtInsurance") as LinkButton;

        if (1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_DATAINPUT") || 1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_DATAREINPUT"))
        {
            lbtScanCopies.Enabled = true;

            if (rec.STATUS_ID > 1) lbtSurvey.Enabled = true;
            else lbtSurvey.Enabled = false;

            lbtInsurance.Enabled = false;
        } else if (1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_SIGNDOCS"))
        {
            lbtScanCopies.Enabled = true;
            lbtSurvey.Enabled = true;

            if (rec.STATUS_ID > 3) lbtInsurance.Enabled = true;
            else lbtInsurance.Enabled = false;
        }
        else if (1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_PRESCORING"))
        {
            lbtScanCopies.Enabled = false;
            lbtSurvey.Enabled = true;
            lbtInsurance.Enabled = false;
        }
        else
        {
            lbtScanCopies.Enabled = false;
            lbtSurvey.Enabled = false;
            lbtInsurance.Enabled = false;
        }
    }
    # endregion
}
