using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using AttributeRouting.Web.Http;
using BarsWeb.Areas.CorpLight.Infrastructure.Repository;
using BarsWeb.Areas.CorpLight.Models;
using BarsWeb.Core.Logger;

namespace BarsWeb.Areas.CorpLight.Controllers.Api
{
    /// <summary>
    /// Controller for managing accounts
    /// </summary>
    [AuthorizeApi]
    public class AccountsController : ApiController
    {
        private INbsAccTypesRepository _nbsAccTypesRepository;
        private readonly IDbLogger _logger;
        public AccountsController(INbsAccTypesRepository nbsAccTypesRepository, IDbLogger logger)
        {
            _nbsAccTypesRepository = nbsAccTypesRepository;
            _logger = logger;
        }


        /// <summary>
        /// Get all accountns
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        //[ODataQueryable]
        [GET("api/CorpLight/Accounts")]
        public List<NbsAccType> Get()
        {
            return _nbsAccTypesRepository.GetAll();
        }


        /// <summary>
        /// Create new account
        /// </summary>
        /// <param name="accType"></param>
        /// <returns></returns>
        [POST("api/CorpLight/Accounts")]
        public HttpResponseMessage Post(NbsAccType accType)
        {
            if (!ModelState.IsValid)
            {
                return CreateBadRequest();
            }
            _nbsAccTypesRepository.Add(accType);
            _logger.Info(string.Format("Додано новий рахунок до рахунків CorpLight NBS:{0}, TypeId:{1}", 
                accType.Nbs, accType.TypeId));
            return Request.CreateResponse(HttpStatusCode.OK, new { }); 
        }

        /// <summary>
        /// Update new account
        /// </summary>
        /// <param name="accType"></param>
        /// <returns></returns>
        [PUT("api/CorpLight/Accounts")]
        public HttpResponseMessage Put(NbsAccType accType)
        {
            if (!ModelState.IsValid)
            {
                return CreateBadRequest();
            }
            _nbsAccTypesRepository.Update(accType);

            _logger.Info(string.Format("Оновлено дані про рахунок CorpLight NBS:{0}, TypeId:{1}",
                accType.Nbs, accType.TypeId));
            return Request.CreateResponse(HttpStatusCode.OK, new { }); 
        }

        /// <summary>
        /// Delete new account
        /// </summary>
        /// <param name="accType"></param>
        /// <returns></returns>
        [DELETE("api/CorpLight/Accounts")]
        public HttpResponseMessage Delete(NbsAccType accType)
        {
            if (!ModelState.IsValid)
            {
                return CreateBadRequest();
            }

            _nbsAccTypesRepository.Delete(accType);
            _logger.Info(string.Format("Видалено рахунок з доступних в CorpLight NBS:{0}, TypeId:{1}",
                accType.Nbs, accType.TypeId));
            return Request.CreateResponse(HttpStatusCode.OK, new {}); 
        }

        /// <summary>
        /// Utility method for creating default bad request
        /// </summary>
        /// <returns></returns>
        private HttpResponseMessage CreateBadRequest()
        {
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
