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
}