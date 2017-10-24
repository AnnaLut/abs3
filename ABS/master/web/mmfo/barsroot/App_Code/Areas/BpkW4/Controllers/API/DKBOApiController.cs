using BarsWeb.Areas.BpkW4.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.BpkW4.Models;
using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace BarsWeb.Areas.BpkW4.Controllers.Api
{
    public class DKBOApiController : ApiController
    {

        private readonly ICheckdkboRepository _repo;

        public DKBOApiController(ICheckdkboRepository repo)
        {
            _repo = repo;
        }

        public HttpResponseMessage Post(List<AddToDKBO> addToDKBO)
        {
            try
            {
                CustomerFilter custF = _repo.CreateDKBO(addToDKBO);
                return Request.CreateResponse(HttpStatusCode.OK, new { Message = "Зміни збережено", DealId = custF.DealId, CustomerRnk = custF.CustomerRnk });
            }
            catch(Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, new { Message = ex.Message });
            }

        }
    }
}
