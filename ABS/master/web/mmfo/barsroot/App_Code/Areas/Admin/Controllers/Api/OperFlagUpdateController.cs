using System.Web.Http;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using Kendo.Mvc.UI;
using System.Web.Http.ModelBinding;
using BarsWeb.Areas.Admin.Models.Oper;
using System.Net.Http;
using System.Net;
using AttributeRouting.Web.Http;
using System;
using BarsWeb.Areas.Admin.Models;

namespace BarsWeb.Areas.Admin.Controllers.Api
{
    public class OperFlagUpdateController : ApiController
    {
        private readonly IOperRepository _repo;
        public OperFlagUpdateController(IOperRepository repo)
        {
            _repo = repo;
        }

        [HttpPost]
        [POST("api/admin/operflagupdate/flagvalueupdate")]
        public HttpResponseMessage FlagValueUpdate(FlagValue item)
        {
            try
            {
                _repo.UpdateFlagValue(item.tt, item.code, item.value);
                const string message = "Задано нове значення для флага";
                return Request.CreateResponse(HttpStatusCode.OK, message);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }

    }
}