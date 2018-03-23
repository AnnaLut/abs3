using AttributeRouting.Web.Http;
using BarsWeb.Areas.BpkW4.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.BpkW4.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Areas.BpkW4.Models;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;

namespace BarsWeb.Areas.BpkW4.Controllers.Api
{
    public class ActivationReservedAccountsApiController: ApiController
    {
        readonly IActivationReservedAccountsRepository _repo;        
        public ActivationReservedAccountsApiController(IActivationReservedAccountsRepository repository) { _repo = repository; }

        [HttpPost]
        [POST("/api/BpkW4/ActivationReservedAccountsApi/active")]
        public HttpResponseMessage Active(ActivationAccounts acc)
        {
            try
            {
                //decimal?[] arra = Array.ConvertAll(acc.Data.ToArray(), value => new decimal?(value));
                //BarsSql sql = SqlCreatorBPK.Active(arra, acc.Confirm);
                //_repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);
				_repo.Activate(acc.Data, acc.Confirm);
                return Request.CreateResponse(HttpStatusCode.OK, new { });
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpGet]
        [GET("/api/BpkW4/ActivationReservedAccountsApi/activationreservedaccounts")]
        public HttpResponseMessage ActivationReservedAccounts([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                BarsSql sql = SqlCreatorBPK.ActivationReservedAccounts();
                IEnumerable<ActivationReservedAccounts> data = _repo.SearchGlobal<ActivationReservedAccounts>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }
    }
}

