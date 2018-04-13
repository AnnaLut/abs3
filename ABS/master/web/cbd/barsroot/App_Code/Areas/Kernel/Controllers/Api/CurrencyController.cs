using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using Kendo.Mvc.UI;
using Kendo.Mvc.Extensions;

namespace BarsWeb.Areas.Kernel.Controllers.Api
{

    public class CurrencyController : ApiController
    {
        private readonly ICurrencyDict _repo;
        public CurrencyController(ICurrencyDict repository)
        {
            _repo = repository;
        }
        public HttpResponseMessage Get([System.Web.Http.ModelBinding.ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            IQueryable<TabvalViewModel> currList = _repo.GetTabvals();
            var result = currList.ToDataSourceResult(request);
            return Request.CreateResponse(HttpStatusCode.OK, result);
        }
        public HttpResponseMessage GetAll(bool onlyOpen)
        {
            List<Currency> currList;
            if (onlyOpen)
            {
                currList = _repo.GetAllCurrencies().Where(i => i.DateClosed == null).OrderBy(i=>i.Code).ToList();
            }
            else
            {
                 currList = _repo.GetAllCurrencies().OrderBy(i=>i.Code).ToList();
            }
            return Request.CreateResponse(HttpStatusCode.OK, currList);
        }
    }
}