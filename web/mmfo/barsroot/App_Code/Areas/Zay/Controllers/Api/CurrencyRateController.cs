using System;
using System.Net;
using System.Net.Http;
using System.Security.Permissions;
using System.Web.Http;
using AttributeRouting.Web.Http;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;

namespace BarsWeb.Areas.Zay.Controllers.Api
{
    [AuthorizeApi]
    public class CurrencyRateController : ApiController
    {
        private readonly ICurrencySightRepository _repository;
        public CurrencyRateController(ICurrencySightRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public HttpResponseMessage Get(decimal kv)
        {
            try
            {
                var data = _repository.CurrencyRate(kv);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, data.CurrencyBuy);
                return response;
            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.OK, exception.Message);
            }
        }

        [HttpPost]
        [POST("api/zay/currencyrate")]
        public HttpResponseMessage Post(Kurs kurs)
        {
            try
            {
                _repository.CurrencyRateUpdate(kurs.id, kurs.kurs);
                var code = 1;
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, code);
                return response;
            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.OK, exception.Message);
            }
        }
    }
    public class Kurs
    {
        public decimal id { get; set; }
        public decimal kurs { get; set; }
    }
}