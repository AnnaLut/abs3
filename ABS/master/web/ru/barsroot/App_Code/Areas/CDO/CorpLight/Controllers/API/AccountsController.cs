using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using AttributeRouting.Web.Http;
using BarsWeb.Core.Logger;

using BarsWeb.Areas.CDO.Common.Models;
using BarsWeb.Areas.CDO.Common.Repository;
using System;

namespace BarsWeb.Areas.CDO.CorpLight.Controllers.Api
{
    /// <summary>
    /// Controller for managing accounts
    /// </summary>
    [AuthorizeApi]
    public class AccountsController : ApiController
    {
        private INbsAccTypesRepository _nbsAccTypesRepository;
        //private readonly IDbLogger _logger;
        public AccountsController(INbsAccTypesRepository nbsAccTypesRepository/*, IDbLogger logger*/)
        {
            _nbsAccTypesRepository = nbsAccTypesRepository;
            //_logger = logger;
        }


        /// <summary>
        /// Get all accountns
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        //[ODataQueryable]
        [GET("api/cdo/corplight/accounts")]
        public List<NbsAccType> Get()
        {
            try
            {
                return _nbsAccTypesRepository.GetAll();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }


        /// <summary>
        /// Create new account
        /// </summary>
        /// <param name="accType"></param>
        /// <returns></returns>
        [POST("api/cdo/corplight/accounts")]
        public HttpResponseMessage Post(NbsAccType accType)
        {
            if (!ModelState.IsValid)
            {
                return CreateBadRequest();
            }
            try
            {
                _nbsAccTypesRepository.Add(accType);
                //_logger.Info(string.Format("Додано новий рахунок до рахунків CorpLight NBS:{0}, TypeId:{1}", 
                //    accType.Nbs, accType.TypeId));
                return Request.CreateResponse(HttpStatusCode.OK, new { }); 
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }

        /// <summary>
        /// Update new account
        /// </summary>
        /// <param name="accType"></param>
        /// <returns></returns>
        [PUT("api/cdo/corplight/accounts")]
        public HttpResponseMessage Put(NbsAccType accType)
        {
            if (!ModelState.IsValid)
            {
                return CreateBadRequest();
            }
            try
            {
                _nbsAccTypesRepository.Update(accType);

                //_logger.Info(string.Format("Оновлено дані про рахунок CorpLight NBS:{0}, TypeId:{1}",
                //    accType.Nbs, accType.TypeId));
                return Request.CreateResponse(HttpStatusCode.OK, new { }); 
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }

        /// <summary>
        /// Delete new account
        /// </summary>
        /// <param name="accType"></param>
        /// <returns></returns>
        [DELETE("api/cdo/corplight/accounts")]
        public HttpResponseMessage Delete(NbsAccType accType)
        {
            if (!ModelState.IsValid)
            {
                return CreateBadRequest();
            }
            try
            {
                _nbsAccTypesRepository.Delete(accType);
                //_logger.Info(string.Format("Видалено рахунок з доступних в CorpLight NBS:{0}, TypeId:{1}",
                //    accType.Nbs, accType.TypeId));
                return Request.CreateResponse(HttpStatusCode.OK, new {}); 
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
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
