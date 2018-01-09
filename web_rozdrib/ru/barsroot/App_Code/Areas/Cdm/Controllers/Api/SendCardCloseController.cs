using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Cdm.Models;

namespace BarsWeb.Areas.Cdm.Controllers.Api
{
    [AuthorizeApi]
    public class SendCardCloseController : ApiController
    {
        private readonly ICdmRepository _cdmRepository;
        public SendCardCloseController(ICdmRepository cdmRepository)
        {
            _cdmRepository = cdmRepository;
        }

        public HttpResponseMessage Post(ClientParams clientParams)
        {
            _cdmRepository.SendCloseCard(clientParams.Kf, clientParams.Rnk, clientParams.DateOff);
            return Request.CreateResponse(HttpStatusCode.OK);
        }

    }
}