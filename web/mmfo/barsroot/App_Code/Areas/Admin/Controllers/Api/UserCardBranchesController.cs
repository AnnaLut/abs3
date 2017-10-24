using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using System.Web.Http.ModelBinding;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Admin.Controllers.Api
{
    //[AuthorizeApi]
    public class UserCardBranchesController : ApiController
    {
        private readonly IADMURepository _repo;
        public UserCardBranchesController(IADMURepository repo)
        {
            _repo = repo;
        }
        public HttpResponseMessage GetUserBranches(
           [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var data = _repo.BranchLookups(); 
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, data.ToDataSourceResult(request));
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }
    }
}