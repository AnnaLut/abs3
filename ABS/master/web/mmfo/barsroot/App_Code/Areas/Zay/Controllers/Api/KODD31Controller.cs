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
    public class KodD31Controller : ApiController
    {
        private readonly ICurrencyDictionary _dictionary;
        public KodD31Controller(ICurrencyDictionary dictionary)
        {
            _dictionary = dictionary;
        }

        [HttpGet]
        [GET("api/zay/kodd31/")]
        public HttpResponseMessage Get(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var data = _dictionary.AimDescriptionDictionary().Select(x => new { x.P40, x.TXT }).ToList();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    data.ToDataSourceResult(request));
                return response;
            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.OK, exception.Message);
            }
        }

        [HttpGet]
        [GET("api/zay/kodd31/item")]
        public HttpResponseMessage CheckItem(string id)
        {
            try
            {
                var data = _dictionary.AimDescriptionDictionary()/*.Select(x => new { x.P40, x.TXT })*/.Where( x => x.P40 == id);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    data.Any() ? 1 : 0);
                return response;
            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.OK, exception.Message);
            }
        }
    }
}