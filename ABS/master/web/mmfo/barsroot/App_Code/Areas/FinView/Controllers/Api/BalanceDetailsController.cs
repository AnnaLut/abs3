using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using BarsWeb.Areas.FinView.Infrastructure.DI.Abstract;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.FinView.Controllers.Api
{
    public class BalanceDetailsController : ApiController
    {
        private readonly IFinanceRepository _finRepo;
        public BalanceDetailsController(IFinanceRepository finRepo)
        {
            _finRepo = finRepo;
        }

        [HttpGet]
        public HttpResponseMessage Get(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string kf, string nbs, string branch, string kv, string date)
        {
            try
            {
                var data = _finRepo.AccountData(kf, nbs, branch, kv, date).ToList();
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