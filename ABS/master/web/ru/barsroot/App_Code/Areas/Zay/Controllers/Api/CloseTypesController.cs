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
    public class CloseTypesController : ApiController
    {
        private readonly ICurrencyDictionary _dictionary;
        public CloseTypesController(ICurrencyDictionary dictionary)
        {
            _dictionary = dictionary;
        }
        [HttpGet]
        public HttpResponseMessage Get()
        {
            try
            {
                var data = _dictionary.CloseTypes();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, data);
                return response;
            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.Gone, exception.Message);
            }
        }
    }
}