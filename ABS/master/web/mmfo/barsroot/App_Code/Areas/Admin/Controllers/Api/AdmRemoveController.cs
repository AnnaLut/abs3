using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;

namespace BarsWeb.Areas.Admin.Controllers.Api
{
    [AuthorizeApi]
    public class AdmRemoveController : ApiController
    {
        private readonly IADMRepository _repository;
        public AdmRemoveController(IADMRepository repository)
        {
            _repository = repository;
        }
        [HttpGet]
        public HttpResponseMessage Get(string armCode)
        {
            try
            {
                _repository.RemoveAdm(armCode);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, new { Data = 1, Msg = "" });
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = 0, Msg = ex.Message });
            }
        }
    }
}