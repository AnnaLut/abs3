using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Zay.Models;

namespace BarsWeb.Areas.Zay.Controllers.Api
{
    [AuthorizeApi]
    public class CheckDilerConversionRateController : ApiController
    {
        private readonly ICurrencyDictionary _dictionary; 
        public CheckDilerConversionRateController(ICurrencyDictionary dictionary)
        {
            _dictionary = dictionary;
        }

        [HttpPost]
        public HttpResponseMessage Post(RequestConversionModel item)
        {
            try
            {
                var value = _dictionary.DilerConversionRate(item.id, item.kvF, item.kvS);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, new { kurs = value });
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new {Msg = ex.Message});
            }
        }
    }
    public class RequestConversionModel
    {
        public decimal id { get; set; }
        public decimal kvF { get; set; }
        public decimal kvS { get; set; }
    }
}