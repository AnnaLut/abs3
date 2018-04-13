using System;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web.Http;
using AttributeRouting.Web.Http;
using BarsWeb.Areas.Reporting.Infrastructure.Repository.DI.Abstract;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using System.Web.Http.ModelBinding;

namespace BarsWeb.Areas.Reporting.Controllers.Api
{
    /// <summary>
    /// Summary description for Advertising
    /// </summary>
    [AuthorizeApi]
    public class NbuController : ApiController
    {
        private readonly INbuRepository _repository;
        public NbuController(INbuRepository repository)
        {
            _repository = repository;
        }

        public DataSourceResult Get(
            [ModelBinder(typeof (WebApiDataSourceRequestModelBinder))] DataSourceRequest request,
            string id, string date)
        {
            var data = _repository.GetReportData(id, date).Tables[0].AsEnumerable().FirstOrDefault();
            if (data != null)
            {
                return data.Table.ToDataSourceResult(request);
            }
            return new DataSourceResult(); 
        }
        [GET("api/reporting/nbu/file")]
        public HttpResponseMessage GetFile(string id, string date)
        {
            string filename = "CashLimitsDistribution-" + date + ".txt";

            var textFile = _repository.GetReportFile(id, DateTime.Now);

            HttpResponseMessage result = Request.CreateResponse(HttpStatusCode.OK);
            result.Content = new StringContent(textFile, Encoding.UTF8, "text/plain");
            result.Content.Headers.ContentDisposition = new System.Net.Http.Headers.ContentDispositionHeaderValue("attachment")
            {
                FileName = filename
            };

            return result;
        }
        [HttpPut]
        public HttpResponseMessage Put(string id, string date)
        {
            var task = _repository.StartCreateReport(id, date);
            return Request.CreateResponse(HttpStatusCode.OK,new {TaskId = task});
        }
    }
}