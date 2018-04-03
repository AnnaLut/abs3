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

public partial class credit_usercontrols_dialogs_ibprintdoc_show : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Clear();
        Response.ContentType = "application/msword";
        Response.Flush();
        Response.WriteFile(Request.Params.Get("filename"));
        Response.End();

        /*context.Response.Clear();
            context.Response.ContentType = "application/octet-stream";
            context.Response.AppendHeader("Cache-control", "private");
            context.Response.AddHeader("Content-Disposition", "attachment;filename=" + FileName);
            context.Response.Flush();
            context.Response.BinaryWrite(Data);
            context.Response.End();*/
    }
}
