using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.Subvention.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Subvention.Infrastructure.DI.Implementation;
using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using System.Globalization;
using System.Collections.Generic;
using BarsWeb.Areas.Subvention.Models;
using BarsWeb.Core.Logger;
using System.IO;

namespace BarsWeb.Areas.Subvention.Controllers.Api
{
    [AuthorizeApi]
    public class SubMonitoringController : ApiController
    {
        const string MODULE_NAME = "SubMonitoring";
        readonly ISubMonitoringRepository _repo;
        readonly IDbLogger _logger;
        public SubMonitoringController(ISubMonitoringRepository repo, IDbLogger logger)
        {
            _repo = repo;
            _logger = logger;
        }

        private HttpResponseMessage Error(Exception ex)
        {
            _logger.Error(ex.Message + Environment.NewLine + ex.StackTrace, MODULE_NAME);
            return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
        }

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
        public HttpResponseMessage SearchPackages([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string from, string to, int? status)
        {
            try
            {
                BarsSql sql = SqlCreator.GetPackages(from, to, status);
                IEnumerable<Package> data = _repo.SearchGlobal<Package>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex) { return Error(ex); }
        }

        [HttpGet]
        public HttpResponseMessage SearchDocuments([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string from, string to, decimal? packageId)
        {
            try
            {
                BarsSql sql = SqlCreator.GetDocuments(from, to, packageId);
                IEnumerable<Document> data = _repo.SearchGlobal<Document>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex) { return Error(ex); }
        }

        [HttpGet]
        public HttpResponseMessage RunJob()
        {
            try
            {
                byte res = _repo.RunJob();
                return Request.CreateResponse(HttpStatusCode.OK, res);
            }
            catch (Exception ex) { return Error(ex); }
        }

        [HttpGet]
        public HttpResponseMessage GetAccountsForReport()
        {
            try
            {
                BarsSql sql = SqlCreator.GetAccountsForReport();
                IEnumerable<AccForReport> data = _repo.SearchGlobal<AccForReport>(null, sql);
                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex) { return Error(ex); }
        }

        [HttpGet]
        public HttpResponseMessage GetReport(string dateFrom, string dateTo, string accNumber)
        {
            try
            {
                byte[] content = _repo.GetReportContent(dateFrom, dateTo, accNumber);

                HttpResponseMessage res = new HttpResponseMessage(HttpStatusCode.OK);
                res.Content = new ByteArrayContent(content);
                res.Content.Headers.ContentDisposition = new System.Net.Http.Headers.ContentDispositionHeaderValue("attachment");
                res.Content.Headers.ContentDisposition.FileName = string.Format("report3720_{0}_{1}_{2}.pdf", dateFrom, dateTo, accNumber);
                res.Content.Headers.ContentType = new System.Net.Http.Headers.MediaTypeHeaderValue("application/pdf");
                return res;
            }
            catch (Exception ex) { return Error(ex); }
        }
    }
}
