using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Zay.Controllers.Api
{
    [AuthorizeApi]
    public class Kod704Controller : ApiController
    {
        private readonly ICurrencyDictionary _dictionary;
        public Kod704Controller(ICurrencyDictionary dictionary)
        {
            _dictionary = dictionary;
        }

        [HttpGet]
        public HttpResponseMessage Get(
            [ModelBinder(typeof (WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var data = _dictionary.Kod70_4Dictionary().Select(x => new { x.PRODUCT_GROUP, x.PRODUCT_GROUP_NAME }).ToList();
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