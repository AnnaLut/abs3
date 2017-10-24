using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using BarsWeb.Infrastructure.Repository.DI.Abstract;
using AttributeRouting.Web.Http;
using System;

namespace BarsWeb.Areas.Kernel.Controllers.Api
{
    [AuthorizeApi]
    public class HeaderBranchesController : ApiController
    {
        private IHomeRepository _homeRpository;
        public HeaderBranchesController(IHomeRepository homeRpository)
        {
            _homeRpository = homeRpository;
        }

        [HttpGet]
        [GET("api/kernel/headerbranches/get")]
        public HttpResponseMessage Get()
        {
            try
            {
                var data = _homeRpository.CurrentBranch();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, data);
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }

        [HttpGet]
        [GET("api/kernel/headerbranches/get")]
        public HttpResponseMessage Get(string id)
        {
            try
            {
                var data = _homeRpository.UsersBranches(id);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, data);
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage Post(BranchPostRequest item)
        {
            try
            {
                _homeRpository.ChangeBranch(item.branch);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK);
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }
    }
}

public class BranchPostRequest
{
    public string branch { get; set; }
}