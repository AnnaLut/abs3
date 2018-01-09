using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Implementation;

namespace Areas.Kernel.Controllers.Api
{
    public class BankSabController : ApiController
    {
        private readonly IBanksRepository _repo;
        public BankSabController()
        {
            _repo = new BanksRepository();
        }

        public BankSabController(IBanksRepository repository)
        {
            _repo = repository;
        }
        public HttpResponseMessage Get()
        {
            return Request.CreateResponse(HttpStatusCode.OK, _repo.GetOurSab());
        }
    }
}