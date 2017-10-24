using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.SuperVisor.Infrastructure.DI.Abstract;

namespace BarsWeb.Areas.SuperVisor.Controllers.Api
{
    public class TabValController : ApiController
    {
        private readonly IBalanceRepository _repository;
        public TabValController(IBalanceRepository repository)
        {
            _repository = repository;
        }

        public HttpResponseMessage Get()
        {
            try
            {
                var data = _repository.TabValDictionary();
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