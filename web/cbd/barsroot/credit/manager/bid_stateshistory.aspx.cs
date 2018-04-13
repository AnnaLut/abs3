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

public partial class credit_manager_bid_stateshistory : Bars.BarsPage
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
    # endregion
}