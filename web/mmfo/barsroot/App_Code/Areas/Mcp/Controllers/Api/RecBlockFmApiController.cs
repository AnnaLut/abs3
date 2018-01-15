using Areas.Mcp.Models;
using BarsWeb.Areas.Mcp.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Mcp.Infrastructure.DI.Implementation;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;

namespace BarsWeb.Areas.Mcp.Controllers.Api
{
    [AuthorizeApi]
    public class RecBlockFmApiController : ApiController
    {
        readonly IMcpRepository _repo;
        public RecBlockFmApiController(IMcpRepository repo) { _repo = repo; }

        [HttpGet]
        public HttpResponseMessage Search([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var sql = SqlCreator.SearchRecBlockFm();
                var data = _repo.SearchGlobal<RecBlockFm>(request, sql);
                var dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }        
    }
}
