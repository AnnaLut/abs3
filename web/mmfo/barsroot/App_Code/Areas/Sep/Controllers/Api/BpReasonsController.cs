using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Implementation;

namespace BarsWeb.Areas.Sep.Controllers.Api
{
    [AuthorizeApi]
    public class BpReasonsController : ApiController
    {
        private readonly IBpReasonRepository _repo;
        public BpReasonsController()
        {
            _repo = new BpReasonRepository();
        }
        public BpReasonsController(IBpReasonRepository repository)
        {
            _repo = repository;
        }
        public HttpResponseMessage Get()
        {
            var bpReasons = _repo.GetBpReasons().Select(r => new {r.ID, r.REASON});
            return Request.CreateResponse(HttpStatusCode.OK, bpReasons);
        }
    }
}