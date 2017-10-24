using System;
using System.Linq;
using System.Net;
using Kendo.Mvc.UI;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;
using Kendo.Mvc.Extensions;

namespace BarsWeb.Areas.Zay.Controllers.Api.Birja
{
    /// <summary>
    /// Birja grid buy DataSource
    /// </summary>
    [AuthorizeApi]
    public class BirjaBDataController : ApiController
    {
        private readonly ICurrencySightRepository _repository;
        public BirjaBDataController(ICurrencySightRepository repository)
        {
            _repository = repository;
        }

        public HttpResponseMessage Get(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request,
            decimal dk, decimal? sos, decimal? visa)
        {
            try
            {
                var data = _repository.DealerBuyData(dk, sos, visa).ToList();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    data.ToDataSourceResult(request));
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Msg = ex.Message });
            }   
        }
    }
}

