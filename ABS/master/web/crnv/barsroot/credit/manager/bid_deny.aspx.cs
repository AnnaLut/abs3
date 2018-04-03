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

public partial class credit_manager_bid_deny : Bars.BarsPage
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
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.SetPageTitle(String.Format(this.Title, Convert.ToString(BID_ID)), true);
    }
    protected void btDeny_Click(object sender, EventArgs e)
    {
        Common cmn = new Common();
        cmn.wp.BID_STATE_SET_IMMEDIATE(BID_ID, "NEW_DENY", Comment.Value);
        Response.Redirect(String.Format("/barsroot/credit/manager/queries.aspx"));
    }
    protected void btCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect(String.Format("/barsroot/credit/manager/bid_card.aspx?bid_id={0}", BID_ID.ToString()));
    }
    # endregion
}