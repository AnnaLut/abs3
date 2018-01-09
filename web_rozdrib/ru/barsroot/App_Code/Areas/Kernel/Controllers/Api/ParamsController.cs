using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Kernel.Controllers.Api
{
    /// <summary>
    /// Global and base parameters API
    /// </summary>
    [AuthorizeApi]
    public class ParamsController : ApiController
    {
        private readonly IParamsRepository _repository;

        public ParamsController(IParamsRepository repository)
        {
            _repository = repository;
        }
        /// <summary>
        /// Get all params
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        public DataSourceResult GetAll([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request)
        {
            return _repository.GetAllParams().ToDataSourceResult(request);
        }
        /// <summary>
        /// Get params with id
        /// </summary>
        /// <param name="id">params code</param>
        /// <returns></returns>
        public HttpResponseMessage Get(string id)
        {
            var param = _repository.GetParam(id);
            if (param == null)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest,
                    new { Message = "Not found" });
            }
            return Request.CreateResponse(HttpStatusCode.OK, param);
        }
    }
}