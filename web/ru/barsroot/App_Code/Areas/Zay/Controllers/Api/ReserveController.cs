using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;

namespace BarsWeb.Areas.Zay.Controllers.Api
{
    [AuthorizeApi]
    public class ReserveController : ApiController
    {
        private readonly ICurrencySightRepository _repository;
        public ReserveController(ICurrencySightRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public HttpResponseMessage Get(decimal id, decimal type)
        {
            try
            {
                var data = _repository.ReserveCheckout(type, id);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = data, Message = "" });
                return response;
            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = 0, Message = exception.Message });
            }
        }
    }
}