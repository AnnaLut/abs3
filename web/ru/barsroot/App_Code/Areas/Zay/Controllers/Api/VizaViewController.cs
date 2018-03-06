using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;
using System.Web.Http.ModelBinding;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Zay.Controllers.Api
{
    [AuthorizeApi]
    public class VizaViewController : ApiController
    {
        private readonly ICurrencyDictionary _repo;
        public VizaViewController(ICurrencyDictionary repo)
        {
            _repo = repo;
        }

        [HttpGet]
        public HttpResponseMessage Get([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, decimal id)
        {
            try
            {
                var data = _repo.VizaStatusData(id).ToList();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    data.ToDataSourceResult(request));
                return response;
            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.OK, exception.Message);
            }    
        }
    }
}