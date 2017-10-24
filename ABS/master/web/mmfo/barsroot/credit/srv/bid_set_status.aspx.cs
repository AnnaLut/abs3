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

public partial class credit_crdsrv_bid_set_status : Bars.BarsPage
{
    # region Приватные свойства
    private VWcsBidsRecord _BidRecord;
    # endregion

    # region Публичные свойства
    public Decimal? BID_ID
    {
        get
        {
            return Convert.ToDecimal(Request.Params.Get("bid_id"));
        }
    }
    public String SRV
    {
        get
        {
            return Convert.ToString(Request.Params.Get("srv"));
        }
    }
    public String SRV_HIERARCHY
    {
        get
        {
            return Convert.ToString(Request.Params.Get("srvhr"));
        }
    }
    public String WS_ID
    {
        get
        {
            return "SRV_" + Convert.ToString(Request.Params.Get("srvhr"));
        }
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.SetPageTitle(String.Format(this.Title, Convert.ToString(BID_ID)), true);
        sds.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        sds.SelectCommand = "select * from v_wcs_question_list_items where question_id = 'SRVICE_END_RESULT_" + SRV.ToUpper() + "'";
        sds.DataBind();
    }
    protected void btSetStatus_Click(object sender, EventArgs e)
    {
        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        switch (SRV_HIERARCHY.ToUpper())
        {
            case "RU":
                switch (SRV.ToUpper())
                {
                    case "SS":
                        cmn.wp.BID_STATE_CHECK_IN(BID_ID, "NEW_RU_SECURITY_S_PRC", GetSrvConclusion(con, BID_ID));
                        cmn.wp.BID_STATE_DEL(BID_ID, "NEW_RU_SECURITY_S_PRC");
                        break;
                    case "LS":
                        cmn.wp.BID_STATE_CHECK_IN(BID_ID, "NEW_RU_LAW_S_PRC", GetSrvConclusion(con, BID_ID));
                        cmn.wp.BID_STATE_DEL(BID_ID, "NEW_RU_LAW_S_PRC");
                        break;
                    case "AS":
                        cmn.wp.BID_STATE_CHECK_IN(BID_ID, "NEW_RU_PROBLEMACTIVE_S_PRC", GetSrvConclusion(con, BID_ID));
                        cmn.wp.BID_STATE_DEL(BID_ID, "NEW_RU_PROBLEMACTIVE_S_PRC");
                        break;
                }
                break;
            case "CA":
                switch (SRV.ToUpper())
                {
                    case "SS":
                        cmn.wp.BID_STATE_CHECK_IN(BID_ID, "NEW_CA_SECURITY_S_PRC", GetSrvConclusion(con, BID_ID));
                        cmn.wp.BID_STATE_DEL(BID_ID, "NEW_CA_SECURITY_S_PRC");
                        break;
                    case "LS":
                        cmn.wp.BID_STATE_CHECK_IN(BID_ID, "NEW_CA_LAW_S_PRC", GetSrvConclusion(con, BID_ID));
                        cmn.wp.BID_STATE_DEL(BID_ID, "NEW_CA_LAW_S_PRC");
                        break;
                    case "AS":
                        cmn.wp.BID_STATE_CHECK_IN(BID_ID, "NEW_CA_PROBLEMACTIVE_S_PRC", GetSrvConclusion(con, BID_ID));
                        cmn.wp.BID_STATE_DEL(BID_ID, "NEW_CA_PROBLEMACTIVE_S_PRC");
                        break;
                    case "RS":
                        cmn.wp.BID_STATE_CHECK_IN(BID_ID, "NEW_CA_RISK_S_PRC", GetSrvConclusion(con, BID_ID));
                        cmn.wp.BID_STATE_DEL(BID_ID, "NEW_CA_RISK_S_PRC");
                        break;
                    case "FS":
                        cmn.wp.BID_STATE_CHECK_IN(BID_ID, "NEW_CA_FINANCE_S_PRC", GetSrvConclusion(con, BID_ID));
                        cmn.wp.BID_STATE_DEL(BID_ID, "NEW_CA_FINANCE_S_PRC");
                        break;
                }
                break;
        }
        Response.Redirect(String.Format("/barsroot/credit/srv/queries.aspx?srv={0}&srvhr={1}", SRV, SRV_HIERARCHY));
    }
    protected void btCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect(String.Format("/barsroot/credit/srv/bid_card.aspx?srv={0}&srvhr={1}&bid_id={2}", SRV, SRV_HIERARCHY, BID_ID));
    }

    private String GetSrvConclusion(BbConnection con, Decimal? BID_ID)
    {
        Common cmn = new Common(con, BID_ID);
        String SrvConclusion = String.Empty;

        String IQUERY_ID = String.Empty;
        String QUESTION_ID = String.Empty;
        switch (SRV.ToUpper())
        {
            case "SS":
                IQUERY_ID = "IQ_CONCL_SECURITY_S";
                QUESTION_ID = "SRVICE_END_RESULT_SS";
                break;
            case "LS":
                IQUERY_ID = "IQ_CONCL_LAW_S";
                QUESTION_ID = "SRVICE_END_RESULT_LS";
                break;
            case "AS":
                IQUERY_ID = "IQ_CONCL_ASSETS_S";
                QUESTION_ID = "SRVICE_END_RESULT_AS";
                break;
            case "RS":
                IQUERY_ID = "IQ_CONCL_RISK_S";
                QUESTION_ID = "SRVICE_END_RESULT_RS";
                break;
            case "FS":
                IQUERY_ID = "IQ_CONCL_FINANCE_S";
                QUESTION_ID = "SRVICE_END_RESULT_FS";
                break;
        }
        
        String status = ddlStatus.Value.ToString();
        String comment = Comment.Value;

        cmn.wu.SET_ANSW(BID_ID, QUESTION_ID, status, WS_ID, 0);
        if (Convert.ToInt16(status) == 0 || Convert.ToInt16(status) == 2)
        {
            cmn.wu.STOP_IQUERY(BID_ID, IQUERY_ID, WS_ID, "DONE");
        }
        else
        {
            cmn.wu.STOP_IQUERY(BID_ID, IQUERY_ID, WS_ID, "ERROR", comment);
        }

        return comment;
    }
    # endregion
}