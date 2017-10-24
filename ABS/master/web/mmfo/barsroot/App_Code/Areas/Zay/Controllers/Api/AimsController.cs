using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;
using Kendo.Mvc.Extensions;
using System.Web.Http.ModelBinding;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Zay.Controllers.Api
{
    [AuthorizeApi]
    public class AimsController : ApiController
    {
        private readonly ICurrencyDictionary _dictionary;
        public AimsController(ICurrencyDictionary dictionary)
        {
            _dictionary = dictionary;
        }
        [HttpGet]
        public HttpResponseMessage Get([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var data = _dictionary.ZayAimsDictionary().Select(x => new { x.AIM_CODE, x.AIM_NAME}).ToList();
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