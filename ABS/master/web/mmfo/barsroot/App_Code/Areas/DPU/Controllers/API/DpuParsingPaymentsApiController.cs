using BarsWeb.Areas.DPU.Infrastructure.DI.Abstract;
using BarsWeb.Areas.DPU.Models;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using Kendo.Mvc.Extensions;
using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;

namespace BarsWeb.Areas.DPU.Controllers.Api
{
    public class DpuParsingPaymentsApiController : ApiController
    {
        private readonly IDpuParsingPaymentsRepository _repository;

        public DpuParsingPaymentsApiController(IDpuParsingPaymentsRepository repository)
        {
            _repository = repository;
        }


        [HttpGet]
        public HttpResponseMessage GetDataForGrid([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request, decimal id)
        {
            var fileList = _repository.GetDataForGrid<BalanceCounts>(id);
            return Request.CreateResponse(HttpStatusCode.OK,fileList.ToDataSourceResult(request));
        }
        [HttpGet]
        public HttpResponseMessage GetDataForDocGrid([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request)
        {
            var fileList = _repository.GetDataForDocGrid<BalanceCounts>();
            return Request.CreateResponse(HttpStatusCode.OK, fileList.ToDataSourceResult(request));
        }

        [HttpPost]
        public void BeforeStart()
        {
            _repository.BeforeStart();
        }

        [HttpPost]
        public HttpResponseMessage PayBack([FromBody] dynamic request)
        {
            _repository.PayBack(request.row);
            return Request.CreateResponse(HttpStatusCode.OK);
        }

        [HttpPost]
        public HttpResponseMessage DeleteRow([FromBody] dynamic request)
        {
            _repository.DeleteRow(request.ACC, request.REF1);
            return Request.CreateResponse(HttpStatusCode.OK);
        }

        [HttpPost]
        public HttpResponseMessage CreditedAmount([FromBody] dynamic request)
        {
            _repository.CreditedAmount(request.row, request.acc);
            return Request.CreateResponse(HttpStatusCode.OK);
        }
    }
}