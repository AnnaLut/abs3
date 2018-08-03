using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;
using System.Web.Http.ModelBinding;
using BarsWeb.Areas.Ndi.Infrastructure;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Zay.Controllers.Api.ZaySale
{
    /// <summary>
    /// Zay22. Currency Sale data
    /// </summary>

    [AuthorizeApi]
    public class CurrencySaleSightingController : ApiController
    {
        private readonly ICurrencySightRepository _repo;
        private readonly ICurrencyDictionary _dictionary;

        public CurrencySaleSightingController(ICurrencySightRepository repo, ICurrencyDictionary dictionary)
        {
            _repo = repo;
            _dictionary = dictionary;
        }
        public HttpResponseMessage GetDataList(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, decimal requestType)
        {
            try
            {
                var data = _repo.SaleDataList(requestType).ToList();
                for (var i = 0; i < data.Count; i++)
                {
                    var aimsCode = data[i].AIMS_CODE.ToString();
                    if (!aimsCode.IsNullOrEmpty())
                    {
                        var item = _dictionary.AimDescriptionDictionary().Where(x => x.P40 == aimsCode).Select(x => x.TXT).FirstOrDefault();
                        data[i].TXT = item.ToString().IsNullOrEmpty() ? "" : item.ToString();
                    }
                }
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
