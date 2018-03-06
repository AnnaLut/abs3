using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Zay.Models;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using Models;

namespace BarsWeb.Areas.Zay.Controllers.Api
{
    [AuthorizeApi]
    public class CountryController : ApiController
    {
        private readonly ICurrencyDictionary _dictionary;
        public CountryController(ICurrencyDictionary dictionary)
        {
            _dictionary = dictionary;
        }

        [HttpGet]
        public HttpResponseMessage Get(
            [ModelBinder(typeof (WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var data = _dictionary.CountryDictionary()
                    .Select(x => new Country { COUNTRY_CODE = x.COUNTRY_CODE, COUNTRY_NAME = x.COUNTRY_NAME })
                    .ToList();
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