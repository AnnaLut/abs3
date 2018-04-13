using System.Web.Http;
using BarsWeb.Areas.Acct.Infrastructure.Repository.DI.Abstract;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Acct.Controllers.Api
{
    /// <summary>
    /// Accounts API
    /// </summary>
    [AuthorizeApi]
    public class AccountsController : ApiController
    {
        private readonly IAccountsRepository _repository;
        public AccountsController(IAccountsRepository repository)
        {
            _repository = repository;
        }

        public DataSourceResult GetAllAccounts([System.Web.Http.ModelBinding.ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request)
        {
            var accounts = _repository.GetAccounts();
            return accounts.ToDataSourceResult(request);
        }

        public DataSourceResult GetAllAccounts([System.Web.Http.ModelBinding.ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request, string branch)
        {
            var accounts = _repository.GetAccounts(branch);
            return accounts.ToDataSourceResult(request);
        }

        /*public HttpResponseMessage Get(int id)
        {
            return Request.CreateResponse(HttpStatusCode.OK, id);
        }*/
    }
}