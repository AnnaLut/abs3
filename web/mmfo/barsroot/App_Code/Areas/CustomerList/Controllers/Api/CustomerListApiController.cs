using AttributeRouting.Web.Http;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.CustomerList.Infrastructure.DI.Abstract;
using BarsWeb.Areas.CustomerList.Infrastructure.DI.Implementation;
using System;
using System.Drawing;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using Areas.CustomerList.Models;

namespace BarsWeb.Areas.CustomerList.Controllers.Api
{
    public class CustomerListController: ApiController
    {
        readonly ICustomerListRepository _repo;
        public CustomerListController(ICustomerListRepository repo) { _repo = repo; }

        [HttpGet]
        public HttpResponseMessage SearchMain([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                BarsSql sql = SqlCreator.SearchMain();
                var data = _repo.SearchGlobal<CustAccount>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage TotalCurrencies([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request, string bankDate)
        {
            try
            {
                var session = HttpContext.Current.Session;
                var accList = session["SQL_CURRENCY"].ToString();
                BarsSql sql = SqlCreator.SearchTotalCurrencies(bankDate, accList);
                var data = _repo.SearchGlobal<TotalCurrency>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
    }
}
