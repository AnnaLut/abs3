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
    public class RoleResourceAccessController : ApiController
    {
        private readonly IRolesRepository _repo;
        public RoleResourceAccessController(IRolesRepository repo)
        {
            _repo = repo;
        }
        public HttpResponseMessage GetRoleResAccessMode(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request,
            string id)
        {
            var typeId = Decimal.Parse(id);
            try
            {
                IQueryable<V_ROLE_RESOURCE_ACCESS_MODE> data = _repo.GetResourceAccessModes();
                var dataList = data.Where(x => x.ID ==  typeId).ToList();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, dataList.ToDataSourceResult(request));
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }
    }
    
}