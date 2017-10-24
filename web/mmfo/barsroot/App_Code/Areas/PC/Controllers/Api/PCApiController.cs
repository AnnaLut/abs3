using AttributeRouting.Web.Http;
using Bars.Classes;
using BarsWeb.Areas.PC.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.PC.Models;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using Kendo.Mvc.Extensions;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Runtime.InteropServices;
using System.Web.Http;
using System.Web.Http.ModelBinding;

namespace BarsWeb.Areas.PC.Controllers.Api
{
    public class PCApiController : ApiController
    {
        private readonly IPCRepository _repository;

        public PCApiController(IPCRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public HttpResponseMessage GetOperations()
        {
            try
            {
                List<Operations> list = new List<Operations>();
                list = _repository.GetOperations();
                return Request.CreateResponse(HttpStatusCode.OK, list);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage RunSelectedProcedure(int id)
        {
            try
            {
                string message = _repository.RunSelectedProcedure(id);
                return Request.CreateResponse(HttpStatusCode.OK, message);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetGridData([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request, string date_from, string date_to)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            var trans = connection.BeginTransaction();
            try
            {
                List<Grid> list = _repository.GetGridData(date_from, date_to);
                return Request.CreateResponse(HttpStatusCode.OK, list.ToDataSourceResult(request));
            }
            catch (Exception ex)
            {
                trans.Rollback();
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }
    }
}