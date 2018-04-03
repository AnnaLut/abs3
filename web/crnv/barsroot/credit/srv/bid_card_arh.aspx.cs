using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Collections.Generic;
using credit;

using Bars.Classes;
using ibank.core;

public partial class credit_srv_bid_card_arh : System.Web.UI.Page
{
    # region Приватные свойства
    # endregion

    # region Публичные свойства
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.SetPageTitle(String.Format(this.Title, Convert.ToString(Master.BidRecord.BID_ID)), true);
        Master.FillData();
    }
    # endregion

    # region Приватные методы
    # endregion
}