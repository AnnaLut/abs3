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
    /// Branches available to the user
    /// </summary>
    [AuthorizeApi]
    public class BranchesController : ApiController
    {
        private readonly IBranchesRepository _repository;

        public BranchesController(IBranchesRepository repository)
        {
            _repository = repository;
        }
        /// <summary>
        /// Gets list of branches available to the user
        /// </summary>
        /// <param name="request">Query parameters for the selection of (type: DataSourceRequest)</param>
        /// <returns>List of branches</returns>
        public DataSourceResult GetAll([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request)
        {
            return _repository.GetAllBranches().ToDataSourceResult(request);
        }

        /// <summary>
        /// Obtaining an identifier of the branch of
        /// </summary>
        /// <param name="id">Branch</param>
        /// <returns>Branch parameters</returns>
        public HttpResponseMessage Get(string id)
        {
            var branch = _repository.GetBranch(id);
            if (branch == null)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest,
                    new { Message = "Бранч не знайдено" });
            }
            return Request.CreateResponse(HttpStatusCode.OK, branch);
        }
    }
}