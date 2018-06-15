using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb;
using BarsWeb.Areas.Cdm.Infrastructure.DI.Abstract.Legal;
using BarsWeb.Areas.Cdm.Models;

namespace Areas.Cdm.Controllers.Api.Legal
{
    [AuthorizeApi]
    public class SendCardPackagesLegalController : ApiController
    {
        private readonly ICdmLegalRepository _cdmRepository;
        public SendCardPackagesLegalController(ICdmLegalRepository cdmRepository)
        {
            _cdmRepository = cdmRepository;
        }
        
        public HttpResponseMessage Post(ClientPackParams param)
        {
            if (param.PackSize == null)
            {
                param.PackSize = 1000;
            }
            int stausResult = (int)_cdmRepository.PackAndSendClientCards(param.CardsCount, param.PackSize.Value, param.kf);
            return Request.CreateResponse(HttpStatusCode.OK, stausResult);
        }
    }
}