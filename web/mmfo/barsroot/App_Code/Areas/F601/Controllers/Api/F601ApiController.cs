using System;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using Oracle.DataAccess.Client;
using Bars.Classes;
using BarsWeb.Areas.F601.Infrastructure.DI.Abstract;
using AttributeRouting.Web.Http;
using BarsWeb.Areas.F601.Models;
using System.Collections.Generic;
using BarsWeb.Areas.F601.Helpers;
using Newtonsoft.Json;
using BarsWeb;

namespace Areas.F601.Controllers.Api
{
    [AuthorizeApi]
    public class F601ApiController : ApiController
    {
        private readonly IF601Repository _repository;

        public F601ApiController(IF601Repository repository)
        {
            _repository = repository;
        }

        public HttpResponseMessage GetObjectsForSign(long number, string operId)
        {
            try
            {
                var payloadsList = _repository.GetSignDataList(number);
                /*
                Protected protectedObj = new Protected()
                {
                    Alg = "none",
                    Typ = "JOSE+JSON",
                    Cty = "application/json",
                    Kid = operId,
                    //DateOper = DateTime.Now.ToString("yyyy-MM-ddTHH:mm:ss"),
					DateOper = "2017-12-18T15:00:00",
                    AppId = "CRK"
                };
				*/
                Protected protectedObj = new Protected()
                {
                    alg = "none",
                    typ = "JOSE+JSON",
                    cty = "application/json",
                    kid = operId,
                    dateOper = DateTime.Now.ToString("yyyy-MM-ddTHH:mm:ss"),
                    appId = "CRK"
                };

                string protectedString = String.Empty;

                List<ObjectToSign> listToSign = new List<ObjectToSign>();
                for (int i = 0; i < payloadsList.Count; i++)
                {
                    //protectedObj.DateOper = DateTime.Now.ToString("yyyy-MM-ddTHH:mm:ss");
                    //protectedString = LowerCaseJsonSerializer.SerializeObject(protectedObj);
                    protectedString = JsonConvert.SerializeObject(protectedObj);

                    listToSign.Add(new ObjectToSign()
                    {
                        SessionId = payloadsList[i].SessionId,
                        PayloadInBase64Url = CodingHelper.EncodeStringToBase64UrlString(payloadsList[i].PayloadToSign),
                        ProtectedInBase64Url = CodingHelper.EncodeStringToBase64UrlString(protectedString)
                    });
                }

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = listToSign });
            }
            catch (Exception e)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, e.StackTrace);
            }
        }

        [HttpPost]
        public HttpResponseMessage PostSignedObject([FromBody] dynamic request)
        {
            try
            {
                string payload = request.payloadInbase64Url;
                string protectedObj = request.protectedInbase64Url;
                string inputSign = request.hexSign;
                string signature = FormEncodedSign(inputSign);
                int sessionId = request.sessionId;

                NBUSessionObject signedObject = new NBUSessionObject()
                {
                    Payload = payload,
                    Protected = protectedObj,
                    Signature = signature
                };

                string stringSignedObject = LowerCaseJsonSerializer.SerializeObject(signedObject);
                _repository.PutSignedObject(sessionId, stringSignedObject);

                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception e)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, e.StackTrace);
            }
        }

        private string FormEncodedSign(string hexSign)
        {
            byte[] byteResSign = CodingHelper.ConvertHexStringToByteArray(hexSign);
            string base64StringSign = Convert.ToBase64String(byteResSign);
            string base64UrlEncodedSign = CodingHelper.EncodeStringToBase64UrlString(base64StringSign);
            return base64UrlEncodedSign;
        }

        public HttpResponseMessage GetKeyId()
        {
            try
            {
                var data = _repository.GetPrivateKeyId();
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data });
            }
            catch (Exception e)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, e.StackTrace);
            }
        }
    }
}