using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using Kendo.Mvc.UI;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using BarsWeb.Areas.FinView.Infrastructure.DI.Abstract;
using BarsWeb.Areas.FinView.Models;
using Kendo.Mvc.Extensions;

namespace BarsWeb.Areas.FinView.Controllers.Api
{
    [AuthorizeApi]
    public class BalanceDataController : ApiController
    {
        private readonly IFinanceRepository _finRepo;
        public BalanceDataController(IFinanceRepository finRepo)
        {
            _finRepo = finRepo;
        }

        public HttpResponseMessage Get(
            [ModelBinder(typeof (WebApiDataSourceRequestModelBinder))] DataSourceRequest request,
            string date, decimal rowType, string branch = null)
        {
            try
            {
                var data = _finRepo.BalanceViewData(date, rowType, branch).ToList();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, new { Data = data.ToDataSourceResult(request), Msg = "Response ok" });
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = 0, Msg = ex.Message });   
            }
        }
    }
}