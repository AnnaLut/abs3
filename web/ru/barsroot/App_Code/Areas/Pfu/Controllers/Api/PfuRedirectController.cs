using System;
using System.Configuration;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using AttributeRouting.Web.Http;
using System.Xml.Serialization;
using System.Text;
using BarsWeb.Areas.Pfu.Models.ApiModels;

namespace BarsWeb.Areas.Pfu.Controllers.Api
{
    public class PfuRedirectController : ApiController
    {
        private T DeserializeXml<T>(string buffer)
        {
            MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(buffer));
            XmlSerializer ser = new XmlSerializer(typeof(T));
            return (T)ser.Deserialize(ms);
        }
        private T DeserializeXml<T>(byte[] buffer)
        {
            MemoryStream ms = new MemoryStream(buffer);
            XmlSerializer ser = new XmlSerializer(typeof(T));
            return (T)ser.Deserialize(ms);
        }


        [HttpPost]
        [POST("/api/pfu/pfuredirect/sendrequest")]
        public HttpResponseMessage SendRequest()
        {
            try
            {
                var content = Request.Content.ReadAsByteArrayAsync().Result;
                //
                //if(ConfigurationManager.AppSettings["Pfu.debug"] == "true")
                //{
                //    var requestEnvelop = DeserializeXml<SimpleRequest>(content);
                //    string pfuTmpDir = Path.Combine(Path.GetTempPath(), "pfu_requets");
                //    if (!Directory.Exists(pfuTmpDir))
                //        Directory.CreateDirectory(pfuTmpDir);
                //    File.WriteAllBytes(string.Format("{0}//asc_{1}_{2}.xml", pfuTmpDir, requestEnvelop.Code, requestEnvelop.Num), content);
                //}
                //
                var apiUrl = ConfigurationManager.AppSettings["Pfu.link"];
                var pfuRequest = WebRequest.Create(apiUrl);
                pfuRequest.Method = "POST";
                pfuRequest.Proxy = new WebProxy();
                pfuRequest.ContentType = "application/xml";
                pfuRequest.ContentLength = content.Length;
                pfuRequest.Timeout = 60000;
                var requestStream = pfuRequest.GetRequestStream();
                requestStream.Write(content, 0, content.Length);
                requestStream.Close();

                var response = (HttpWebResponse) pfuRequest.GetResponse();
                var responseStream = response.GetResponseStream();
                var responseStr = new StreamReader(responseStream).ReadToEnd();

                var result = Request.CreateResponse(response.StatusCode);
                result.Content = new StringContent(responseStr);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        private HttpResponseMessage MakeRequest(PackageParameter parameters, byte[] content)
        {
            var uriBuilder = new UriBuilder(parameters.RedirectUrl);
            var query = HttpUtility.ParseQueryString(uriBuilder.Query);
            query["PackageId"] = parameters.PackageId;
            query["PackageName"] = parameters.PackageName;
            query["PackageMfo"] = parameters.PackageMfo;
            uriBuilder.Query = query.ToString();

            var pfuRequest = WebRequest.Create(uriBuilder.Uri) as HttpWebRequest;
            pfuRequest.Method = "POST";
            pfuRequest.Accept = "application/xml";
            pfuRequest.ContentType = "application/octet-stream";
            pfuRequest.ContentLength = content.Length;
            pfuRequest.Timeout = 60000;

            var requestStream = pfuRequest.GetRequestStream();
            requestStream.Write(content, 0, content.Length);
            requestStream.Close();

            var response = (HttpWebResponse) pfuRequest.GetResponse();
            var responseStream = response.GetResponseStream();

            var responseStr = new StreamReader(responseStream).ReadToEnd();

            var result = Request.CreateResponse(response.StatusCode);
            result.Content = new StringContent(responseStr);
            return result;
        }

        [HttpPost]
        [POST("/api/pfu/pfuredirect/checkpackage")]
        public HttpResponseMessage CheckPackage([FromUri] PackageParameter parameters)
        {
            var content = Request.Content.ReadAsByteArrayAsync().Result;
            return MakeRequest(parameters, content);
        }

        [HttpPost]
        [POST("/api/pfu/pfuredirect/receiptpackage")]
        public HttpResponseMessage ReceiptPackage([FromUri] PackageParameter parameters)
        {
            var content = Request.Content.ReadAsByteArrayAsync().Result;
            return MakeRequest(parameters, content);
        }

        [HttpPost]
        [POST("/api/pfu/pfuredirect/sendpackage")]
        public HttpResponseMessage SendPackage([FromUri] PackageParameter parameters)
        {
            var content = Request.Content.ReadAsByteArrayAsync().Result;
            return MakeRequest(parameters, content);
        }

        public class PackageParameter
        {
            public string RedirectUrl { get; set; }
            public string PackageId { get; set; }
            public string PackageName { get; set; }
            public string PackageMfo { get; set; }
        }
    }
}