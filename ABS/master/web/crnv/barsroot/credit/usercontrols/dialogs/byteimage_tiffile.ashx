<%@ WebHandler Language="C#" Class="byteimage_tiffile" %>

using System;
using System.Web;
using System.Web.SessionState;

public class byteimage_tiffile : IHttpHandler, IRequiresSessionState
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

        // загрузка файла в поток
        if (context.Session[FileDataSessionID] != null)
        {
            Byte[] FileData = (Byte[])context.Session[FileDataSessionID];
            context.Response.OutputStream.Write(FileData, 0, FileData.Length);
        }
    }
    # endregion
}