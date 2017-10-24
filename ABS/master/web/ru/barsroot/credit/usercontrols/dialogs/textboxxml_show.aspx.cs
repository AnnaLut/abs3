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

public partial class dialogs_textboxxml_show : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // идентификатор сессии
        String XMLDataSessionID = Request.Params.Get("sid");
        String FileName = Request.Params.Get("fname");

        HttpContext.Current.Trace.Write("XMLDataSessionID=" + XMLDataSessionID + " FileName=" + FileName);
        // данные
        String XMLData = (String)Session[XMLDataSessionID];
        lit.InnerHtml = HttpUtility.HtmlDecode(XMLData);
    }
}
