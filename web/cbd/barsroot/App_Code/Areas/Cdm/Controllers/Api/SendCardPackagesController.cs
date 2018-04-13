using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract;

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
        public HttpResponseMessage GetCards(int? cardsCount, int packSize = 1000)
        {
            _cdmRepository.PackAndSendClientCards(cardsCount, packSize);
            return Request.CreateResponse(HttpStatusCode.OK);
        }
    }
}