using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Text;
using BarsWeb;

using BarsWeb.Areas.InsUi.Models.Transport;
using BarsWeb.Areas.InsUi.Infrastructure.DI.Abstract;
using System.Runtime.Serialization.Json;
using Newtonsoft.Json;

namespace Areas.InsUi.Controllers.Api
{
    [AuthorizeApi]
    public class CreateDealController : ApiController
    {
        private readonly IInsRepository _insRepo;
        public CreateDealController(IInsRepository insRepo)
        {
            _insRepo = insRepo;
        }
        // POST api/<controller>
        public HttpResponseMessage Post(CreateDealParams param)
        {
            string result;
            HttpWebResponse response;
            var mfo = param.salePoint.code.Substring(1, 6);
            var par = _insRepo.GetParamMfo(mfo).FirstOrDefault();
            if (par.STATUS == "SUCCESS" && par.IS_ACTIVE == 1)
            {
                try
                {
                    MemoryStream stream = new MemoryStream();
                    DataContractJsonSerializer ser = new DataContractJsonSerializer(typeof(CreateDealParams));
                    ser.WriteObject(stream, param);
                    stream.Position = 0;
                    StreamReader reader = new StreamReader(stream);
                    byte[] arrStream = Encoding.UTF8.GetBytes(reader.ReadToEnd());
                    byte[] bytePassword = Encoding.UTF8.GetBytes(par.USERNAME + ":" + par.HPASSWORD);
                    var password = Convert.ToBase64String(bytePassword);
                    stream.Close();

                    var serviceUrl = par.URLAPI + "createdealremotebranch";
                    var request = (HttpWebRequest)WebRequest.Create(serviceUrl);
                    request.Method = "POST";
                    request.ContentType = "application/json";
                    request.ContentLength = arrStream.Length;
                    request.Headers.Add("Authorization", "Hashpassword " + password);
                    Stream dataStream = request.GetRequestStream();
                    dataStream.Write(arrStream, 0, arrStream.Length);
                    dataStream.Close();
                    response = (HttpWebResponse)request.GetResponse();
                    WebHeaderCollection header = response.Headers;
                    var encoding = ASCIIEncoding.ASCII;
                    using (var rdr = new StreamReader(response.GetResponseStream(), encoding))
                    {
                        result = rdr.ReadToEnd();
                    }
                }
                catch(Exception e)
                {
                    return Request.CreateResponse(HttpStatusCode.Accepted, e.Message);
                }
            }
            else
            {
                return Request.CreateResponse(HttpStatusCode.NotFound);
            }
            return Request.CreateResponse(HttpStatusCode.OK, JsonConvert.DeserializeObject<CreateDealResponse>(result));
        }
    }
}
