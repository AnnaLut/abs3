using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Cdm.Infrastructure.DI.Abstract.PrivateEn;
using BarsWeb;
using BarsWeb.Areas.Cdm.Models;

namespace Areas.Cdm.Controllers.Api.PrivateEn
{
    [AuthorizeApi]
    public class SendCardPackagesPrivateEnController : ApiController
    {
        private readonly ICdmPrivateEnRepository _cdmRepository;
        public SendCardPackagesPrivateEnController(ICdmPrivateEnRepository cdmRepository)
        {
            _cdmRepository = cdmRepository;
        }
        
        public HttpResponseMessage Post(ClientPackParams param)
        {
            if (param.PackSize == null)
            {
                param.PackSize = 1000;
            }
            _cdmRepository.PackAndSendClientCards(param.CardsCount, param.PackSize.Value, param.kf);
            return Request.CreateResponse(HttpStatusCode.OK);
        }

    }
}