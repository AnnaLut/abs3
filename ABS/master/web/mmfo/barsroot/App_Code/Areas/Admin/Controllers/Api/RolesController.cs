using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using System.Web.Http.ModelBinding;
using Areas.Admin.Models;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Admin.Controllers.Api
{
    //[AuthorizeApi]
    public class RolesController : ApiController
    {
        private readonly IRolesRepository _repo;
        public RolesController(IRolesRepository repo)
        {
            _repo = repo;
        }

        public HttpResponseMessage GetRolesData([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string parameters)
        {
            try
            {
                var data = _repo.GetRoles(parameters).ToList();
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