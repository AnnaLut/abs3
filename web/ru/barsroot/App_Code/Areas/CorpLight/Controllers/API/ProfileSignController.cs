using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using AttributeRouting.Web.Http;
using BarsWeb.Areas.CorpLight.Infrastructure.Repository;
using BarsWeb.Areas.CorpLight.Models;
using BarsWeb.Areas.CorpLight.Infrastructure.Services;
using System;
using BarsWeb.Core.Logger;

namespace BarsWeb.Areas.CorpLight.Controllers.Api
{
    /// <summary>
    /// Contorller for management user signs 
    /// </summary>
    [AuthorizeApi]
    public class ProfileSignController : ApiController
    {
        private IUserCertificateService _certeficateService;
        private IRelatedCustomersRepository _relCustRopository;
        private IProfileSignRepository _profileSignRepository;
        private readonly IDbLogger _logger;
        public ProfileSignController(
            IUserCertificateService certeficateService,
            IRelatedCustomersRepository relCustRopository,
            IProfileSignRepository profileSignRepository,
            IDbLogger logger)
        {
            _certeficateService = certeficateService;
            _relCustRopository = relCustRopository;
            _profileSignRepository = profileSignRepository;
            _logger = logger;
        }
        /// <summary>
        /// Get related customer
        /// </summary>
        /// <param name="custId"></param>
        /// <returns></returns>
        [HttpGet]
        [GET("api/CorpLight/ProfileSign/profile/{custId}")]
        public HttpResponseMessage GetProfile(decimal custId)
        {
            var relCust = _relCustRopository.GetById(custId);
            if (relCust == null)
            {
                return CreateBadRequest("Клієнта незнайдено");
            }
            var relCyustXml = _certeficateService.CreateUserProfileRequest(relCust);
            return Request.CreateResponse(HttpStatusCode.OK, relCyustXml);
        }

        [HttpGet]
        [GET("api/CorpLight/ProfileSign/signBuffer/{custId}")]
        public HttpResponseMessage GetSignBufer(decimal custId)
        {
            var result = _profileSignRepository.GetSignBuffer(custId);
            if (result != null)
            {
                return Request.CreateResponse(
                    HttpStatusCode.OK, 
                    new { id = result.VisaId + 1, buffer = result.Signature });
            }
            var relCust = _relCustRopository.GetById(custId);
            var buffer = _certeficateService.CreateUserProfileRequest(relCust);
            return Request.CreateResponse(HttpStatusCode.OK, new {id = 1, buffer});
        }
        /// <summary>
        /// Get all signatures for customer
        /// </summary>
        /// <param name="custId"></param>
        /// <returns></returns>
        [HttpGet]
        [GET("api/CorpLight/ProfileSign/{custId}/{visaId}")]
        public HttpResponseMessage GetAll(decimal custId)
        {
            var result = _profileSignRepository.GetAll(custId);
            return Request.CreateResponse(HttpStatusCode.OK, result);
        }
        [HttpGet]
        [GET("api/CorpLight/ProfileSign/{custId}/{visaId}")]
        public HttpResponseMessage Get(decimal custId, decimal visaId)
        {
            var result = _profileSignRepository.Get(custId, visaId);
            return Request.CreateResponse(HttpStatusCode.OK, result);
        } 

        /// <summary>
        /// Make visa
        /// </summary>
        /// <param name="profileSignature"></param>
        /// <returns></returns>
        [POST("api/CorpLight/ProfileSign/")]
        public HttpResponseMessage Post(ProfileSignature profileSignature)
        {
            profileSignature.VisaDate = DateTime.Now;
            profileSignature.UserId = User.Identity.Name;
            _profileSignRepository.Add(profileSignature);
            _logger.Info(String.Format(
                "Накладено підпис на профіль користувача CustomerId:{0}, VisaId:{1}, UserId:{2}", 
                profileSignature.CustomerId, profileSignature.VisaId, profileSignature.UserId));
            return Request.CreateResponse(HttpStatusCode.OK);
        }

        /// <summary>
        /// Remove visa from profile
        /// </summary>
        /// <param name="custId"></param>
        /// <param name="visaId"></param>
        /// <returns></returns>
        [DELETE("api/CorpLight/ProfileSign/{custId}/{visaId}")]
        public HttpResponseMessage Delete(decimal custId, decimal visaId)
        {
            _profileSignRepository.Delete(custId, visaId);

            _logger.Info(String.Format(
                "Видалено підпис з профіля користувача CustomerId:{0}, VisaId:{1}",
                custId, visaId));
            return Request.CreateResponse(HttpStatusCode.OK);
        }

        /// <summary>
        /// Utility method
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
