using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using BarsWeb.Areas.ReserveAccs.Models;
using System.Net.Http;
using BarsWeb.Areas.ReserveAccs.Infrastructure.Repository.DI.Abstract;
using System.Net;
using BarsWeb.Areas.ReserveAccs.Models.Bases;
using BarsWeb.Areas.BpkW4.Models;

/// <summary>
/// Summary description for ReserveAccsController
/// </summary>
public class ReserveAccsApiController : ApiController
{
	private readonly IReserveAccsRepository _resAcctRepository;
	public ReserveAccsApiController(IReserveAccsRepository resAcctRepository)
	{
		_resAcctRepository = resAcctRepository;
	}

	[HttpPost]
	public HttpResponseMessage Reserved(ReservedAccountRegister account)
	{
		var id = _resAcctRepository.Reserved(account);

		return Request.CreateResponse(HttpStatusCode.OK, new { Id = id });
	}

	[HttpGet]
	public HttpResponseMessage GetSpecParamList()
	{
		var list = _resAcctRepository.GetSpecParamList();
		return Request.CreateResponse(HttpStatusCode.OK, new { list });
	}

	[HttpGet]
	public HttpResponseMessage GetNDBO(decimal rnk)
	{
		var ndbo = _resAcctRepository.GetNDBO(rnk);
		return Request.CreateResponse(HttpStatusCode.OK, ndbo);
	}

	[HttpPost]
	public HttpResponseMessage Activate(ReserveAccsKeys keys)
	{
		try
		{
			var res = _resAcctRepository.Activate(keys);
			String accs = String.Empty;
			foreach (string id in res)
			{
				accs += id + ", ";
			}
			return Request.CreateResponse(HttpStatusCode.OK, String.Format("Рахунок {0} успішно активовано", accs));
		}
		catch (Exception ex)
		{
			return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
		}
	}

	[HttpPost]
	public HttpResponseMessage GetReadyEtalonAccounts(ReservedKey key)
	{
		var accounts = _resAcctRepository.GetReadyEtalonAccounts(key);
		return Request.CreateResponse(HttpStatusCode.OK, accounts);
	}
	[HttpPost]
	public HttpResponseMessage HasAnyOpenAccounts(ReservedKey key)
	{
		var accounts = _resAcctRepository.GetReadyEtalonAccounts(key);
		return Request.CreateResponse(HttpStatusCode.OK, accounts.Count > 0);
	}
	[HttpPost]
	public HttpResponseMessage GetReservedAccountsByKey(ReservedKey key)
	{
		var accounts = _resAcctRepository.GetReservedAccounts(key);
		return Request.CreateResponse(HttpStatusCode.OK, accounts);
	}
	[HttpPost]
	public HttpResponseMessage AcceptWithDublication(ReservedDublicateAccKey key)
	{
		try
		{
			_resAcctRepository.AcceptWithDublication(key);
			return Request.CreateResponse(HttpStatusCode.OK);
		}
		catch (Exception ex)
		{
			return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
		}
	}
	[HttpGet]
	public HttpResponseMessage GetCreatedAccNLSKV(string nls, int? kv)
	{
		try
		{
			var data = _resAcctRepository.GetCreatedAccNLSKV(nls, kv);
			return Request.CreateResponse(HttpStatusCode.OK, data);
		}
		catch (Exception ex)
		{
			return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
		}
	}
	[HttpPost]
	public HttpResponseMessage PrintDoc(ReservedPrintKey key)
	{
		try
		{ 
			return Request.CreateResponse(HttpStatusCode.OK, _resAcctRepository.PrintDoc(key));
		}
		catch (Exception ex)
		{
			return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
		}
	}
	[HttpGet]
	public HttpResponseMessage GetPrintDocs()
	{
		try
		{
			return Request.CreateResponse(HttpStatusCode.OK, _resAcctRepository.GetPrintDocs());
		}
		catch (Exception ex)
		{
			return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
		}
	}
}