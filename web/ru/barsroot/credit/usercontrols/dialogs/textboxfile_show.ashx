<%@ WebHandler Language="C#" Class="textboxfile_show" %>

using System;
using System.Web;
using System.Web.SessionState;

public class textboxfile_show : IHttpHandler, IRequiresSessionState
{
    # region Публичные свойства
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
    # endregion

    # region События
    public void ProcessRequest(HttpContext context)
    {
        // идентификатор сессии
        String FileDataSessionID = context.Request.Params.Get("sid");
        String FileName = context.Request.Params.Get("fname");

        HttpContext.Current.Trace.Write("FileDataSessionID=" + FileDataSessionID + " FileName=" + FileName);
        // данные
        Byte[] Data = (Byte[])context.Session[FileDataSessionID];

        // закрываем окно
        context.Response.Write("window.close();");

        if (Data != null)
        {
            // загрузка файла в поток
            context.Response.Clear();
            context.Response.ContentType = "application/octet-stream";
            context.Response.AppendHeader("Cache-control", "private");
            context.Response.AddHeader("Content-Disposition", "attachment;filename=" + FileName);
            context.Response.Flush();
            context.Response.BinaryWrite(Data);
            context.Response.End();
        }        
    }
    # endregion
}