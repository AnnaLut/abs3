using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Success : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        label_fn.Text = Convert.ToString(Request.Params["fn"]);
        link_next.NavigateUrl = Server.HtmlDecode(Convert.ToString(Session["exchange.url"]));
    }
}
