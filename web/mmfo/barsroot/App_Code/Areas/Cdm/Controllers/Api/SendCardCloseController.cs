using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Cdm.Models;
using BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract.Individual;
using BarsWeb.Areas.Cdm.Infrastructure.DI.Abstract.PrivateEn;
using BarsWeb.Areas.Cdm.Infrastructure.DI.Abstract.Legal;
using BarsWeb.Core.Models.Json;

namespace BarsWeb.Areas.Cdm.Controllers.Api
{
    [AuthorizeApi]
    public class SendCardCloseController : ApiController
    {
        private readonly ICdmRepository _cdmRepository;
        private readonly ICdmPrivateEnRepository _cdmPrivateEnRepository;
        private readonly ICdmLegalRepository _cdmLegalRepository;
        public SendCardCloseController(ICdmRepository cdmRepository, ICdmPrivateEnRepository cdmPrivateEnRepository, ICdmLegalRepository cdmLegalRepository)
        {
            _cdmRepository = cdmRepository;
            _cdmPrivateEnRepository = cdmPrivateEnRepository;
            _cdmLegalRepository = cdmLegalRepository;
        }

        public HttpResponseMessage Post(ClientParams clientParams)
        {
            string message;

            switch (clientParams.custType)
            {
                case "person":
                    message = _cdmRepository.SendCloseCard(clientParams.Kf, clientParams.Rnk, clientParams.DateOff);
                    return Request.CreateResponse(HttpStatusCode.OK, new JsonResponse() { Message = message });
                case "personspd":
                    message = _cdmPrivateEnRepository.SendCloseCard(clientParams.Kf, clientParams.Rnk, clientParams.DateOff);
                    return Request.CreateResponse(HttpStatusCode.OK, new JsonResponse() { Message = message });
                case "corp":
                    message = _cdmLegalRepository.SendCloseCard(clientParams.Kf, clientParams.Rnk, clientParams.DateOff);
                    return Request.CreateResponse(HttpStatusCode.OK, new JsonResponse() { Message = message });
            }

            return Request.CreateResponse(HttpStatusCode.OK);
        }

    }
}