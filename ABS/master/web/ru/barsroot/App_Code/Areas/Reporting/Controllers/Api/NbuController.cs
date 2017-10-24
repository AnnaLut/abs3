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
    //[AuthorizeApi]
    [Authorize]
    [CheckAccessPage]
    public class NbuController : ApiController
    {
        private readonly INbuRepository _repository;
        public NbuController(INbuRepository repository)
        {
            _repository = repository;
        }
        [GET("api/reporting/nbu")]
        public DataSourceResult Get(
            [ModelBinder(typeof (WebApiDataSourceRequestModelBinder))] DataSourceRequest request,
            string id, string date, string isCon)
        {
                var data = _repository.GetReportData(id, date, isCon).Tables[0].AsEnumerable().FirstOrDefault();
                if (data != null)
                {
                    return data.Table.ToDataSourceResult(request);
                }

            return new DataSourceResult(); 
        }
        [GET("api/reporting/nbu/file")]
        public HttpResponseMessage GetFile(string code, string date)
        {
            var textFile = _repository.GetReportFile(code, date);
            var fName = textFile.Substring(0, 12);
            var fBody = textFile.Substring(13);

            HttpResponseMessage result = Request.CreateResponse(HttpStatusCode.OK);
            result.Content = new StringContent(fBody, Encoding.UTF8, "text/plain");
            result.Content.Headers.ContentDisposition = new System.Net.Http.Headers.ContentDispositionHeaderValue("attachment")
            {
                FileName = fName
            };

            return result;
        }
        [HttpPut]
        public HttpResponseMessage Put(string code, string date)
        {
            var task = _repository.StartCreateReport(code, date);
            return Request.CreateResponse(HttpStatusCode.OK,new {TaskId = task});
        }
        [PUT("api/reporting/nbu/rowupdate")]
        public HttpResponseMessage PutRowUpdate(object newRow)
        {
            throw new NotImplementedException();
        }
    }
}