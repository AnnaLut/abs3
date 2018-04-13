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

public partial class credit_manager_prescoringresults : Bars.BarsPage
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
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.SetPageTitle(String.Format(this.Title, Convert.ToString(BID_ID)), true);

        if (!IsPostBack)
        {
            Common cmn = new Common();

            KPP.Value = cmn.wu.GET_ANSW_DECIMAL(BID_ID, "KPP");
            KPS.Value = cmn.wu.GET_ANSW_DECIMAL(BID_ID, "KPS");
            CHP.Value = cmn.wu.GET_ANSW_DECIMAL(BID_ID, "4P");
            CR.Value = cmn.wu.GET_ANSW_DECIMAL(BID_ID, "CR");
            CRISK_OBU.Value = cmn.wu.GET_ANSW_LIST_TEXT(BID_ID, "CRISK_OBU");
            CRISK_NBU.Value = cmn.wu.GET_ANSW_LIST_TEXT(BID_ID, "CRISK_NBU");
        }
    }
    # endregion
}