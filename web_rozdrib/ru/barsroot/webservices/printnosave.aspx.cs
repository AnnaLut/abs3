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
using System.IO;

public partial class webservices_printnosave : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
            Page.GetPostBackEventReference(btPrint);
    }
    protected void btPrint_Click(object sender, EventArgs e)
    {
        string fileName = Request.Params.Get("filename");
        Response.ClearContent();
        Response.ClearHeaders();
        Response.Charset = "windows-1251";
        Response.AppendHeader("content-disposition", "attachment;filename=document.barsprn");
        Response.ContentType = "application/octet-stream";
        Response.WriteFile(fileName, true);
        Response.Flush();
        Response.Close();
        try
        {
            File.Delete(fileName);
        }
        catch { }
    }
}
