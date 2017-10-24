using AttributeRouting.Web.Http;
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

namespace BarsWeb.Areas.DptAdm.Controllers.Api
{
    public class EditFinesDFOApiController : ApiController
    {
        private readonly IEditFinesDFORepository _repository;

        public EditFinesDFOApiController(IEditFinesDFORepository repository)
        {
            _repository = repository;
        }
        
        [HttpGet]
        public HttpResponseMessage GetDataForDrop(string ddt)
        {
            var fileList = _repository.TypesList<DropDown>(ddt);
            return Request.CreateResponse(HttpStatusCode.OK, fileList);
        }

        [HttpGet]
        public HttpResponseMessage GetDataForGrid([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request, 
           string modcode)
        {
            var fileList = _repository.GetData<DPTmod>(modcode);
            return Request.CreateResponse(HttpStatusCode.OK, fileList.ToDataSourceResult(request));
        }
        [HttpGet]
        public HttpResponseMessage GetFineData([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request, int fineid)
        {
            var fileList = _repository.GetFineData<EditingGrid>(fineid);
            return Request.CreateResponse(HttpStatusCode.OK, fileList.ToDataSourceResult(request));
        }
        [HttpGet]
        public HttpResponseMessage IfCheckBoxs([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request, int fineid)
        {
            var fileList = _repository.IfCheckBoxs<CheckBox>(fineid);
            return Request.CreateResponse(HttpStatusCode.OK, fileList.ToDataSourceResult(request));
        }
        [HttpGet]
        public HttpResponseMessage GetData(string modcode)
        {
            var fileList = _repository.GetData<DPTmod>(modcode);
            return Request.CreateResponse(HttpStatusCode.OK, fileList);
        }
        [HttpPost]
        public HttpResponseMessage InsertRow([FromBody] dynamic request)
        {
            _repository.InsertRow(request.grid);
            return Request.CreateResponse(HttpStatusCode.OK);
        }
        [HttpPost]
        public HttpResponseMessage InsertFine([FromBody] dynamic request)
        {
            _repository.InsertFine(request.grid, request.ID);
            return Request.CreateResponse(HttpStatusCode.OK);
        }

        [HttpPost]
        public HttpResponseMessage UpdateFine([FromBody] dynamic request)
        {
            _repository.UpdateFine(request.grid, request.ID);
            return Request.CreateResponse(HttpStatusCode.OK);
        }
        [HttpPost]
        public HttpResponseMessage DeleteRow([FromBody] dynamic request)
        {
            String message = _repository.DeleteRow(request.rows);
            return Request.CreateResponse(HttpStatusCode.OK, message);
        }
        [HttpPost]
        public HttpResponseMessage DeleteFineSetting([FromBody] dynamic request)
        {
            String message = _repository.DeleteFineSetting(request.rows, request.ID);
            return Request.CreateResponse(HttpStatusCode.OK, message);
        }
        public HttpResponseMessage UpdateRow([FromBody] dynamic request)
        {
            String message = _repository.UpdateRow(request.rows);
            return Request.CreateResponse(HttpStatusCode.OK, message);
        }
    }
}