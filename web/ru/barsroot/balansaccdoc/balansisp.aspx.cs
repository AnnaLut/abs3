﻿using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class BalansIsp : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sDat = Convert.ToString(Request.Params.Get("fdat"));
        //Label1.Text = sDat + ": Состояние БС " + Request.Params.Get("nbs") + " (экв.) по Исполнителям";
        Label1.Text = sDat + ": " + Resources.balansaccdoc.Global.cTitleIsp + " " + Request.Params.Get("nbs") +
            " (" + Resources.balansaccdoc.Global.cEqv + ") " + Resources.balansaccdoc.Global.cByIsp;
    }
}
