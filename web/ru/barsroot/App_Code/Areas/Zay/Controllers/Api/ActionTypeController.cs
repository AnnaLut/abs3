using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;

namespace BarsWeb.Areas.Zay.Controllers.Api
{
    [AuthorizeApi]
    public class ActionTypeController : ApiController
    {
        private readonly ICurrencySightRepository _repository;
        public ActionTypeController(ICurrencySightRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public HttpResponseMessage Get(decimal id)
        {
            try
            {
                var dk = _repository.IsBlocked(id);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = dk, Message = "Ok" });
                return response;
            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = "", Message = exception.Message });
            }
        }
    }
}