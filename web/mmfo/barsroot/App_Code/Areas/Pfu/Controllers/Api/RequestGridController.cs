using System;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Pfu.Infrastructure.Repository.DI.Abstract;
using Kendo.Mvc.UI;
using System.Web.Http.ModelBinding;
using System.Net;

namespace BarsWeb.Areas.Pfu.Controllers.Api
{
    /// <summary>
    /// RequestGrid data
    /// </summary>
    public class RequestGridController : ApiController
    {
        private readonly IGridRepository _repo;
        public RequestGridController(IGridRepository repo)
        {
            _repo = repo;
        }

        [HttpGet]
        public HttpResponseMessage RequestData(
            [ModelBinder(typeof (WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var data = _repo.RequestsData(request);
                var dataCount = _repo.CountRequests(request);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new {Data = data, Total = dataCount});
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.NoContent,
                    ex.Message);
                return response;
            }
        }

        [HttpGet]
        public HttpResponseMessage RequestLog(decimal id, 
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var data = _repo.SessionInfo(id, request);
                var dataCount = _repo.CountSession(id, request);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, 
                    new {Data = data, Total = dataCount });
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.NoContent,
                    ex.Message);
                return response;
            }
        }
    }

}