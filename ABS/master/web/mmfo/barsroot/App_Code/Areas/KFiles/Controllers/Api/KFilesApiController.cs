using BarsWeb.Areas.KFiles.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.KFiles.Models;
using System.Collections.Generic;
using System.Net.Http;
using System.Web.Http;
using System.Net;
using System;
using Kendo.Mvc.UI;
using System.Web.Mvc;

public class KFilesApiController : ApiController
{
    private readonly IKFilesAccountCorpRepository _repo;

    public KFilesApiController(IKFilesAccountCorpRepository repo)
    {
        _repo = repo;
    }

    public HttpResponseMessage Post(List<AccCorpSave> accCorpSave)
    {
       try
        {
            _repo.AccCorpSave(accCorpSave);
            return Request.CreateResponse(HttpStatusCode.OK, new { Message = "Зміни збережено" });
        }
        catch(Exception ex)
        {
            return Request.CreateResponse(HttpStatusCode.OK, new { Message = ex.Message});
        }
    }
}