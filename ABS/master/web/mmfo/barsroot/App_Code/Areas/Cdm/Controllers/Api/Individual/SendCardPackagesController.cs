using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract.Individual;
using BarsWeb.Areas.Cdm.Models;

namespace BarsWeb.Areas.Cdm.Controllers.Api.Individual
{
    [AuthorizeApi]
    public class SendCardPackagesController : ApiController
    {
        private readonly ICdmRepository _cdmRepository;
        public SendCardPackagesController(ICdmRepository cdmRepository)
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