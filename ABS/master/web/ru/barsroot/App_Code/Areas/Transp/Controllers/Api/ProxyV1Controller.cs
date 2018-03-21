using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;

namespace BarsWeb.Areas.Transp
{
    public class ProxyV1Controller : ApiController
    {
        [HttpPost]
        public HttpResponseMessage Direct()
        {
            string ipsdd = HttpContext.Current.Request.UserHostAddress;
            string respStr = String.Empty;
            string r_url = String.Empty;

            KeyValuePair<string, string>[] get_params = Request.GetQueryNameValuePairs().ToArray();

            KeyValuePair<string, IEnumerable<string>>[] header_params = Request.Headers.ToArray();

            try
            {
                r_url = Request.Headers.GetValues("MyProxyURI").First();
            }
            catch
            {
                throw new Exception("Не передано URI для перенаправлення!");
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

            for (int i = 0; i <= header_params.Length - 1; i++)
            {
                if (header_params[i].Key.Length > "MyReqHead".Length)
                {
                    if (header_params[i].Key.Substring(0, "MyReqHead".Length) == "MyReqHead")
                    {
                        trRequest.Headers.Add(header_params[i].Key.Substring("MyReqHead".Length), header_params[i].Value.First());
                    }
                }

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
                byte[] req_str = Request.Content.ReadAsByteArrayAsync().Result;

                trRequest.ContentLength = req_str.Length;

                using (Stream requestStream = trRequest.GetRequestStream())
                {
                    requestStream.Write(req_str, 0, req_str.Length);
                }
            }

            //try
            //{
                HttpWebResponse response = (HttpWebResponse)trRequest.GetResponse();

                using (Stream responseStream = response.GetResponseStream())
                {
                    using (StreamReader strrd = new StreamReader(responseStream))
                    {
                        respStr = strrd.ReadToEnd();
                    }
                }

                HttpResponseMessage result = Request.CreateResponse(response.StatusCode);

                foreach (string resp_head_key in response.Headers.Keys)
                {
                    result.Headers.Add("MyRespHead" + resp_head_key, response.Headers.GetValues(resp_head_key));
                }
                result.Content = new StringContent(respStr);
                return result;
            //}
            //catch (Exception ex)
            //{
            //    HttpResponseMessage result = Request.CreateResponse(HttpStatusCode.InternalServerError);
            //    result.Content = new StringContent(ex.Message);
            //    return result;
            //}

        }
    }
}






    /*public class SendController : ApiController
    {
        // GET api/<controller>
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET api/<controller>/5
        public string Get(int id)
        {
            return "value";
        }

        // POST api/<controller>
        public void Post([FromBody]string value)
        {
        }

        // PUT api/<controller>/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE api/<controller>/5
        public void Delete(int id)
        {
        }
    }
}*/
