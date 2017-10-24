using BarsWeb.Areas.DptAdm.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.DptAdm.Models;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using Kendo.Mvc.Extensions;
using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;

/// <summary>
/// Summary description for AdditionalFuncController
/// </summary>
/// 
namespace BarsWeb.Areas.DptAdm.Controllers.Api
{
    public class AdditionalFuncApiController : ApiController
    {
        private readonly IAdditionalFuncRepository _repository;

        public AdditionalFuncApiController(IAdditionalFuncRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public HttpResponseMessage GetVDPT([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request)
        {
            var fileList = _repository.GetVDPT<VDPT>();
            return Request.CreateResponse(HttpStatusCode.OK, fileList.ToDataSourceResult(request));
        }
        [HttpGet]
        public void SynchronizeDeposits()
        {
            _repository.SynchronizeDeposits();
        }
        [HttpGet]
        public void UpdatedDepositsFL()
        {
            _repository.UpdatedDepositsFL();
        }

        [HttpPost]
        public HttpResponseMessage TransferSrokdeposits([FromBody] dynamic request)
        {
            _repository.TransferSrokdeposits(request.SELECTED, request.OPERATION);

            return Request.CreateResponse(HttpStatusCode.OK);
        }

        [HttpGet]
        public HttpResponseMessage GetOperations([FromBody] dynamic request)
        {
            var fileList = _repository.GetOperations<OperationsType>();

            return Request.CreateResponse(HttpStatusCode.OK, fileList);
        }
    }
}