using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using BarsWeb.Areas.ReserveAccs.Models;
using System.Net.Http;
using BarsWeb.Areas.ReserveAccs.Infrastructure.Repository.DI.Abstract;
using System.Net;

/// <summary>
/// Summary description for ReserveAccsController
/// </summary>
public class ReserveAccsApiController: ApiController
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
    public HttpResponseMessage Activate(List<decimal> acc)
    {
        try
        {
            _resAcctRepository.Activate(acc);
            String accs = String.Empty;
            foreach (decimal id in acc)
            {
                accs += id.ToString() + " ,";
            }
            if (String.IsNullOrEmpty(accs))
                accs = accs.Substring(0, accs.Length - 2);
            return Request.CreateResponse(HttpStatusCode.OK, String.Format("Рахунок {0} успішно активовано", accs));
        }
        catch (Exception ex)
        {
            return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
        }
    }
}