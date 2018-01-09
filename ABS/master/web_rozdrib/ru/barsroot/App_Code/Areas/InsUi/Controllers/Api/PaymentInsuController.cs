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
using Areas.InsUi.Models;
//using BarsWeb.Areas.Ins.Infrastructure.DI.Implementation;
using BarsWeb.Areas.InsUi.Infrastructure.DI.Abstract;
using System.Runtime.Serialization.Json;
using Newtonsoft.Json;

namespace Areas.InsUi.Controllers.Api
{
    [AuthorizeApi]
    public class PaymentInsuController : ApiController
    {
        private readonly IInsRepository _insRepo;
        public PaymentInsuController(IInsRepository insRepo)
        {
            _insRepo = insRepo;
        }
        public HttpResponseMessage Post(PaymentsParams param)
        {
            HttpWebResponse response;
            string result;
            var mfo = "000000000";//param.contractSalePointExternalId.Substring(1, 6);
            var par = _insRepo.GetParamMfo(mfo).FirstOrDefault();
            if (par.STATUS == "SUCCESS" && par.IS_ACTIVE == 1)
            {
                try
                {
                    MemoryStream stream = new MemoryStream();
                    DataContractJsonSerializer ser = new DataContractJsonSerializer(typeof(PaymentsParams));
                    ser.WriteObject(stream, param);
                    stream.Position = 0;
                    StreamReader reader = new StreamReader(stream);
                    byte[] arrStream = Encoding.UTF8.GetBytes(reader.ReadToEnd());
                    byte[] bytePassword = Encoding.UTF8.GetBytes(par.USERNAME + ":" + par.HPASSWORD);
                    var password = Convert.ToBase64String(bytePassword);
                    stream.Close();

                    var serviceUrl = par.URLAPI + "paymentremotebranch";
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
                    using(var rdr = new StreamReader(response.GetResponseStream(),encoding))
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

            return Request.CreateResponse(HttpStatusCode.OK, JsonConvert.DeserializeObject<PaymentsResponse>(result));
        }

        public HttpResponseMessage Delete(int docNumber, String account, int ammount, String contractSalePointExternalId)
        {
            var mfo = contractSalePointExternalId.Substring(1, 6);
            var par = _insRepo.GetParamMfo(mfo).FirstOrDefault();
            if (par.STATUS == "SUCCESS" && par.IS_ACTIVE == 1)
            {
                try
                {
                    byte[] bytePassword = Encoding.UTF8.GetBytes(par.USERNAME + ":" + par.HPASSWORD);
                    var password = Convert.ToBase64String(bytePassword);
                    var param = "?docNumber=" + docNumber + "&account=" + account + "&ammount=" + ammount;
                    var serviceUrl = par.URLAPI + "paymentremotebranch";
                    var request = (HttpWebRequest)WebRequest.Create(serviceUrl + param);
                    request.Method = "DELETE";
                    request.Headers.Add("Authorization", "Hashpassword " + password);
                    HttpWebResponse response = (HttpWebResponse)request.GetResponse();
                }
                catch (Exception e)
                {
                    return Request.CreateResponse(HttpStatusCode.Accepted, e.Message);
                }
            }
            else
            {
                return Request.CreateResponse(HttpStatusCode.NotFound);
            }

            return Request.CreateResponse(HttpStatusCode.OK);
        }

    }
}
