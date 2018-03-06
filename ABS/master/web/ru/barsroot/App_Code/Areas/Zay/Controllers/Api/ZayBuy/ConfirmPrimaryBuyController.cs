using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;
using System.Web.Http.ModelBinding;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Zay.Controllers.Api.ZayBuy
{
    [AuthorizeApi]
    public class ConfirmPrimaryBuyController : ApiController
    {
        private readonly ICurrencySightRepository _repo;
        public ConfirmPrimaryBuyController(ICurrencySightRepository repo)
        {
            _repo = repo;
        }

        public HttpResponseMessage GetConfirmPrimaryBuyDataList(
            [ModelBinder(typeof (WebApiDataSourceRequestModelBinder))] DataSourceRequest request, decimal requestType)
        {
            try
            {
                var data = _repo.PrimaryBuyDataList(requestType).ToList();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, data.ToDataSourceResult(request));
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }
    }
}