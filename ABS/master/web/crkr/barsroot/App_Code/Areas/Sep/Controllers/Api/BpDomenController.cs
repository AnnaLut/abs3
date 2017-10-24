using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Implementation;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace BarsWeb.Areas.Sep.Controllers.Api
{
    [AuthorizeApi]
    public class BpDomenController : ApiController
    {
        private readonly IBpDomenRepository _repo;
        public BpDomenController()
        {
            _repo = new BpDomenRepository();
        }

        public HttpResponseMessage Get()
        {
            return Request.CreateResponse(HttpStatusCode.OK, _repo.GetBpDomen());
        }
    }
}