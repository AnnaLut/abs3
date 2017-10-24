using BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract.Individual;
using BarsWeb.Areas.Cdm.Models.Transport;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace BarsWeb.Areas.Cdm.Controllers.Api
{
    [AuthorizeApi]
    public class CsbValidateIndividualController : ApiController
    {
        ICdmRepository _cdmRepository;
        public CsbValidateIndividualController(ICdmRepository cdmRepository)
        {
            _cdmRepository = cdmRepository;
        }

        public HttpResponseMessage Put(decimal id)
        {
            var result = _cdmRepository.PackAndSendSingleCard(id);
          
            return Request.CreateResponse(HttpStatusCode.OK, result);
        }
        
    }
}