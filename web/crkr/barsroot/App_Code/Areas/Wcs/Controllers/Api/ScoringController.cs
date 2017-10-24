using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Wcs.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Wcs.Infrastructure.DI.Implementation;
using BarsWeb.Areas.Wcs.Models;

namespace BarsWeb.Areas.Wcs.Controllers.Api
{
    public class ScoringController : ApiController
    {
        private readonly IWcsRepository _repo;
        public ScoringController()
        {
            _repo = new WcsRepository();
        }
        public ScoringController(IWcsRepository repository)
        {
            _repo = repository;
        }
        public HttpResponseMessage Get(int bidId)
        {
            IQueryable<ScoringQuestion> questions = _repo.GetScoringQuestion(bidId).OrderBy(i => i.Ord);
            return Request.CreateResponse(HttpStatusCode.OK, questions);
        }
        public HttpResponseMessage Get(int bidId, string type)
        {
            if (!string.IsNullOrEmpty(type) && type == "cnt")
            {
                return Request.CreateResponse(HttpStatusCode.OK, _repo.GetCountGarantees(bidId));
            }
            else if (!string.IsNullOrEmpty(type)) 
            {
                ScoringResult res = _repo.GetResult(bidId);
                return Request.CreateResponse(HttpStatusCode.OK, res);
            }
            return null;
        }
    }
}