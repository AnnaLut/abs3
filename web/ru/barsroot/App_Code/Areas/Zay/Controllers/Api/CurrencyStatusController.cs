using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using AttributeRouting.Web.Http;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Zay.Models;

namespace BarsWeb.Areas.Zay.Controllers.Api
{
    [AuthorizeApi]
    public class CurrencyStatusController : ApiController
    {
        private readonly ICurrencySightRepository _repository;
        public CurrencyStatusController(ICurrencySightRepository repository)
        {
            _repository = repository;
        }

        [HttpPost]
        [POST("api/zay/currencystatus")]
        public HttpResponseMessage Post(ZayCheckDataModel item)
        {
            try
            {
                _repository.ZayCheckData(item);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK);
                return response;
            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.OK, exception.Message);
            }
        }
    }
}