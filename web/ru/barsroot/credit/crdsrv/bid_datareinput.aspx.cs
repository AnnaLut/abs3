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
using Oracle.DataAccess.Types;
public partial class credit_crdsrv_bid_datareinput : Bars.BarsPage
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
    public String SRV_HIERARCHY
    {
        get
        {
            return Convert.ToString(Request.Params.Get("srvhr"));
        }
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.SetPageTitle(String.Format(this.Title, Convert.ToString(BID_ID)), true);
    }
    protected void btDataReInput_Click(object sender, EventArgs e)
    {
        BbConnection con = new BbConnection();
        Common cmn = new Common(con);

        // проверка довведенных данные если была доработка
        if (1 == cmn.wu.HAS_BID_STATE(BID_ID, "NEW_DATAREINPUT_FINISHED"))
        {
            cmn.wp.BID_STATE_CHECK_IN(BID_ID, "NEW_DATAREINPUT_FINISHED", (String)null);
            cmn.wp.BID_STATE_DEL(BID_ID, "NEW_DATAREINPUT_FINISHED");
        }

        cmn.wp.BID_STATE_SET(BID_ID, "NEW_DATAREINPUT", Comment.Value);
        Response.Redirect(String.Format("/barsroot/credit/crdsrv/queries.aspx?srvhr={0}", SRV_HIERARCHY));
    }
    protected void btCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect(String.Format("/barsroot/credit/crdsrv/bid_card.aspx?srvhr={0}&bid_id={1}", SRV_HIERARCHY, BID_ID));
    }
    # endregion
}