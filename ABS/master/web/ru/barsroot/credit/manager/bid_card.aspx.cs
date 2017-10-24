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
using credit;

using Bars.Classes;
using ibank.core;

public partial class credit_manager_bid_card : Bars.BarsPage
{
    # region Приватные свойства
    private VWcsBidsRecord _BidRecord;
    private Boolean? _ReadOnly = null;
    # endregion

    # region Публичные свойства
    public Decimal? BID_ID
    {
        get
        {
            return Convert.ToDecimal(Request.Params.Get("bid_id"));
        }
    }
    public String SRVHR
    {
        get
        {
            return Request.Params.Get("srvhr");
        }
    }
    public VWcsBidsRecord BidRecord
    {
        get
        {
            if (_BidRecord == null)
            {
                List<VWcsBidsRecord> lst = (new VWcsBids()).SelectBid(BID_ID);
                if (lst.Count > 0) _BidRecord = lst[0];
            }

            return _BidRecord;
        }
    }
    public Boolean? ReadOnly
    {
        get
        {
            if (_ReadOnly == null)
            {
                Common cmn = new Common(new BbConnection());
                _ReadOnly = (1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_DATAINPUT") || 1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_DATAREINPUT"));
            }

            return _ReadOnly;
        }
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BbConnection con = new BbConnection();
            Common cmn = new Common(con);

