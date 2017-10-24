using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.FinView.Infrastructure.DI.Abstract;
using System.Web.Http.ModelBinding;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.FinView.Controllers.Api
{
    [AuthorizeApi]
    public class DocDataController : ApiController
    {
        private readonly IFinanceRepository _finRepo;
        public DocDataController(IFinanceRepository finRepo)
        {
            _finRepo = finRepo;
        }
        public HttpResponseMessage Get(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request,
            decimal acc, string date)
        {
            try
            {
                var data = _finRepo.DocumentData(acc, date).ToList();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, data.ToDataSourceResult(request));
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Msg = ex.Message });
            }
        }
    }
}