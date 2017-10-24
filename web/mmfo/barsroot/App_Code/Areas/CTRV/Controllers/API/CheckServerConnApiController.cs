using Bars.Doc;
using BarsWeb.Areas.CTRV.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using Kendo.Mvc.Extensions;
using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;

namespace BarsWeb.Areas.CTRV.Controllers.Api
{
    public class CheckServerConnApiController : ApiController
    {

        private readonly ICheckServerConnRepository _repository;

        public CheckServerConnApiController(ICheckServerConnRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public HttpResponseMessage GetStatus()
        {
            try
            {
                string status = _repository.GetStatus();
                return Request.CreateResponse(HttpStatusCode.OK, status);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }
    }
}