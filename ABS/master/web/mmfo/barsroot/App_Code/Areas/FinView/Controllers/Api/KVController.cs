using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.FinView.Infrastructure.DI.Abstract;

namespace BarsWeb.Areas.FinView.Controllers.Api
{
    public class KVController : ApiController
    {
        private readonly IFinanceRepository _finRepo;
        public KVController(IFinanceRepository finRepo)
        {
            _finRepo = finRepo;
        }
        public HttpResponseMessage Get()
        {
            try
            {
                var data = _finRepo.TabValDictionary();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, data);
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.NoContent, ex.Message);
            }
        }
    }
}