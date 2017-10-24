using BarsWeb.Areas.Cdm.Infrastructure.DI.Abstract.Legal;
using BarsWeb.Areas.Cdm.Models.Transport;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace BarsWeb.Areas.Cdm.Controllers.Api
{
    [AuthorizeApi]
    public class CsbValidateLegalController : ApiController
    {
        ICdmLegalRepository _cdmLegalRepository;
        public CsbValidateLegalController(ICdmLegalRepository cdmLegalRepository)
        {
            _cdmLegalRepository = cdmLegalRepository;
        }
        public HttpResponseMessage Put(decimal id)
        {
            var result = _cdmLegalRepository.PackAndSendSingleCard(id);
          
            return Request.CreateResponse(HttpStatusCode.OK, result);
        }
        
    }
}
