using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Way.Infrastructure.DI.Abstract;
using System.Web.Http.ModelBinding;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Way.Controllers.Api
{
    [AuthorizeApi]
    public class WayDocController : ApiController
    {
        private readonly IWayRepository _repository;
        public WayDocController(IWayRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public HttpResponseMessage Get(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request,
            string dateFrom, string dateTo)
        {
            try
            {
                var files = _repository.Files(dateFrom, dateTo).ToList();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = files.ToDataSourceResult(request), Message = "Ok" });
                return response;
            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = 0, Message = exception.Message });
            }
        }
        [HttpPut]
        public HttpResponseMessage Put(string id)
        {
            try
            {
                _repository.RepayFile(Decimal.Parse(id));
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = 1, Message = "Оновлення успішне" });
                return response;
            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = 0, Message = exception.Message });
            }
        }
        [HttpDelete]
        public HttpResponseMessage Delete(decimal id)
        {
            try
            {
                _repository.DeleteFile(id);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = 1, Message = "Файл успішно видалено" });
                return response;
            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = 0, Message = exception.Message });
            }
        }
    }
}