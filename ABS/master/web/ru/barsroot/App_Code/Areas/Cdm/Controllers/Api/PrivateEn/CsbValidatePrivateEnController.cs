using BarsWeb.Areas.Cdm.Infrastructure.DI.Abstract.PrivateEn;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace BarsWeb.Areas.Cdm.Controllers.Api
{
    [AuthorizeApi]
    public class CsbValidatePrivateEnController : ApiController
    {
        ICdmPrivateEnRepository _cdmPrivateEnRepository;
        public CsbValidatePrivateEnController(ICdmPrivateEnRepository cdmPrivateEnRepository)
        {
            _cdmPrivateEnRepository = cdmPrivateEnRepository;
        }

        public HttpResponseMessage Put(decimal id)
        {
            var result = _cdmPrivateEnRepository.PackAndSendSingleCard(id);
          
            return Request.CreateResponse(HttpStatusCode.OK, result);
        }
        
    }
}