            try
            {
                // чекаут состояния
                if (1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_DATAINPUT"))
                    cmn.wp.BID_STATE_CHECK_OUT(BID_ID, "NEW_DATAINPUT", (String)null);
                if (1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_DATAREINPUT"))
                    cmn.wp.BID_STATE_CHECK_OUT(BID_ID, "NEW_DATAREINPUT", (String)null);
                if (1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_SIGNDOCS"))
                    cmn.wp.BID_STATE_CHECK_OUT(BID_ID, "NEW_SIGNDOCS", (String)null);
                if (1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_FT_DATAINPUT"))
                    cmn.wp.BID_STATE_CHECK_OUT(BID_ID, "NEW_FT_DATAINPUT", (String)null);
                if (1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_PREVIOUS_SOLUTION"))
                    cmn.wp.BID_STATE_CHECK_OUT(BID_ID, "NEW_PREVIOUS_SOLUTION", (String)null);
            }
            finally
            {
                con.CloseConnection();
            }
        }

        Master.SetPageTitle(this.Title + Convert.ToString(BidRecord.BID_ID), true);

        CheckStateAccess();
    }
    protected void fv_ItemCommand(object sender, FormViewCommandEventArgs e)
    {
        Common cmn = new Common(new BbConnection());

        switch (e.CommandName)
        {
            case "CREDITDATA":
                Response.Redirect(String.Format("/barsroot/credit/manager/creditdata.aspx?bid_id={0}&readonly={1}&srvhr={2}", BID_ID.ToString(), (ReadOnly.Value ? 1 : 0), SRVHR));
                break;
            case "SCANCOPY":
                Response.Redirect(String.Format("/barsroot/credit/manager/scancopy.aspx?bid_id={0}&readonly={1}&srvhr={2}", BID_ID.ToString(), (ReadOnly.Value ? 1 : 0), SRVHR));
                break;
            case "AUTH":
                Response.Redirect(String.Format("/barsroot/credit/manager/auth.aspx?bid_id={0}&readonly={1}", BID_ID.ToString(), (ReadOnly.Value ? 1 : 0)));
                break;
            case "SURVEY":
                Response.Redirect(String.Format("/barsroot/wcs/questionnaire/customerqnaire/?bid_id={0}&readonly={1}&srvhr={2}", BID_ID.ToString(), (ReadOnly.Value ? 1 : 0), SRVHR));
                //Response.Redirect(String.Format("/barsroot/credit/manager/survey.aspx?bid_id={0}&readonly={1}&srvhr={2}", BID_ID.ToString(), (ReadOnly.Value ? 1 : 0), SRVHR));
                break;
            case "GARANTEE":
                Response.Redirect(String.Format("/barsroot/credit/manager/garantees.aspx?bid_id={0}&readonly={1}&srvhr={2}", BID_ID.ToString(), (ReadOnly.Value ? 1 : 0), SRVHR));
                break;
            case "INSURANCE":
                Response.Redirect(String.Format("/barsroot/credit/manager/insurances.aspx?bid_id={0}&readonly={1}", BID_ID.ToString(), (ReadOnly.Value ? 1 : 0)));
                break;
            case "DOCS":
                Response.Redirect(String.Format("/barsroot/credit/manager/printdocs.aspx?bid_id={0}&readonly={1}&srvhr={2}", BID_ID.ToString(), (ReadOnly.Value ? 1 : 0), SRVHR));
                break;
            case "PARTNER":
                Response.Redirect(String.Format("/barsroot/credit/manager/payment.aspx?bid_id={0}&readonly={1}", BID_ID.ToString(), (ReadOnly.Value ? 1 : 0)));
                break;
            case "CURACCOUNT":
                Response.Redirect(String.Format("/barsroot/credit/manager/curaccount.aspx?bid_id={0}&readonly={1}", BID_ID.ToString(), (ReadOnly.Value ? 1 : 0)));
                break;

            case "STATESHISTORY":
                Response.Redirect(String.Format("/barsroot/credit/manager/bid_stateshistory.aspx?bid_id={0}", BID_ID.ToString()));
                break;
            case "FinishDataInput":
                if (1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_DATAINPUT_FINISHED"))
                {
                    // завершаем состояние ввода данных
                    cmn.wp.BID_STATE_DEL(BID_ID, "NEW_DATAINPUT_FINISHED");
                    cmn.wp.BID_STATE_CHECK_IN(BID_ID, "NEW_DATAINPUT", (String)null);
                    cmn.wp.BID_STATE_DEL(BID_ID, "NEW_DATAINPUT");
                }
                if (1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_FT_DATAINPUT_FINISHED"))
                {
                    // завершаем состояние ввода данных
                    cmn.wp.BID_STATE_DEL(BID_ID, "NEW_FT_DATAINPUT_FINISHED");
                    cmn.wp.BID_STATE_CHECK_IN(BID_ID, "NEW_FT_DATAINPUT", (String)null);
                    cmn.wp.BID_STATE_DEL(BID_ID, "NEW_FT_DATAINPUT");
                }

                if (1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_CA_CREDIT_S"))
                {
                    Response.Redirect(String.Format("/barsroot/credit/crdsrv/bid_card.aspx?bid_id={0}srvhr={1}", BID_ID.ToString(), SRVHR));
                }
                else 
                {
                    Response.Redirect(String.Format("/barsroot/credit/manager/queries.aspx"));
                }
                break;
            case "FinishDataReinput":
                // завершаем состояние доработки
                cmn.wp.BID_STATE_CHECK_IN(BID_ID, "NEW_DATAREINPUT", (String)null);
                cmn.wp.BID_STATE_DEL(BID_ID, "NEW_DATAREINPUT");

                Response.Redirect(String.Format("/barsroot/credit/manager/queries.aspx"));
                break;
            case "FinishSigndocs":
                // завершаем состояние подписания договоров
                cmn.wp.BID_STATE_DEL(BID_ID, "NEW_SIGNDOCS_FINISHED");
                cmn.wp.BID_STATE_CHECK_IN(BID_ID, "NEW_SIGNDOCS", (String)null);
                cmn.wp.BID_STATE_DEL(BID_ID, "NEW_SIGNDOCS");

                Response.Redirect(String.Format("/barsroot/credit/manager/queries.aspx"));
                break;
            case "ChangeDealDate":
                // устанавливаем состояние ввода даты договора
                cmn.wp.BID_STATE_SET(BID_ID, "NEW_CREDITDATA_SD", Resources.credit.StringConstants.text_deal_date_change);
                Response.Redirect(String.Format("/barsroot/credit/manager/creditdata.aspx?bid_id={0}&readonly={1}&srvhr={2}", BID_ID.ToString(), (ReadOnly.Value ? 1 : 0), SRVHR));
                break;
            case "Deny":
                Response.Redirect(String.Format("/barsroot/credit/manager/bid_deny.aspx?bid_id={0}", BID_ID.ToString()));
                break;

            case "PreScoringResults":
                Response.Redirect(String.Format("/barsroot/credit/manager/prescoringresults.aspx?bid_id={0}", BID_ID.ToString()));
                break;
            case "DeleteBid":
                // удаляем предварительную заявку
                cmn.wp.BID_DEL(BID_ID);

                Response.Redirect(String.Format("/barsroot/credit/manager/queries.aspx"));
                break;
            case "CreateNew":
                // создаем новую заявку из предварительной
                ScriptManager.RegisterStartupScript(this, typeof(String), "redirect", "location.replace('/barsroot/credit/manager/inn_create.aspx?bid_id=" + Convert.ToString(BID_ID) + "');", true);
                break;
            case "CreateFromFT":
                cmn.wp.BID_STATE_DEL(BID_ID, "NEW_PREVIOUS_SOLUTION");
                cmn.wp.BID_STATE_SET(BID_ID, "NEW_DATAINPUT",String.Format("Створено на основі попереднього рішення"));
                cmn.wp.BID_STATE_CHECK_OUT(BID_ID, "NEW_SURVEY", (String)null);
                cmn.wp.BID_STATE_CHECK_IN(BID_ID, "NEW_SURVEY", (String)null);
                cmn.wp.BID_STATE_DEL(BID_ID, "NEW_SURVEY");
                cmn.wp.BID_STATE_CHECK_OUT(BID_ID, "NEW_CREDITDATA_DI", (String)null);
                cmn.wp.BID_STATE_CHECK_IN(BID_ID, "NEW_CREDITDATA_DI", (String)null);
                cmn.wp.BID_STATE_DEL(BID_ID, "NEW_CREDITDATA_DI");
                cmn.wp.BID_STATE_CHECK_OUT(BID_ID, "NEW_GUARANTEE", (String)null);
                cmn.wp.BID_STATE_CHECK_IN(BID_ID, "NEW_GUARANTEE", (String)null);
                cmn.wp.BID_STATE_DEL(BID_ID, "NEW_GUARANTEE");
                cmn.wp.BID_STATE_CHECK_OUT(BID_ID, "NEW_SCANCOPY", (String)null);
                cmn.wp.BID_STATE_CHECK_IN(BID_ID, "NEW_SCANCOPY", (String)null);
                cmn.wp.BID_STATE_DEL(BID_ID, "NEW_SCANCOPY");
                cmn.wp.BID_STATE_SET(BID_ID, "NEW_DATAINPUT_FINISHED", (String)null);
                ScriptManager.RegisterStartupScript(this, typeof(String), "redirect", "location.replace('/barsroot/credit/manager/bid_card.aspx?bid_id=" + Convert.ToString(BID_ID) + "&srvhr=" + SRVHR + "');", true);
                break;
        }
    }
    # endregion

    # region Приватные методы
    private void CheckStateAccess()
    {
        Common cmn = new Common(new BbConnection());

        LinkButton lbCREDITDATA = fv.FindControl("lbCREDITDATA") as LinkButton;
        LinkButton lbSCANCOPY = fv.FindControl("lbSCANCOPY") as LinkButton;
        //LinkButton lbAUTH = fv.FindControl("lbAUTH") as LinkButton;
        LinkButton lbSURVEY = fv.FindControl("lbSURVEY") as LinkButton;
        LinkButton lbGARANTEE = fv.FindControl("lbGARANTEE") as LinkButton;
        LinkButton lbPARTNER = fv.FindControl("lbPARTNER") as LinkButton;
        LinkButton lbCurAccount = fv.FindControl("lbCurAccount") as LinkButton;
        LinkButton lbDOCS = fv.FindControl("lbDOCS") as LinkButton;
        LinkButton lbINSURANCE = fv.FindControl("lbINSURANCE") as LinkButton;

        if (1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_DATAINPUT") || 1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_DATAREINPUT"))
        {
            lbCREDITDATA.Enabled = (1 == cmn.wu.HAD_BID_STATE(BID_ID, "NEW_CREDITDATA_DI") || 1 == cmn.wu.HAD_BID_STATE(BID_ID, "NEW_FT_CREDITDATA_DI"));
            lbSCANCOPY.Enabled = (1 == cmn.wu.HAD_BID_STATE(BID_ID, "NEW_SCANCOPY") || 1 == cmn.wu.HAD_BID_STATE(BID_ID, "NEW_FT_SCANCOPY"));
            //lbAUTH.Enabled = (1 == cmn.wu.HAD_BID_STATE(BID_ID, "NEW_AUTH"));
            lbSURVEY.Enabled = (1 == cmn.wu.HAD_BID_STATE(BID_ID, "NEW_SURVEY") || 1 == cmn.wu.HAD_BID_STATE(BID_ID, "NEW_FT_SURVEY"));
            lbGARANTEE.Enabled = (1 == cmn.wu.HAD_BID_STATE(BID_ID, "NEW_GUARANTEE") || 1 == cmn.wu.HAD_BID_STATE(BID_ID, "NEW_FT_GUARANTEE"));
            lbPARTNER.Enabled = (1 == cmn.wu.HAD_BID_STATE(BID_ID, "NEW_PARTNER"));
            lbDOCS.Enabled = (1 == cmn.wu.HAD_BID_STATE(BID_ID, "NEW_DOCS0") || 1 == cmn.wu.HAD_BID_STATE(BID_ID, "NEW_FT_DOCS0"));

            lbCurAccount.Enabled = false;
            lbINSURANCE.Enabled = (1 == cmn.wu.HAD_BID_STATE(BID_ID, "NEW_INS_CLIENT"));
        }
        else if (1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_SIGNDOCS"))
        {
            lbCREDITDATA.Enabled = (1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_CREDITDATA_SD"));
            lbSCANCOPY.Enabled = false;
            //lbAUTH.Enabled = false;
            lbSURVEY.Enabled = false;//(1 != cmn.wu.HAS_BID_STATE(BID_ID, "NEW_CREDITDATA_SD"));
            //lbSURVEY.Text = (1 != cmn.wu.HAS_BID_STATE(BID_ID, "NEW_CREDITDATA_SD") ? "Вартість послуг" : "Анкета Клієнта");
            lbGARANTEE.Enabled = (1 == cmn.wu.HAD_BID_STATE(BID_ID, "NEW_GUARANTEE1"));
            lbPARTNER.Enabled = (1 != cmn.wu.HAS_BID_STATE(BID_ID, "NEW_CREDITDATA_SD") && 1 != cmn.wu.GET_ANSW_BOOL(BID_ID, "PI_FREE_MFO") && 1 != cmn.wu.GET_ANSW_BOOL(BID_ID, "PI_FREE_NLS") && 1 != cmn.wu.GET_ANSW_BOOL(BID_ID, "PI_FREE_OKPO") && 1 != cmn.wu.GET_ANSW_BOOL(BID_ID, "PI_FREE_NAME"));
            lbCurAccount.Enabled = (1 == cmn.wu.HAD_BID_STATE(BID_ID, "NEW_CURACC"));
            lbDOCS.Enabled = (1 == cmn.wu.HAD_BID_STATE(BID_ID, "NEW_DOCS1"));
            lbINSURANCE.Enabled = (1 != cmn.wu.HAS_BID_STATE(BID_ID, "NEW_CREDITDATA_SD") && 1 == cmn.wu.HAD_BID_STATE(BID_ID, "NEW_INS_CLIENT"));
        }
        else if (1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_PRESCORING"))
        {
            lbCREDITDATA.Enabled = true;
            lbSCANCOPY.Enabled = false;
            //lbAUTH.Enabled = false;
            lbSURVEY.Enabled = true;
            lbGARANTEE.Enabled = true;
            lbPARTNER.Enabled = false;
            lbCurAccount.Enabled = false;
            lbDOCS.Enabled = false;
            lbINSURANCE.Enabled = false;
        }
        else if (1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_FT_DATAINPUT"))
        {
            lbCREDITDATA.Enabled = (1 == cmn.wu.HAD_BID_STATE(BID_ID, "NEW_FT_CREDITDATA_DI"));
            lbSCANCOPY.Enabled = (1 == cmn.wu.HAD_BID_STATE(BID_ID, "NEW_FT_SCANCOPY"));
            //lbAUTH.Enabled = (1 == cmn.wu.HAD_BID_STATE(BID_ID, "NEW_FT_AUTH"));
            lbSURVEY.Enabled = (1 == cmn.wu.HAD_BID_STATE(BID_ID, "NEW_FT_SURVEY"));
            lbGARANTEE.Enabled = (1 == cmn.wu.HAD_BID_STATE(BID_ID, "NEW_FT_GUARANTEE"));
            lbPARTNER.Enabled = false;//(1 == cmn.wu.HAD_BID_STATE(BID_ID, "NEW_PARTNER"));
            lbDOCS.Enabled = (1 == cmn.wu.HAD_BID_STATE(BID_ID, "NEW_FT_DOCS0"));

            lbCurAccount.Enabled = false;
            lbINSURANCE.Enabled = false;//(1 == cmn.wu.HAD_BID_STATE(BID_ID, "NEW_INS_CLIENT"));
        }
        else if (1 == cmn.wu.HAD_BID_STATE(BID_ID, "NEW_FT_DATAINPUT") && 1!= cmn.wu.HAS_BID_STATE(BID_ID,"NEW_DATAINPUT") && SRVHR == "CA")
        {
            lbCREDITDATA.Enabled = (1 == cmn.wu.HAD_BID_STATE(BID_ID, "NEW_FT_CREDITDATA_DI"));
            lbSCANCOPY.Enabled = (1 == cmn.wu.HAD_BID_STATE(BID_ID, "NEW_FT_SCANCOPY"));
            //lbAUTH.Enabled = (1 == cmn.wu.HAD_BID_STATE(BID_ID, "NEW_FT_AUTH"));
            lbSURVEY.Enabled = (1 == cmn.wu.HAD_BID_STATE(BID_ID, "NEW_FT_SURVEY"));
            lbGARANTEE.Enabled = (1 == cmn.wu.HAD_BID_STATE(BID_ID, "NEW_FT_GUARANTEE"));
            lbPARTNER.Enabled = false;//(1 == cmn.wu.HAD_BID_STATE(BID_ID, "NEW_PARTNER"));
            lbDOCS.Enabled = (1 == cmn.wu.HAD_BID_STATE(BID_ID, "NEW_FT_DOCS0"));

            lbCurAccount.Enabled = false;
            lbINSURANCE.Enabled = false;//(1 == cmn.wu.HAD_BID_STATE(BID_ID, "NEW_INS_CLIENT"));
        }
        else
        {
            lbCREDITDATA.Enabled = false;
            lbSCANCOPY.Enabled = false;
            //lbAUTH.Enabled = false;
            lbSURVEY.Enabled = false;
            lbGARANTEE.Enabled = false;
            lbPARTNER.Enabled = false;
            lbCurAccount.Enabled = false;
            lbDOCS.Enabled = false;
            lbINSURANCE.Enabled = false;
        }
        if (1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_PREVIOUS_SOLUTION"))
        {
            lbCREDITDATA.Enabled = false;
            lbSCANCOPY.Enabled = false;
            //lbAUTH.Enabled = false;
            lbSURVEY.Enabled = false;
            lbGARANTEE.Enabled = false;
            lbPARTNER.Enabled = false;
            lbCurAccount.Enabled = false;
            lbDOCS.Enabled = false;
            lbINSURANCE.Enabled = false;
        }
        //if (1 == cmn.wu.HAD_BID_STATE(BID_ID, "NEW_FT_DATAINPUT") && 1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_CA_CREDIT_S") && 1 != cmn.wu.HAS_BID_STATE(BID_ID, "NEW_DATAREINPUT"))
        //{
        //    lbCREDITDATA.Enabled = false;
        //    lbSCANCOPY.Enabled = false;
        //    //lbAUTH.Enabled = false;
        //    lbSURVEY.Enabled = false;
        //    lbGARANTEE.Enabled = false;
        //    lbPARTNER.Enabled = false;
        //    lbCurAccount.Enabled = false;
        //    lbDOCS.Enabled = false;
        //    lbINSURANCE.Enabled = false;
        //}

        LinkButton lbFinishDataInput = fv.FindControl("lbFinishDataInput") as LinkButton;
        LinkButton lbFinishDataReinput = fv.FindControl("lbFinishDataReinput") as LinkButton;
        LinkButton lbFinishSigndocs = fv.FindControl("lbFinishSigndocs") as LinkButton;
        LinkButton lbChangeDealDate = fv.FindControl("lbChangeDealDate") as LinkButton;
        LinkButton lbDeny = fv.FindControl("lbDeny") as LinkButton;

        LinkButton lbPreScoringResults = fv.FindControl("lbPreScoringResults") as LinkButton;
        LinkButton lbDeleteBid = fv.FindControl("lbDeleteBid") as LinkButton;
        LinkButton lbCreateNew = fv.FindControl("lbCreateNew") as LinkButton;
        LinkButton lbCreateFromFT = fv.FindControl("lbCreateFromFT") as LinkButton;

        lbFinishDataInput.Enabled = ((1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_DATAINPUT_FINISHED")) 
            || (1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_FT_DATAINPUT_FINISHED")) 
            || (1 == cmn.wu.HAD_BID_STATE(BID_ID, "NEW_FT_DATAINPUT_FINISHED") && 1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_CA_CREDIT_S") && SRVHR == "CA") 
            && 1 != cmn.wu.HAS_BID_STATE(BID_ID, "NEW_DATAREINPUT"));
        lbFinishDataReinput.Enabled = (1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_DATAREINPUT"));
        lbFinishSigndocs.Enabled = (1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_SIGNDOCS_FINISHED"));
        lbChangeDealDate.Enabled = (1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_SIGNDOCS") &&
                                    1 != cmn.wu.HAS_BID_STATE(BID_ID, "NEW_CREDITDATA_SD"));
        lbDeny.Enabled = (1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_DATAINPUT") ||
                          1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_DATAREINPUT") ||
                          1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_SIGNDOCS"));

        if (1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_PRESCORING"))
        {
            lbFinishDataInput.Visible = false;
            lbFinishDataReinput.Visible = false;
            lbFinishSigndocs.Visible = false;
            lbDeny.Visible = false;

            lbPreScoringResults.Visible = true;
            lbDeleteBid.Visible = true;
            lbCreateNew.Visible = true;
            lbCreateFromFT.Visible = false;
        }
        else if (1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_PREVIOUS_SOLUTION"))
        {
            lbFinishDataInput.Visible = false;
            lbFinishDataReinput.Visible = false;
            lbFinishSigndocs.Visible = false;
            lbDeny.Visible = true;

            lbPreScoringResults.Visible = false;
            lbDeleteBid.Visible = false;
            lbCreateNew.Visible = false;
            lbCreateFromFT.Visible = true;

            lbDeny.Enabled = true;
            lbChangeDealDate.Visible = false;
        }
        else
        {
            lbFinishDataInput.Visible = true;
            lbFinishDataReinput.Visible = true;
            lbFinishSigndocs.Visible = true;
            lbDeny.Visible = true;

            lbPreScoringResults.Visible = false;
            lbDeleteBid.Visible = false;
            lbCreateNew.Visible = false;
            lbCreateFromFT.Visible = false;
        }
    }
    # endregion
}