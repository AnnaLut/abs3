using AttributeRouting.Web.Http;
using BarsWeb.Areas.BpkW4.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.BpkW4.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Areas.BpkW4.Models;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;

namespace BarsWeb.Areas.BpkW4.Controllers.Api
{
    public class AcceptAccController : ApiController
    {
        readonly IAcceptAccRepository _repo;
        public AcceptAccController(IAcceptAccRepository repository) { _repo = repository; }

        [HttpPost]
        [POST("/api/BpkW4/AcceptAcc/DenyAcceprAccount")]
        public HttpResponseMessage DenyAcceprAccount(ReserveAccsKeys keys)
        {
            try
            {
                _repo.DenyAcceptAcc(keys);
                return Request.CreateResponse(HttpStatusCode.OK, new { });
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }
    }
}