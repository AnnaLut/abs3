
using System.Collections.Generic;

using System.Linq;
using BarsWeb.Infrastructure.Helpers;
using BarsWeb.Areas.Pfu.Models.Grids;
using BarsWeb.Areas.Cash.Infrastructure;
using System.Web.Http;
using BarsWeb.Areas.Pfu.Infrastructure.Repository.DI.Abstract;
using System.Net.Http;
using System.Web.Http.ModelBinding;
using BarsWeb.Core.Models.Binders.Api;
using BarsWeb.Core.Models;
using System.Net;
using Kendo.Mvc.Extensions;
using System;

namespace BarsWeb.Areas.Pfu.Controllers.Api
{
    /// <summary>
    /// FilesGrid Data
    /// </summary>
    public class ErrorRowsController : ApiController
    {
        private readonly IGridRepository _repo;
        public ErrorRowsController(IGridRepository repo)
        {
            _repo = repo;
        }

        [HttpGet]
        public HttpResponseMessage GetErrorRows([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string MFO, string ID, string STATE)
        {
            try
            {
                //if(MFO == "")
                //    mfo = Convert.ToDecimal(MFO);
                //if (ID == "")
                //   id = Convert.ToDecimal(ID);
                var data = _repo.GetErrorRows(MFO, ID, STATE);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, data.ToDataSourceResult(request));
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.BadRequest,
                    ex.Message);
                return response;
            }
        }
        [HttpGet]
        public HttpResponseMessage GetMFO()
        {
            try
            {
                var data = _repo.GetMFO();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, new { Data = data });
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.BadRequest,
                    ex.Message);
                return response;
            }
        }
        [HttpGet]
        public HttpResponseMessage GetStates()
        {
            try
            {
                var data = _repo.GetStates();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, new { Data = data });
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.BadRequest,
                    ex.Message);
                return response;
            }
        }
        [HttpPost]
        public HttpResponseMessage MarkToPayment([FromBody] dynamic id)
        {
            try
            {
                var ID = Convert.ToDecimal(id["id"]);
                _repo.MarkToPayment(ID);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK);
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.BadRequest,
                    ex.Message);
                return response;
            }
        }

    }
}