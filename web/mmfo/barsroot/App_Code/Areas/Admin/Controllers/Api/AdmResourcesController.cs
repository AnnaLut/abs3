using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using Kendo.Mvc.UI;
using System.Web.Http.ModelBinding;
using Areas.Admin.Models;
using Kendo.Mvc.Extensions;

namespace BarsWeb.Areas.Admin.Controllers.Api
{
    //[AuthorizeApi]
    public class AdmResourcesController : ApiController
    {
        private readonly IADMRepository _repo;
        public AdmResourcesController(IADMRepository repo)
        {
            _repo = repo;
        }

        public HttpResponseMessage GetAdmResourcesData(
           [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request,
           string id, string code)
        {
            var numId = Decimal.Parse(id);
            var typeId = Decimal.Parse(code);
            try
            {
                IQueryable<V_ARM_RESOURCE> data = _repo.GetAdmResources(id, code);
                var dataList = data.ToList(); // зависає Where(x => x.ARM_ID == numId && x.RESOURCE_TYPE_ID == typeId).
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