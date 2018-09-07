using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using AttributeRouting.Web.Http;
using System;
using BarsWeb.Core.Logger;
using BarsWeb.Areas.Kernel.Models;

using BarsWeb.Areas.CDO.Common.Models;
using BarsWeb.Areas.CDO.Common.Repository;
using BarsWeb.Areas.CDO.Common.Services;
using BarsWeb.Areas.CDO.Corp2.Models;
using BarsWeb.Areas.CDO.Corp2.Services;
using BarsWeb.Areas.CDO.Corp2.Repository;

namespace BarsWeb.Areas.CDO.Corp2.Controllers.Api
{
    /// <summary>
    /// Contorller for management user signs 
    /// </summary>
    [AuthorizeApi]
    public class C2ProfileSignController : ApiController
    {
        private IUserCertificateService _certeficateService;
        private ICorp2RelatedCustomersRepository _corp2RelatedCustomersRepository;
        private ICorp2ProfileSignRepository _corp2ProfileSignRepository;
        private readonly IDbLogger _logger;
        public C2ProfileSignController(
            IUserCertificateService certeficateService,
            ICorp2RelatedCustomersRepository corp2RelatedCustomers,
            ICorp2ProfileSignRepository corp2ProfileSignRepository
            ,IDbLogger logger)
        {
            _certeficateService = certeficateService;
            _corp2RelatedCustomersRepository = corp2RelatedCustomers;
            _corp2ProfileSignRepository = corp2ProfileSignRepository;
            _logger = logger;
        }
        

        [HttpGet]
        [GET("api/cdo/corp2/ProfileSign/signBuffer/{userId}")]
        public HttpResponseMessage GetSignBuferCorp2(decimal userId)
        {
            try
            {
                var result = _corp2ProfileSignRepository.GetSignBuffer(userId);
                if (result != null)
                {
                    return Request.CreateResponse(
                        HttpStatusCode.OK,
                        new { id = result.VisaId + 1, buffer = result.Signature });
                }
                BarsSql sql = SqlCreator.SearchUserById(userId);
                var user = _corp2RelatedCustomersRepository.ExecuteStoreQuery<RelatedCustomer>(sql).FirstOrDefault();
                var buffer = _certeficateService.CreateUserProfileRequest(user);
                return Request.CreateResponse(HttpStatusCode.OK, new { id = 1, buffer });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }

        /// <summary>
        /// Make visa
        /// </summary>
        /// <param name="profileSignature"></param>
        /// <returns></returns>
        [POST("api/cdo/corp2/ProfileSign/")]
        public HttpResponseMessage PostCorp2(ProfileSignatureCorp2 profileSignature)
        {
            profileSignature.VisaDate = DateTime.Now;
            try
            {
                _corp2ProfileSignRepository.Add(profileSignature);
                _logger.Info(String.Format(
                    "Накладено підпис на профіль користувача Corp2 UserId:{0}, VisaId:{1}",
                    profileSignature.UserId, profileSignature.VisaId));
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }
    }
}
