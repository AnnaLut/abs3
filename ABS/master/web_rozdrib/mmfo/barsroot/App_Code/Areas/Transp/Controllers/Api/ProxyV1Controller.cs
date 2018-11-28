using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web;
using System.Web.Http;
using System.Xml;

namespace BarsWeb.Areas.Transp
{
    public class ProxyV1Controller : ApiController
    {
        [HttpPost]
        public HttpResponseMessage Post()
        {
            string ipsdd = HttpContext.Current.Request.UserHostAddress;
            string respStr = String.Empty;
            string r_url = String.Empty;
            string dataCompression = String.Empty;
            int? dataToBase64 = 0;
            int? dataXml2Json = 0;

            byte[] req_str = Request.Content.ReadAsByteArrayAsync().Result;

            KeyValuePair<string, string>[] get_params = Request.GetQueryNameValuePairs().ToArray();

            KeyValuePair<string, IEnumerable<string>>[] header_params = Request.Headers.ToArray();

            try
            {
                r_url = Request.Headers.GetValues("MyProxyURI").First();
            }
            catch
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Не передано URI для перенаправлення!");
            }

            UriBuilder uriBuilder = new UriBuilder(r_url);
            NameValueCollection query = HttpUtility.ParseQueryString(uriBuilder.Query);

            foreach (KeyValuePair<string, string> get_param in get_params)
            {
                query[get_param.Key] = get_param.Value;
            }
            uriBuilder.Query = query.ToString();

            HttpWebRequest trRequest = WebRequest.Create(uriBuilder.Uri) as HttpWebRequest;

                    trRequest.Method = "POST";

                    trRequest.Timeout = 60000;

                    trRequest.ContentType = "application/xml";

            for (int i = 0; i < header_params.Length; i++)
            {

                if (header_params[i].Key.StartsWith("MyReqHead"))
                    trRequest.Headers.Add(header_params[i].Key.Substring("MyReqHead".Length), header_params[i].Value.First());

                if (header_params[i].Key == "MyProxyActCompress")
                    dataCompression = header_params[i].Value.First();


                if (header_params[i].Key == "MyProxyActBase64")
                    dataToBase64 = Int32.Parse(header_params[i].Value.First());


                if (header_params[i].Key == "MyProxyActXml2Json")
                    dataXml2Json = Int32.Parse(header_params[i].Value.First());


                if (header_params[i].Key == "MyProxyMethod")
                    trRequest.Method = header_params[i].Value.First();


                if (header_params[i].Key == "MyProxyAccCT")
                    trRequest.Accept = header_params[i].Value.First();


                if (header_params[i].Key == "MyProxyCT")
                    trRequest.ContentType = header_params[i].Value.First();


                if (header_params[i].Key == "MyProxyTimeout")
                    trRequest.Timeout = Int32.Parse(header_params[i].Value.First());

            }
            if (trRequest.Method != "GET")
            {

                if (dataXml2Json != 0)
                {
                    req_str = Encoding.UTF8.GetBytes(XmlToJson(Encoding.UTF8.GetString(req_str)));
                    if (dataCompression == "GZIP")
                        req_str = Compress(req_str);
                    if (dataToBase64 != 0)
                        req_str = Encoding.UTF8.GetBytes(Convert.ToBase64String(req_str));
                }

                trRequest.ContentLength = req_str.Length;

                using (Stream requestStream = trRequest.GetRequestStream())
                {
                    requestStream.Write(req_str, 0, req_str.Length);
                }
            }

            try
            {
                HttpWebResponse response = (HttpWebResponse)trRequest.GetResponse();

                using (Stream responseStream = response.GetResponseStream())
                using (StreamReader strrd = new StreamReader(responseStream))
                {
                    respStr = strrd.ReadToEnd();
                }

                HttpResponseMessage result = Request.CreateResponse(response.StatusCode);
                
                    foreach (string resp_head_key in response.Headers.Keys)
                    {
                        result.Headers.Add("MyRespHead" + resp_head_key, response.Headers.GetValues(resp_head_key));
                    }
                    result.Content = new StringContent(respStr, Encoding.UTF8, "text/plain");
                    return result;
                
            }
            catch(WebException ex)
            {
                using (Stream err_resp = ex.Response.GetResponseStream())
                using (StreamReader strrd = new StreamReader(err_resp))
                {
                    respStr = strrd.ReadToEnd();
                }

                HttpResponseMessage resp = new HttpResponseMessage(HttpStatusCode.InternalServerError);
                resp.Content = new StringContent(respStr, Encoding.UTF8, "text/plain");
                return resp;

            }
            catch (Exception ex)
            {
                HttpResponseMessage resp = new HttpResponseMessage(HttpStatusCode.InternalServerError);
                resp.Content = new StringContent(ex.Message, Encoding.UTF8, "text/plain");
                return resp;

            }

        }

        private byte[] Compress(byte[] data)
        {
            using (MemoryStream compressedStream = new MemoryStream())
            using (GZipStream zipStream = new GZipStream(compressedStream, CompressionMode.Compress))
            {
                zipStream.Write(data, 0, data.Length);
                zipStream.Close();
                return compressedStream.ToArray();
            }
            
        }

        private string XmlToJson(string xml_str)
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.LoadXml(xml_str);
            return JsonConvert.SerializeXmlNode(xmlDoc, Newtonsoft.Json.Formatting.None, true);

        }

    }
}