using BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Cdm.Models.Transport;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace BarsWeb.Areas.Cdm.Controllers.Api
{
    [AuthorizeApi]
    public class CsbValidateController : ApiController
    {
        ICdmRepository _cdmRepository;
        public CsbValidateController(ICdmRepository cdmRepository)
        {
            _cdmRepository = cdmRepository;
        }

        public HttpResponseMessage Post(decimal id)
        {
            var result = _cdmRepository.PackAndSendSingleCard(id, "POST");
          
            return Request.CreateResponse(HttpStatusCode.OK, result);
        }

        public HttpResponseMessage Put(decimal id)
        {
            var result = _cdmRepository.PackAndSendSingleCard(id, "PUT");
          
            return Request.CreateResponse(HttpStatusCode.OK, result);
        }
        
    }
}