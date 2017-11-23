using AttributeRouting.Web.Http;
using BarsWeb.Areas.AccountRestore.Infrastructure.DI.Abstract;
using BarsWeb.Areas.AccountRestore.Infrastructure.DI.Implementation;
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
using Areas.AccountRestore.Models;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.AccountRestore.Models;

namespace BarsWeb.Areas.AccountRestore.Controllers.Api
{
    [AuthorizeApi]
    public class AccountRestoreController: ApiController
    {
        readonly IAccountRestoreRepository _repo;
        public AccountRestoreController(IAccountRestoreRepository repo) { _repo = repo; }

        [HttpGet]
        [ActionName("account")]
        public HttpResponseMessage GetRestoreAccount(String Nls, Int16 Kv)
        {
            try
            {
                RestoreAccount restoreAccount = _repo.GetRestoreAccount(Nls,Kv);

                return Request.CreateResponse(HttpStatusCode.OK, restoreAccount);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        [ActionName("currency")]
        public HttpResponseMessage GetCurrency([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                BarsSql sql = SqlCreator.GetCurrencies();
                var data = _repo.SearchGlobal<Models.Currency>(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch(Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage Restore(Decimal acc)
        {
            try
            {
                BarsSql sql = SqlCreator.Restore(acc);
                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch(Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
    }
}
