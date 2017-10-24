using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.FinView.Infrastructure.DI.Abstract;

namespace BarsWeb.Areas.FinView.Controllers.Api
{
    [AuthorizeApi]
    public class CurrentRateController : ApiController
    {
        private readonly IFinanceRepository _finRepo;
        public CurrentRateController(IFinanceRepository finRepo)
        {
            _finRepo = finRepo;
        }

        [HttpGet]
        public HttpResponseMessage Get(string date)
        {
            try
            {
                var rates = _finRepo.CurrentExchangeRate(date);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, rates);
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new {Msg = ex.Message});
            }
        }
    }
}