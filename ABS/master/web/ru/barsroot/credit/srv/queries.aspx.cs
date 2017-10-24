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
using Bars.UserControls;
using System.Drawing;

using Bars.Classes;
using ibank.core;

public partial class credit_srv_queries : Bars.BarsPage
{
    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        gv.DataBind();
    }
    # endregion
}