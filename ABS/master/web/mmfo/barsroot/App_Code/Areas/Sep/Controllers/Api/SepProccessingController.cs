using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;

namespace BarsWeb.Areas.Sep.Controllers.Api 
{
    public class SepProccessingController : ApiController
    {
        private readonly ISepTechAccountsRepository _repo;
        public SepProccessingController(ISepTechAccountsRepository repo)
        {
            _repo = repo;
        }

        [HttpGet]
        public HttpResponseMessage Get(decimal rec)
        {
            try
            {
                var data = _repo.GetRefByRec(rec);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = data, Status = 1 });
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = ex.Message, Status = 0 });
            }
        }
    }
}