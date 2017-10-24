using System.Net;
using System.Web.Http;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using AttributeRouting.Web.Http;
using System.Net.Http;

namespace BarsWeb.Areas.Admin.Controllers.Api
{
    [AuthorizeApi]
    public class GroupsController : ApiController
    {
        private readonly IHandbookRepository _repo;
        public GroupsController(IHandbookRepository repo)
        {
            _repo = repo;
        }
        [HttpGet]
        [GET("api/admin/groups/groupslist")]
        public HttpResponseMessage GroupsList()
        {
            var data = _repo.GroupsData();
            HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, data);
            return response;
        }
    }
}