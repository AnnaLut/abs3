using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using BarsWeb.Areas.Acct.Infrastructure.Repository;
using BarsWeb.Areas.Acct.Models;
using BarsWeb.Areas.Security.Attributes;
using BarsWeb.Core.Models;
using BarsWeb.Core.Extensions;
using BarsWeb.Core.Models.Binders.Api;

namespace BarsWeb.Areas.Acct.Controllers.Api.V1
{
    [AuthorizeApi]
    public class ReservedAccountsController : ApiController
    {
        private readonly IReservedAccountsRepository _resAcctRepository;
        public ReservedAccountsController(IReservedAccountsRepository resAcctRepository)
        {
            _resAcctRepository = resAcctRepository;
        }

        public DataSourceResult Get(
            [ModelBinder(typeof (WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            var list = _resAcctRepository.GetAllReservedAccounts();
            return list.ToDataSource(request);
        }

        public HttpResponseMessage Delete(decimal id)
        {
            _resAcctRepository.UnreserveAccount(id);
            return Request.CreateResponse(HttpStatusCode.OK);
        }

        public HttpResponseMessage Post(ReservedAccountRegister account)
        {
            var id = _resAcctRepository.Reserved(account);

            return Request.CreateResponse(HttpStatusCode.OK, new {Id = id});
        }
    }
}