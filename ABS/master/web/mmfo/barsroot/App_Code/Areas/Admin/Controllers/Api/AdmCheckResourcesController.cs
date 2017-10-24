using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;

namespace BarsWeb.Areas.Admin.Controllers.Api
{
    [AuthorizeApi]
    public class AdmCheckResourcesController : ApiController
    {
        private readonly IADMRepository _repository;
        public AdmCheckResourcesController(IADMRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public HttpResponseMessage Get(string armCode)
        {
            try
            {
                var result = _repository.CheckAdmHasResources(armCode);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, new { Data = result, Msg = "" });
                return response;
            }
            catch (Exception ex)
            {
                string res = null;
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = res, Msg = ex.Message });
            }
        }
    }
}