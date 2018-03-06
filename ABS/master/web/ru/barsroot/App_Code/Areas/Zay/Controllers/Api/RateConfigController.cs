using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Zay.Models;

namespace BarsWeb.Areas.Zay.Controllers.Api
{
    [AjaxAuthorize]
    public class RateConfigController : ApiController
    {
        public RateConfigController()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        [HttpPost]
        public HttpResponseMessage Post(RateConfig item)
        {
            try
            {
                //var data = _finRepo.BalanceViewData(date, rowType, branch).ToList();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK);
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Msg = ex.Message });
            }
        }
    }
}