using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using AttributeRouting.Web.Http;
using System;
using System.IO;
using System.Security.Cryptography.X509Certificates;
using System.Net.Security;
using System.Web;
using System.Net.Http.Headers;
using BarsWeb.Areas.Kernel.Models;

using BarsWeb.Areas.CDO.Common.Repository;
using BarsWeb.Areas.CDO.Common.Services;
using BarsWeb.Areas.CDO.Corp2.Repository;
using BarsWeb.Areas.CDO.Common.Models;
using BarsWeb.Areas.CDO.Common.Models.Acsk;

namespace BarsWeb.Areas.CDO.Corp2.Controllers.Api
{
    /// <summary>
    /// Cotroller for customer sertificate management
    /// </summary>
    [AuthorizeApi]
    public class C2UserCertificateController : ApiController
    {
        private IUserCertificateService _certeficateService;
        private ICorp2RelatedCustomersRepository _corp2RelatedCustomersRepository;
        private ICorp2ProfileSignRepository _corp2ProfileSignRepository;
        private INokkService _nokkService;
        private IC2AcskRepository _acskRepository;
        private IParametersRepository _parametersRepository;
        public C2UserCertificateController(
            IUserCertificateService certeficateService,
            ICorp2RelatedCustomersRepository corp2RelatedCustomers,
            ICorp2ProfileSignRepository corp2ProfileSignRepository,
            INokkService nokkService,
            IParametersRepository parametersRepository,
            IC2AcskRepository acskRepository)
        {
            _certeficateService = certeficateService;
            _corp2RelatedCustomersRepository = corp2RelatedCustomers;
            _corp2ProfileSignRepository = corp2ProfileSignRepository;
            _nokkService = nokkService;
            _acskRepository = acskRepository;
            _parametersRepository = parametersRepository;

            SslValidation();

            var baseApiUrl = _parametersRepository.Get("Acsk.BaseServiceUrl");
            if (baseApiUrl == null)
            {
                throw new Exception("Parameter Acsk.BaseServiceUrl is null in MBM_PARAMETERS");
            }
            _nokkService.BaseServiceUrl = baseApiUrl.Value;
        }

        private void SslValidation()
        {
            ServicePointManager.ServerCertificateValidationCallback =
                delegate (object s, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors)
                {
                    return true;
                };
        }

        [HttpPost]
        [POST("api/cdo/corp2/UserCertificate/getSertificatesStatus/{relCustId}/{userId}")]
        public HttpResponseMessage GetSertificatesStatusCorp2(decimal relCustId, decimal userId, ServiceRequest data)
        {
            try
            {
                var result = _nokkService.GetRequests(data.SignedData);

                if (result.Code != "0")
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest, result);
                }
                var resultData = result.Data as List<AcskCertificate>;
                if (resultData != null && resultData.Count != 0)
                {
                    foreach (var crt in resultData)
                    {
                        crt.RelCustId = relCustId;
                        _acskRepository.UpdateCertificateInfoCorp2(relCustId, crt);
                    }
                }

                //var lastKeyId = resultData.Where(i => i.RequestState == 5).OrderBy(e => e.RequesTime).LastOrDefault();
                //if (lastKeyId != null)
                //{
                //    var serialNumber = Convert.ToInt32(lastKeyId.Id).ToString("X8");
                //    try
                //    {
                //        _corp2RelatedCustomersRepository.Corp2Services.UserManager.SetUserACSKKeySn(_corp2RelatedCustomersRepository.Corp2Services.GetSecretKey(), userId, serialNumber);
                //    }
                //    catch (Exception ex)
                //    {
                //        throw new Exception("Виникла помилка під час запросу до сервісу Corp2. Зверніться до адміністратора." + Environment.NewLine + ex.Message);
                //    }
                //    _corp2RelatedCustomersRepository.UpdateRelatedCustomerKey(relCustId, serialNumber);
                //}

                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }

