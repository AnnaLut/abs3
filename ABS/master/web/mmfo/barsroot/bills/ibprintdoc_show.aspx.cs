using System;

/// <summary>
/// 
/// </summary>
public partial class credit_usercontrols_dialogs_ibprintdoc_show : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Clear();
        Response.ContentType = "application/msword";
        Response.Flush();
        Response.WriteFile(Request.Params.Get("filename"));
        Response.End();
    }
}
