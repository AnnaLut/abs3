using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Cdm.Models;

namespace BarsWeb.Areas.Cdm.Controllers.Api
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
            _cdmRepository.PackAndSendClientCards(param.CardsCount, param.PackSize.Value);
            return Request.CreateResponse(HttpStatusCode.OK);
        }

    }
}