        [HttpPost]
        [POST("api/cdo/corp2/UserCertificate/sendToAcsk/{relCustId}/{custId}")]
        public HttpResponseMessage SendToAcskCorp2(decimal relCustId, decimal custId)
        {
            try
            {
                if (!ValidateProfileSign(relCustId))
                {
                    return CreateBadRequest("Невірний підпис на профілі користувача");
                }
                var signNumber = 1;
                var parameter = _parametersRepository.Get("Acsk.VisaCount");
                if (parameter != null)
                {
                    signNumber = Convert.ToInt32(parameter.Value);
                }

                var signedData = _corp2ProfileSignRepository.Get(relCustId, signNumber);
                if (signedData == null)
                {
                    return CreateBadRequest(string.Format("Підпис № {0} не знайдено", signNumber));
                }
                var result = _nokkService.SendProfile(signedData.Signature);

                if (result.Code == "0")
                {
                    var userInfo = _certeficateService.ParseSendProfileInfo(result.Data as string);
                    if (userInfo != null)
                    {
                        BarsSql sql = SqlCreator.SearchUserById(relCustId);
                        var user = _corp2RelatedCustomersRepository.ExecuteStoreQuery<RelatedCustomer>(sql).FirstOrDefault();
                        decimal userId;
                        if (decimal.TryParse(user.UserId, out userId))
                        {
                            if(user.AcskRegistrationId == null)
                            {
                                _acskRepository.MapCorp2RelatedCustomerToAcskUser(relCustId, userInfo); //insert into CORP2_ACSK_REGISTRATION
                            }
                            var serialNumber = Convert.ToInt32(userInfo.RegistrationId).ToString("X8");
                            try
                            {
                                _corp2RelatedCustomersRepository.Corp2Services.UserManager.SetUserACSKKeySn(_corp2RelatedCustomersRepository.Corp2Services.GetSecretKey(), userId, serialNumber);
                            }
                            catch (Exception ex)
                            {
                                throw new Exception("Виникла помилка під час запросу до сервісу Corp2. Зверніться до адміністратора." + Environment.NewLine + ex.Message);
                            }
                            if (string.IsNullOrEmpty(user.AcskSertificateSn))
                            {
                                _corp2RelatedCustomersRepository.UpdateRelatedCustomerKey(relCustId, serialNumber);
                            }
                        }
                        //else throw new Exception("");
                        //_corp2RelatedCustomersRepository.VisaMapedRelatedCustomerToUser(relCustId, custId);
                        _corp2RelatedCustomersRepository.SetAcskActual(relCustId, 1); //update CORP2_REL_CUSTOMERS set ACSK_ACTUAL
                        result.Data = userInfo;
                        return Request.CreateResponse(HttpStatusCode.OK, result);
                    }

                }
                return Request.CreateResponse(HttpStatusCode.BadRequest, result);

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }

        [HttpPost]
        [POST("api/cdo/corp2/UserCertificate/getRules")]
        public HttpResponseMessage GetRules(ServiceRequest data)
        {
            try
            {
                var result = _nokkService.GetRules(data.SignedData);
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }
        /// <summary>
        /// Get subject
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        [HttpPost]
        [POST("api/cdo/corp2/UserCertificate/getSubject")]
        public HttpResponseMessage GetSubject(ServiceRequest data)
        {
            try
            {
                var result = _nokkService.Subject(data.SignedData);
                if (result.Code != "0")
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest, result);
                }
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }

        /// <summary>
        /// Enroll request
        /// </summary>
        /// <param name="relCustId"></param>
        /// <param name="data"></param>
        /// <returns></returns>
        [HttpPost]
        [POST("api/cdo/corp2/UserCertificate/enrollRequest/{relCustId}")]
        public HttpResponseMessage EnrollRequest(decimal relCustId, ServiceRequest data)
        {
            try
            {
                var result = _nokkService.Enroll(data.SignedData);

                if (result.Code != "0")
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest, result);
                }

                if (result.Data != null)
                {
                    _acskRepository.SaveEnrollRequest(relCustId, result.Data as AcskEnrollResponse);
                }
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }

        /// <summary>
        /// Return user sertificate file 
        /// </summary>
        /// <param name="relCustId"></param>
        /// <param name="custId"></param>
        /// <returns></returns>
        [HttpGet]
        [GET("api/cdo/corp2/UserCertificate/print/{relCustId}/{custId}")]
        public HttpResponseMessage Print(decimal relCustId, decimal custId)
        {
            try
            {
                HttpResponseMessage result = new HttpResponseMessage(HttpStatusCode.OK);

                var patch = HttpContext.Current.Server.MapPath(HttpContext.Current.Request.ApplicationPath);
                if (!patch.EndsWith("/"))
                {
                    patch += "/";
                }
                patch += "areas/cdo/Corp2/reports/cl_acsk_requestCorp2.frx";

                var param = new FrxParameters
                {
                    new FrxParameter("id", TypeCode.String, relCustId)
                };
                var doc = new FrxDoc(patch, param, null);
                using (var str = new MemoryStream())
                {
                    doc.ExportToMemoryStream(FrxExportTypes.Pdf, str);

                    var biteArray = str.ToArray();
                    result.Content = new ByteArrayContent(biteArray);
                    result.Content.Headers.ContentType = new MediaTypeHeaderValue("application/pdf");
                    result.Content.Headers.ContentDisposition =
                        new System.Net.Http.Headers.ContentDispositionHeaderValue("attachment")
                        {
                            FileName = "anketa.pdf"
                        };
                    return result;
                }
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }

        private bool ValidateProfileSign(decimal custId)
        {
            return true;
        }

        /// <summary>
        /// Change sertificate state 
        /// </summary>
        /// <param name="relCustId"></param>
        /// <param name="data"></param>
        /// <returns></returns>
        [HttpPost]
        [POST("api/cdo/corp2/UserCertificate/changeState/{relCustId}")]
        public HttpResponseMessage ChangeState(decimal relCustId, ServiceRequest data)
        {
            try
            {
                var result = _nokkService.ChangeState(data.SignedData);

                if (result.Code != "0")
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest, result);
                }
                var resultData = result.Data as List<AcskCertificate>;
                if (resultData != null && resultData.Count != 0)
                {
                    foreach (var crt in resultData)
                    {
                        crt.RelCustId = relCustId;
                        _acskRepository.UpdateCertificateInfoCorp2(relCustId, crt);
                    }
                }

                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }

        /// <summary>
        /// Utility method for creating bad request
        /// </summary>
        /// <param name="message"></param>
        /// <returns></returns>
        private HttpResponseMessage CreateBadRequest(string message = "")
        {
            if (!string.IsNullOrEmpty(message))
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, message);
            }
            var modelState = ModelState.Values.FirstOrDefault();
            if (modelState != null)
            {
                var firstOrDefault = modelState.Errors.FirstOrDefault();
                if (firstOrDefault != null)
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest, firstOrDefault.ErrorMessage);
                }
            }
            return Request.CreateResponse(HttpStatusCode.BadRequest, "Помилка обробки даних");
        }
    }
}
