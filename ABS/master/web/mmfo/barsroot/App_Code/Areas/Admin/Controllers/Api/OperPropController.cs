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
    public class OperPropController : ApiController
    {
        private readonly IOperRepository _repo;
        public OperPropController(IOperRepository repo)
        {
            _repo = repo;
        }

        [HttpPost]
        [POST("api/admin/operprop/updateprop")]
        public HttpResponseMessage UpdateProp(Prop item)
        {
            try
            {
                _repo.UpdateProps(item.id, item.tag, item.opt, item.used, item.ord, item.val);
                //return Request.CreateResponse(HttpStatusCode.OK);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new { Status = "Ok", Message = "Зміни збережено" });
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }
    }
}