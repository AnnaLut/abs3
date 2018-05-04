using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Cdm.Infrastructure.DI.Abstract.Legal;
using BarsWeb.Areas.Cdm.Infrastructure.DI.Abstract.PrivateEn;
using BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract.Individual;
using BarsWeb.Areas.Cdm.Models;

public class SyncCardController : ApiController
{
    private readonly ICdmRepository _cdmRepository;
    private readonly ICdmLegalRepository _cdmLegalRepository;
    private readonly ICdmPrivateEnRepository _cdmPrivateEnRepository;

    public SyncCardController(ICdmRepository cdmRepository, ICdmLegalRepository cdmLegalRepository, ICdmPrivateEnRepository cdmPrivateEnRepository)
    {
        _cdmRepository = cdmRepository;
        _cdmLegalRepository = cdmLegalRepository;
        _cdmPrivateEnRepository = cdmPrivateEnRepository;
    }

    // GET CDMService/SyncCard
    public HttpResponseMessage Get([FromUri] ClientParams clinentParams)
    {
        var statusMsg = "ERROR";
        switch (clinentParams.custType)
        {
            case "person": // ФО
                statusMsg = _cdmRepository.SynchronizeCard(clinentParams.Kf, clinentParams.Rnk);
                break;
            case "corp": // ЮО
                statusMsg = _cdmLegalRepository.SynchronizeCard(clinentParams.Kf, clinentParams.Rnk);
                break;
            case "personspd": // ФОП
                statusMsg = _cdmPrivateEnRepository.SynchronizeCard(clinentParams.Kf, clinentParams.Rnk);
                break;
            default:
                statusMsg = "ERROR";
                break;
        }
        return Request.CreateResponse(HttpStatusCode.OK, statusMsg);
    }
}
