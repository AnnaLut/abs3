using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;
//using System.Web.Mvc;
using System.Web.Http.ModelBinding;
using Kendo.Mvc.UI;
using Kendo.Mvc.Extensions;

namespace BarsWeb.Areas.Zay.Controllers.Api.ZayBuy
{
    /// <summary>
    /// Zay21. Currency Buy data
    /// </summary>
    [AuthorizeApi]
    public class CurrencyBuySightingController : ApiController
    {
        private readonly ICurrencySightRepository _repo;
	    public CurrencyBuySightingController(ICurrencySightRepository repo)
	    {
	        _repo = repo;
	    }

        public HttpResponseMessage GetDataList(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, decimal requestType)
        {
            try
            {
                var data = _repo.BuyDataList(requestType).ToList();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, data.ToDataSourceResult(request));
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
    }
}