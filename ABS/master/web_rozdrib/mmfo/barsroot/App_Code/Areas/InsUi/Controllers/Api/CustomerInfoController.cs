using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.IO;
using System.Text;
using BarsWeb;
using BarsWeb.Areas.InsUi.Models.Transport;

using BarsWeb.Areas.InsUi.Infrastructure.DI.Abstract;
using System.Runtime.Serialization.Json;
using Newtonsoft.Json;

namespace Areas.InsUi.Controllers.Api
{
    [AuthorizeApi]
    public class CustomerInfoController : ApiController
    {
        private readonly IInsRepository _insRepo;
        public CustomerInfoController(IInsRepository insRepo)
        {
            _insRepo = insRepo;
        }
        // GET api/<controller>
        public HttpResponseMessage Get(string contractSalePointExternalId, string code, string DocumentTypes, DateTime? date, bool isLegal, string limit)
        {
            ClientSearchParams client = new ClientSearchParams();
            client.Inn = code;
            string result;
            
            HttpWebResponse response;
            var mfo = contractSalePointExternalId.Substring(1, 6);
            var par = _insRepo.GetParamMfo(mfo).FirstOrDefault();
            if (par.STATUS == "SUCCESS" && par.IS_ACTIVE == 1)
            {
                try
                {
                    MemoryStream stream = new MemoryStream();
                    byte[] bytePassword = Encoding.UTF8.GetBytes(par.USERNAME + ":" + par.HPASSWORD);
                    var password = Convert.ToBase64String(bytePassword);
                    var paramUrl = "?contractSalePointExternalId=" + contractSalePointExternalId + "&code=" + code + "&DocumentTypes=" + DocumentTypes + "&date=" + date
                        + "&isLegal=" + isLegal + "&limit=" + limit;
                    var serviceUrl = par.URLAPI + "inforemotebranch" + paramUrl;
                    var request = (HttpWebRequest)WebRequest.Create(serviceUrl);
                    request.Method = "GET";
                    request.ContentType = "application/json; charset=utf-8";
                    request.Headers.Add("Authorization", "Hashpassword " + password);
                    
                    response = (HttpWebResponse)request.GetResponse();
                    WebHeaderCollection header = response.Headers;
                    var encoding = ASCIIEncoding.UTF8;
                    using (var rdr = new StreamReader(response.GetResponseStream(), encoding))
                    {
                        result = rdr.ReadToEnd();
                    }
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
            return Request.CreateResponse(HttpStatusCode.OK, JsonConvert.DeserializeObject<List<CustomerInfoList>>(result));

            //foreach (var item in qClients)
            //{
            //    var count = 1;
            //    InsuredDocuments documents = new InsuredDocuments();
            //    if (!String.IsNullOrEmpty(item.ClientCard.Adr))
            //    {
            //        count++;
            //    }
            //    if (!String.IsNullOrEmpty(item.ClientCard.Fgadr))
            //    {
            //        count++;
            //    }
            //    documents.type = item.ClientCard.Passp == 1 ? "PASSPORT" : "RESIDENCE_PERMIT";
            //    documents.series = item.ClientCard.Ser;
            //    documents.number = item.ClientCard.Numdoc;
            //    documents.date = String.Format("{0:yyyy-MM-dd}", item.ClientCard.Pdate);
            //    documents.issuedBy = item.ClientCard.Organ;
            //    string nmk = "";
            //    string[] nmkArray = item.ClientCard.Nmk.Split(' ');
            //    for (var i = 0; i < nmkArray.Count(); i++)
            //    {
            //        var first = nmkArray[i].Substring(0, 1).ToUpper();
            //        var next = nmkArray[i].Substring(1).ToLower();
            //        if (i == nmkArray.Count() - 1)
            //        {
            //            nmk += first + next;
            //        }
            //        else
            //        {
            //            nmk += first + next + " ";
            //        }
            //    }

            //    for (var i = 0; i < count; i++)
            //    {
            //        CustomerInfoList customer = new CustomerInfoList();
            //        customer.legal = item.ClientCard.Codcagent == 5 ? false : item.ClientCard.Codcagent == 6 ? false : item.ClientCard.Codcagent == 3 ? true : item.ClientCard.Codcagent == 4 ? true : false;
            //        customer.code = item.ClientCard.Okpo;
            //        customer.name = nmk;//qClients.ClientCard.Nmk;
            //        switch (i)
            //        {
            //            case 0: customer.address = item.ClientCard.UrDomain + ", " + item.ClientCard.UrRegion + ", м. " + item.ClientCard.UrLocality + ", " + item.ClientCard.UrAddress; break;
            //            case 1:
            //                {
            //                    if (!String.IsNullOrEmpty(item.ClientCard.Adr))
            //                    {
            //                        customer.address = item.ClientCard.Adr;
            //                    }
            //                    else
            //                    {
            //                        customer.address = item.ClientCard.Fgobl + ", " + item.ClientCard.Fgdst + ", м. " + item.ClientCard.Fgtwn + ", " + item.ClientCard.Fgadr;
            //                    }
            //                    break;
            //                }
            //            case 2: customer.address = item.ClientCard.Fgobl + ", " + item.ClientCard.Fgdst + ", м. " + item.ClientCard.Fgtwn + ", " + item.ClientCard.Fgadr; break;
            //            default: break;
            //        }
            //        customer.birthDate = String.Format("{0:yyyy-MM-dd}", item.ClientCard.Bday);
            //        customer.document = documents;
            //        customers.Add(customer);
            //    }
            //}
            //return Request.CreateResponse(HttpStatusCode.OK, customers);
        }
    }
}
