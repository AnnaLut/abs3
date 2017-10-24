using System;
using System.Collections.Generic;
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
    public class RoleTabstripController : ApiController
    {
        private readonly IRolesRepository _repo;
        public RoleTabstripController(IRolesRepository repo)
        {
            _repo = repo;
        }

        public HttpResponseMessage GetRoleTabsData([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                IQueryable<V_ROLE_RESOURCE_TYPE_LOOKUP> data = _repo.GetResourceTypeLookups();
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