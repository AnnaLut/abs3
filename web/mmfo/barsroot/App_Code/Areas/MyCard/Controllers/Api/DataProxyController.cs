using System;
using System.Configuration;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web.Http;

namespace BarsWeb.Areas.MyCard.Controllers.Api
{
    public class DataProxyController : ApiController
    {
        [HttpPost]
        //[POST("api/dataproxy/postdata")]
        public HttpResponseMessage PostData([FromBody]string value)
        {
            HttpWebRequest serveRequest;
            HttpWebResponse serveResponse;
            string responceData = "";
            byte[] requestData;

            if (string.IsNullOrEmpty(value))
                return Request.CreateResponse(HttpStatusCode.NoContent);

            string url = ConfigurationManager.AppSettings["mycard.url"];
            serveRequest = (HttpWebRequest)WebRequest.Create(url);
            try
            {
                ServicePointManager.Expect100Continue = false;
                ServicePointManager.DefaultConnectionLimit = 1000;
                ServicePointManager.ServerCertificateValidationCallback += ((sender, certificate, chain, sslPolicyErrors) => { return true; });

                requestData = Encoding.UTF8.GetBytes(value);
                serveRequest.ContentType = "application/xml";
                serveRequest.Method = "POST";
                serveRequest.ContentLength = requestData.Length;

                serveRequest.GetRequestStream().Write(requestData, 0, requestData.Length);
                serveRequest.GetRequestStream().Close();

                serveResponse = (HttpWebResponse)serveRequest.GetResponse();
                if (serveResponse.StatusCode == HttpStatusCode.OK)
                {
                    Stream responseStream = serveResponse.GetResponseStream();
                    if (responseStream != null)
                    {
                        string responseStr = new StreamReader(responseStream).ReadToEnd();
                        byte[] data = Encoding.UTF8.GetBytes(responseStr);
                        return Request.CreateResponse(HttpStatusCode.OK, Convert.ToBase64String(data));
                    }
                }
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);

            }
            serveRequest.GetRequestStream().Close();
            return new HttpResponseMessage(HttpStatusCode.Continue);
        }
    }
}
