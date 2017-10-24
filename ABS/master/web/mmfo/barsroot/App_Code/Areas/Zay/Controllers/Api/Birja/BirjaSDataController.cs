using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;
using System.Web.Http.ModelBinding;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Zay.Controllers.Api.Birja
{
    /// <summary>
    /// Birja grid sale dataSource
    /// </summary>
    [AuthorizeApi]
    public class BirjaSDataController : ApiController
    {
        private readonly ICurrencySightRepository _repository;
        public BirjaSDataController(ICurrencySightRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public HttpResponseMessage Get(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request,
            decimal dk, decimal? sos, decimal? visa)
        {
            try
            {
                var data = _repository.DealerSaleData(dk, sos, visa).ToList();
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