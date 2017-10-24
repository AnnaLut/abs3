using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Areas.Admin.Models;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using System.Web.Http.ModelBinding;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Admin.Controllers.Api
{
    //[AuthorizeApi]
    public class AdmResourceAccessController : ApiController
    {
        private readonly IADMRepository _repo;
        public AdmResourceAccessController(IADMRepository repo)
        {
            _repo = repo;
        }
        public HttpResponseMessage GetAdmResourceAccessMode(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request,
            string id, string code)
        {
            //var typeId = Decimal.Parse(id);
            try
            {
                IQueryable<V_ARM_RESOURCE_ACCESS_MODE> data = _repo.GetAdmAccessModes(id, code);
                var dataList = data.Select(x => new { x.ACCESS_MODE_ID, x.ACCESS_MODE_NAME}).ToList();  
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