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

public partial class Balans : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DIV1.InnerText = Resources.balansaccdoc.Global.cTobo;
    }

}
