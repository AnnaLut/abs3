using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Implementation;
using BarsWeb.Areas.Kernel.Models;

namespace BarsWeb.Areas.Kernel.Controllers.Api
{
    public class BankController : ApiController
    {
        private readonly IBanksRepository _repo;
        public BankController()
        {
            _repo = new BanksRepository();
        }
        public BankController(IBanksRepository repository)
        {
            _repo = repository;
        }
        public HttpResponseMessage Get()
        {
            IQueryable<BankViewModel> currList = _repo.GetOurBanks();
            return Request.CreateResponse(HttpStatusCode.OK, 
                currList.Select(b => new { Mfo = b.Mfo, Nb = b.Nb, Sab = b.Sab }).OrderBy(b => b.Sab));
        }
    }
}