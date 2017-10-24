using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;

namespace BarsWeb.Areas.Admin.Controllers.Api
{
    //[AuthorizeApi]
    public class UserCardController: ApiController
    {
        private readonly IADMURepository _repo;
        public UserCardController(IADMURepository repo)
        {
            _repo = repo;
        }
        public HttpResponseMessage GetUserData(string id)
        {
            try
            {
                var data = _repo.GetUserData(id);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, data);
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }
    }
}