using AttributeRouting.Web.Http;
using BarsWeb.Areas.BpkW4.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.BpkW4.Infrastructure.Repository.DI.Implementation;
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
    public class AccentAccController : ApiController
    {
        readonly IAcceptAccRepository _repo;
        public AccentAccController(IAcceptAccRepository repository) { _repo = repository; }

        [HttpGet]
        [POST("/api/BpkW4/AccentAcc/DenyAcceprAccount")]
        public HttpResponseMessage DenyAcceprAccount(decimal acc)
        {
            try
            {
                _repo.DenyAcceptAcc(acc);
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