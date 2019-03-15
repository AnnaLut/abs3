using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.NbuIntegration.Infrastructure.DI.Abstract;
using BarsWeb.Areas.NbuIntegration.Infrastructure.DI.Implementation;
using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using Areas.NbuIntegration.Models;
using System.Globalization;
using System.Collections;
using System.Collections.Generic;

namespace BarsWeb.Areas.NbuIntegration.Controllers.Api
{
    [AuthorizeApi]
    public class SagoController : ApiController
    {
        readonly ISagoRepository _repo;
        INbuServiceRepository _nbuRepo;
        public SagoController(ISagoRepository repo, INbuServiceRepository nbuRepo) { _repo = repo; _nbuRepo = nbuRepo; }

        private CultureInfo _ci;
        public CultureInfo Ci
        {
            get
            {
                if (_ci == null)
                {
                    _ci = CultureInfo.CreateSpecificCulture("en-GB");
                    _ci.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";
                    _ci.DateTimeFormat.DateSeparator = ".";
                }
                return _ci;
            }
        }

        [HttpGet]
        public HttpResponseMessage SearchReceivedDocs([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string from, string to, decimal? requestId)
        {
            try
            {
                BarsSql sql = SqlCreator.SearchDocuments(from, to, requestId);
                IEnumerable<OperationRowExtended> data = _repo.SearchGlobal<OperationRowExtended>(request, sql);

                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage SearchImports([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string from, string to)
        {
            try
            {
                BarsSql sql = SqlCreator.SearchImports(from, to);
                IEnumerable<VRequestsRow> data = _repo.SearchGlobal<VRequestsRow>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage ImportStatusesDs()
        {
            try
            {
                BarsSql sql = SqlCreator.GetRequestStatuses();
                IEnumerable data = _repo.SearchGlobal<StatusModel>(null, sql);

                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage DocumentsStatusesDs()
        {
            try
            {
                BarsSql sql = SqlCreator.GetDocumentsStatuses();
                IEnumerable data = _repo.SearchGlobal<StatusModel>(null, sql);

                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
    }
}
