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
using BarsWeb.Areas.CDO.Common.Models;
using BarsWeb.Areas.CDO.Common.Models.Acsk;
using BarsWeb.Areas.CDO.CorpLight.Repository;
using BarsWeb.Areas.CDO.CorpLight.Services;

namespace BarsWeb.Areas.CDO.CorpLight.Controllers.Api
{
    /// <summary>
    /// Cotroller for customer sertificate management
    /// </summary>
    [AuthorizeApi]
    public class CLUserCertificateController : ApiController
    {
        private IUserCertificateService _certeficateService;
        private ICLRelatedCustomersRepository _relCustRopository;
        private IProfileSignRepository _profileSignRepository;
        private INokkService _nokkService;
        private ICLAcskRepository _acskRepository;
        private IParametersRepository _parametersRepository;
        public CLUserCertificateController(
            IUserCertificateService certeficateService,
            ICLRelatedCustomersRepository relCustRopository,
            IProfileSignRepository profileSignRepository,
            INokkService nokkService,
            IParametersRepository parametersRepository,
            ICLAcskRepository acskRepository)
        {
            _certeficateService = certeficateService;
            _relCustRopository = relCustRopository;
            _profileSignRepository = profileSignRepository;
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

        /// <summary>
        /// Get user profile converted
        /// </summary>
        /// <param name="custId"></param>
        /// <returns></returns>
        [HttpGet]
        [GET("api/cdo/corplight/UserCertificate/profile")]
        public HttpResponseMessage GetProfile(decimal custId)
        {
            try
            {
                var relCust = _relCustRopository.GetById(custId);
                if (relCust == null)
                {
                    return CreateBadRequest("Клієнта незнайдено");
                }
                var relCyustXml = _certeficateService.CreateUserProfileRequest(relCust);
                return Request.CreateResponse(HttpStatusCode.OK, relCyustXml);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }


        [HttpPost]
        [POST("api/cdo/corplight/UserCertificate/getRules")]
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
        [POST("api/cdo/corplight/UserCertificate/getSubject")]
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
        [POST("api/cdo/corplight/UserCertificate/enrollRequest/{relCustId}")]
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
        /// Get sertificate status
        /// </summary>
        /// <param name="relCustId"></param>
        /// <param name="data"></param>
        /// <returns></returns>
        [HttpPost]
        [POST("api/cdo/corplight/UserCertificate/getSertificatesStatus/{relCustId}")]
        public HttpResponseMessage GetSertificatesStatus(decimal relCustId, ServiceRequest data)
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
                        _acskRepository.UpdateCertificateInfo(relCustId, crt);
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
        /// Change sertificate state 
        /// </summary>
        /// <param name="relCustId"></param>
        /// <param name="data"></param>
        /// <returns></returns>
        [HttpPost]
        [POST("api/cdo/corplight/UserCertificate/changeState/{relCustId}")]
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
                        _acskRepository.UpdateCertificateInfo(relCustId, crt);
                    }
                }

                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }

        [HttpPost]
        [POST("api/cdo/corplight/UserCertificate/sendToAcsk/{relCustId}/{custId}")]
        public HttpResponseMessage SendToAcsk(decimal relCustId, decimal custId)
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

                var signedData = _profileSignRepository.Get(relCustId, signNumber);
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
                        var user = _relCustRopository.GetById(relCustId);
                        if (user.AcskRegistrationId == null)
                        {
                            _acskRepository.MapRelatedCustomerToAcskUser(relCustId, userInfo);
                        }
                        _relCustRopository.VisaMapedRelatedCustomerToUser(relCustId, custId);
                        _relCustRopository.SetAcskActual(relCustId, 1);
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

        /// <summary>
        /// Return user sertificate file 
        /// </summary>
        /// <param name="relCustId"></param>
        /// <param name="custId"></param>
        /// <returns></returns>
        [HttpGet]
        [GET("api/cdo/corplight/UserCertificate/print/{relCustId}/{custId}")]
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
                patch += "areas/cdo/CorpLight/reports/cl_acsk_request.frx"; 
            
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
