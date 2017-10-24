<%@ WebHandler Language="C#" Class="handler" %>

using System;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.SessionState;
using System.IO;
using System.Web.UI;
using cim;
using barsroot.cim;

public class handler : IHttpHandler, IRequiresSessionState
{
    public void ProcessRequest(HttpContext context)
    {
        string action = context.Request["action"];
        if (action == "error")
        {
            if (context.Session[Constants.StateKeys.LastError] == null)
            {
                context.Response.Write(string.Empty);
            }
            else
            {
                string message = Convert.ToString(context.Session[Constants.StateKeys.LastError]);
                if (string.IsNullOrEmpty(message))
                    message = "Невизначена помилка";

                Panel pn = new Panel();
                Label lb = new Label();
                lb.Text = message;
                pn.Controls.Add(lb);
                string rec_id = Convert.ToString(context.Session[Constants.StateKeys.LastErrorRecID]);

                StringWriter sw = new StringWriter();
                HtmlTextWriter writer = new HtmlTextWriter(sw);
                pn.RenderControl(writer);

                context.Response.Write(sw.ToString());
            }
        }
        else if (action == "download")
        {
            string filePath = context.Request["file"];
            string fileName = context.Request["fname"];
            string fileExt = context.Request["fext"];
            if (string.IsNullOrEmpty(fileName))
                fileName = Path.GetFileNameWithoutExtension(filePath);
            if (string.IsNullOrEmpty(fileExt))
                fileName += Path.GetExtension(filePath);
            else
                fileName += (fileExt.StartsWith("."))?(fileExt):("." + fileExt);
            
            try
            {
                context.Response.Charset = "windows-1251";
                context.Response.AppendHeader("content-disposition", "attachment;filename=" + Uri.EscapeDataString(fileName));
                context.Response.ContentType = "application/octet-stream";
                context.Response.WriteFile(filePath, true);
                context.Response.Flush();
                context.Response.End();
            }
            finally
            {
                if (File.Exists(filePath))
                   File.Delete(filePath);
            }
        }
        context.Response.End();
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}