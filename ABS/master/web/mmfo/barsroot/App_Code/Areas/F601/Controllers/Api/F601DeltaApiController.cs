using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Linq;
using System.Collections.Generic;
using System.Web.Http.ModelBinding;
using AttributeRouting.Web.Http;
using System.Web.Script.Serialization;
using Oracle.DataAccess.Client;


using BarsWeb.Areas.F601.Models;
using BarsWeb.Areas.F601.Infrastructure.DI;
using BarsWeb.Core.Models.Binders.Api;
using BarsWeb.Core.Models;

namespace BarsWeb.Areas.F601.Controllers.Api
{
    [AuthorizeApi]
    public class F601DeltaApiController : ApiController
    {
        readonly IF601DeltaRepository _repo;
        //'BarsWeb.Areas.F601.Controllers.Api.F601DeltaApiController
        public F601DeltaApiController(IF601DeltaRepository repo) { _repo = repo; }
        public F601DeltaApiController() {
            _repo = new F601DeltaRepository();
        }
        /// <summary>
        /// Отримати перелік звітів по 601 формі
        /// </summary>
        [HttpGet]
        [GET("api/F601/F601DeltaApi/GetNBUReports")]
        public HttpResponseMessage GetNBUReports()
        {
            try {
                var reports = _repo.GetReports();
                return Request.CreateResponse(HttpStatusCode.OK, reports);
            }
            catch (Exception ex) {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message); }
        }
        /// <summary>
        /// Отримати перелік сесій відправки звітів
        /// </summary>
        /// <param name="id">id звіту</param>
        [HttpGet]
        [GET("api/F601/F601DeltaApi/GetNBUSessionHistory")]
        public HttpResponseMessage GetNBUSessionHistory(Decimal? id)
        {
            try {
                var sessions = _repo.GetNBUSessionHistory(id);
                return Request.CreateResponse(HttpStatusCode.OK, sessions);
            }
            catch (Exception ex) {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
        /// <summary>
        /// Отримати дані вказаної і попередньої сесій для порівняння
        /// </summary>
        /// <param name="reportId">Звіт</param>
        /// <param name="sessionId">сесія</param>
        /// <param name="typeId">тип схеми</param>
        /// <param name="kf">код філії</param>
        [HttpGet]
        [GET("api/F601/F601DeltaApi/GetNBUSessionData")]
        public HttpResponseMessage GetNBUSessionData(Decimal? reportId, Decimal? sessionId, Decimal? typeId, string kf)
        {
            try
            {
                var data = _repo.GetNBUSessionData(reportId, sessionId, typeId, kf);
                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
    }

}