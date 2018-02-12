using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using Areas.CustomerList.Models;
using BarsWeb.Areas.CustomerList.Infrastructure.DI.Abstract;
using Kendo.Mvc.Extensions;

namespace BarsWeb.Areas.CustomerList.Controllers.Api
{
	public class AccountsSpecparamViewController : ApiController
	{
		readonly IAccountsSpecparamRepository _repo;
		public AccountsSpecparamViewController(IAccountsSpecparamRepository repo) { _repo = repo; }
		[HttpGet]
		public HttpResponseMessage AccountsSource([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request, 
			string metaFilter, int? Custtype, string nls, string branch, string nms, string ob22, string rnk, int? kv, bool showClosed)
		{
			try
			{
				return Request.CreateResponse(HttpStatusCode.OK, _repo.GetAccounts(
					new AccountsSparamcustfilterDTI() {
						metaFilter = metaFilter,
						Custtype = Custtype,
						nls = nls,
						branch= branch,
						nms= nms,
						ob22= ob22,
						rnk= rnk,
						kv = kv,
						showClosed = showClosed
					}).ToDataSourceResult(request));
			}
			catch (Exception ex)
			{
				return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
			}
		}
		[HttpGet]
		public HttpResponseMessage GetAvaliableBranchList()
		{
			try
			{
				return Request.CreateResponse(HttpStatusCode.OK, _repo.GetAvaliableBranchList());
			}
			catch (Exception ex)
			{
				return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
			}
		}
		[HttpGet]
		public HttpResponseMessage GetAvaliableOb22List()
		{
			try
			{
				return Request.CreateResponse(HttpStatusCode.OK, _repo.GetAvaliableOb22List());
			}
			catch (Exception ex)
			{
				return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
			}
		}
	}
}