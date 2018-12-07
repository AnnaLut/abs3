using BarsWeb.Areas.Way.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Way.Infrastructure.DI.Implementation;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.Way.Models;
using System.Collections.Generic;

namespace BarsWeb.Areas.Way.Controllers.Api
{
    [AuthorizeApi]
    public class InstallmentApiController : ApiController
    {
        readonly IInstallmentRepository _repo;
        public InstallmentApiController(IInstallmentRepository repo) { _repo = repo; }

        [HttpGet]
        public HttpResponseMessage GetSubContracts([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, [FromUri] int[] states, int? nd = null)
        {
            try
            {

                BarsSql sql = states.Length == 0 ? SqlCreator.GetSubContracts(nd) : SqlCreator.GetSubContracts(states, nd);

                var data = _repo.SearchGlobal<SubContractModel>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetPayments([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, int chainIdt, [FromUri] int[] states)
        {
            try
            {
                BarsSql sql = states.Length == 0 ? SqlCreator.GetPayments(chainIdt) : SqlCreator.GetPayments(chainIdt, states);

                var data = _repo.SearchGlobal<PaymentsModel>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetAccounts([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, int chainIdt)
        {
            try
            {
                BarsSql sql = SqlCreator.GetAccounts(chainIdt);
                var data = _repo.SearchGlobal<AccountsModel>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetStatuses([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                BarsSql sql = SqlCreator.GetStatuses();
                var data = _repo.SearchGlobal<ListsModel>(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
    }
}
