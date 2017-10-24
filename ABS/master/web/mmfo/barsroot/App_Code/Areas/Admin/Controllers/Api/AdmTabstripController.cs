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
    public class AdmTabstripController : ApiController
    {
        private readonly IADMRepository _repo;
        public AdmTabstripController(IADMRepository repo)
        {
            _repo = repo;
        }

        public HttpResponseMessage GetAdmTabstrip([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request,
            string id)
        {
            try
            {
                IQueryable<V_ARM_RESOURCE_TYPE_LOOKUP> data = _repo.GetAdmResourceTypeLookups().Where(x => x.ARM_CODE == id);
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