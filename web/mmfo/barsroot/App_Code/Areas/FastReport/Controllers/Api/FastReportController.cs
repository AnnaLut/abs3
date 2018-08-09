using System;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Net.Http.Headers;
using System.Xml.Serialization;
using System.Xml;
using System.Diagnostics;
using BarsWeb.Areas.FastReport.ModelBinders;
using BarsWeb.Areas.FastReport.Models;
using BarsWeb.Areas.FastReport.Helpers;
using Newtonsoft.Json;

namespace BarsWeb.Areas.FastReport.Controllers.Api
{
    public class FastReportController : ApiController
    {
        public FastReportController() { }

        [HttpPost]
        public HttpResponseMessage GetFileInBase64([System.Web.Mvc.ModelBinder(typeof(FastReportModelBinderd))]FastReportModel model)
        {
            HttpResponseMessage result = new HttpResponseMessage(HttpStatusCode.OK);
            if (model != null)
            {
                FrxDocHelper frxDocHelper = new FrxDocHelper(model);
                String stringResult = frxDocHelper.GetFileInBase64String();
                result.Content = new StringContent(stringResult);
                result.Content.Headers.ContentType = new MediaTypeHeaderValue(frxDocHelper.GetContentType());
            }
            else
            {
                result.Content = new StringContent("");
                result.Content.Headers.ContentType = new MediaTypeHeaderValue("text/plain");
            }
            return result;
        }

        [HttpPost]
        public HttpResponseMessage GetFile([System.Web.Mvc.ModelBinder(typeof(FastReportModelBinderd))]FastReportModel model)
        {
            HttpResponseMessage result = new HttpResponseMessage(HttpStatusCode.OK);
            if (model != null)
            {
                FrxDocHelper frxDocHelper = new FrxDocHelper(model);
                result.Content = new ByteArrayContent(frxDocHelper.GetFileInByteArray());
                result.Content.Headers.ContentDisposition =
                new ContentDispositionHeaderValue("attachment")
                {
                    FileName = "file" + frxDocHelper.GetFileType()
                };
                result.Content.Headers.ContentType = new MediaTypeHeaderValue(frxDocHelper.GetContentType());
            }
            else
            {
                result.Content = new StringContent("");
                result.Content.Headers.ContentType = new MediaTypeHeaderValue("text/plain");
            }
            return result;
        }

    }
}
