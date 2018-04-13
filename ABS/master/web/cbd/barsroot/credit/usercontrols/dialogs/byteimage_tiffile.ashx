<%@ WebHandler Language="C#" Class="Bars.UserControls.byteimage_tiffile" %>

using System;
using System.Web;
using System.Web.SessionState;
using Bars.UserControls;

namespace Bars.UserControls
{
    public class byteimage_tiffile : IHttpHandler, IRequiresSessionState
    {
        # region Приватные свойства
        private HttpContext CurentContext
        {
            get;
            set;
        }
        private String ImageDataSessionID
        {
            get
            {
                return CurentContext.Request.Params.Get("sid");
            }
        }
        private ByteData ImageData
        {
            get
            {
                if (CurentContext.Session[ImageDataSessionID] == null) return null;
                return (ByteData)CurentContext.Session[ImageDataSessionID];
            }
        }
        private Types Type
        {
            get
            {
                if (String.IsNullOrEmpty(CurentContext.Request.Params.Get("type")))
                    return Types.Original;
                else if (CurentContext.Request.Params.Get("type").ToLower() == "thumbnail")
                    return Types.Thumbnail;
                else
                    return Types.Original;
            }
        }
        private Int32? Page
        {
            get
            {
                return String.IsNullOrEmpty(CurentContext.Request.Params.Get("page")) ? (Int32?)null : Convert.ToInt16(CurentContext.Request.Params.Get("page"));
            }
        }
        private bool WholeFile
        {
            get
            {
                return !String.IsNullOrEmpty(CurentContext.Request.Params.Get("wholefile"));
            }
        }
        # endregion

        # region Приватные методы
        # endregion

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
            // сохраняем текущий контекст
            CurentContext = context;

            if (ImageData != null
                && ImageData.HasData)
            {
                if (WholeFile)
                {
                    Byte[] OutData = ImageData.Data;
                    context.Response.OutputStream.Write(OutData, 0, OutData.Length);
                }
                else
                {
                    if (ImageData.PageCount >= Page)
                    {
                        Byte[] OutData = Type == Types.Original ? ImageData.GetPage(Page.Value - 1).MainData : ImageData.GetPage(Page.Value - 1).ThumbData;
                        context.Response.OutputStream.Write(OutData, 0, OutData.Length);
                    }
                }
                
            }
        }
        # endregion
    }
}