using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Mbdk.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Mbdk.Models;

namespace BarsWeb.Areas.Mbdk.Controllers.Api
{
    [AuthorizeApi]
    public class SaveDealController : ApiController
    {
        private readonly IDealRepository _deal;

        public SaveDealController(IDealRepository deal)
        {
            _deal = deal;
        }
        
        [HttpPost]
        public HttpResponseMessage CreateDeal(SaveDealParam megamodel)
        {
            try
            {
                return Request.CreateResponse(HttpStatusCode.OK, _deal.SaveDeal(megamodel));
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }
    }
}
