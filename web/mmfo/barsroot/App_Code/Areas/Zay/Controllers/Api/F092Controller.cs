using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;
using System.Web.Http.ModelBinding;
using AttributeRouting.Web.Http;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Zay.Controllers.Api
{
    [AuthorizeApi]
    public class F092Controller : ApiController
    {
        private readonly ICurrencyDictionary _dictionary;
        public F092Controller(ICurrencyDictionary dictionary)
        {
            _dictionary = dictionary;
        }
		
        [HttpGet]
        [GET("api/zay/F092/")]
        public HttpResponseMessage GetF092([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var data = _dictionary.F092Dictionary().ToList();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    data.ToDataSourceResult(request));
                return response;
            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, exception.Message);
            }
        }
    }
}