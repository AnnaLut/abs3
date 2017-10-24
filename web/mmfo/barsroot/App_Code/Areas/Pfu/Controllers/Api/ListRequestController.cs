using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using AttributeRouting.Web.Http;
using BarsWeb.Areas.Pfu.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Pfu.Models.ApiModels;
using System.Globalization;

namespace BarsWeb.Areas.Pfu.Controllers.Api
{
    /// <summary>
    /// ListRequestController - виклик процедури create_envelope_list_request
    /// </summary>
    public class ListRequestController : ApiController
    {
        private readonly IPfuToolsRepository _repository;
        public ListRequestController(IPfuToolsRepository repository)
        {
            _repository = repository;
        }

        [HttpPost]
        [POST("/api/pfu/listrequest/callenvelopelistrequest")]
        public HttpResponseMessage CallEnvelopeListRequest(Dates item)
        {
            try
            {
                DateTime start = DateTime.ParseExact(item.start_date, "dd.MM.yyyy", CultureInfo.InvariantCulture);
                DateTime end = DateTime.ParseExact(item.end_date, "dd.MM.yyyy", CultureInfo.InvariantCulture);

                _repository.CreateEnvelopeRequest(start, end, item.pfu_type);
                var response = "get_convert_lists is started";
                return Request.CreateResponse(HttpStatusCode.OK, response);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + " v1.0.1");
            }
        }

        [HttpGet]
        [GET("/api/pfu/listrequest/PensionerTypes")]
        public HttpResponseMessage PensionerTypes(int arm)
        {
            try
            {
                var data = _repository.GetPensionerType();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, new { Data = data });
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }
    }
}