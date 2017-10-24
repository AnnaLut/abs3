using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using AttributeRouting.Web.Http;
using BarsWeb.Areas.SuperVisor.Infrastructure.DI.Abstract;
using BarsWeb.Areas.SuperVisor.Models;
using BarsWeb.Controllers;
using Telerik.Web.UI;

namespace BarsWeb.Areas.SuperVisor.Controllers.Api
{
    [AuthorizeApi]
    public class ReviewDataController : ApiController
    {
        private readonly IBalanceRepository _repository;
        public ReviewDataController(IBalanceRepository repository)
        {
            _repository = repository;
        }

        [HttpPost]
        [POST("api/supervisor/reviewdata")]
        public HttpResponseMessage Post(FilterParams model)
        {
            try
            {
                _repository.SeedBalanceView(model.bDate, model.kv, model.nbs);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, new ProcResult() { Status = 1, Msg = "Процедура населення виконана успішно!" });
                return response;
            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new ProcResult() {Status = 0, Msg = exception.Message});
            }
        }
    }

    public class ProcResult
    {
        public int Status { get; set; }
        public string Msg { get; set; }
    }
}