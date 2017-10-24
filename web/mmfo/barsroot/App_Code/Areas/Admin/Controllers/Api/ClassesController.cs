using System.Net;
using System.Net.Http;
using System.Web.Http;
using AttributeRouting.Web.Http;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;

namespace BarsWeb.Areas.Admin.Controllers.Api
{
    [AuthorizeApi]
    public class ClassesController : ApiController
    {
        private readonly IHandbookRepository _repo;
        public ClassesController(IHandbookRepository repo)
        {
            _repo = repo;
        }
        [HttpGet]
        [GET("api/admin/classes/classeslist")]
        public HttpResponseMessage ClassesList()
        {
            var data = _repo.ClassesData();
            HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, data);
            return response;
        }
    }
}
