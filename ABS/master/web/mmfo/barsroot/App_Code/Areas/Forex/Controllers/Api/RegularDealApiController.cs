using BarsWeb.Areas.Forex.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Forex.Models;
using System;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web.Http;

namespace BarsWeb.Areas.Forex.Controllers.Api
{

    [AuthorizeApi]
    public class RegularDealApiController : ApiController
    {

        private readonly IRegularDealsRepository _repo;

        public RegularDealApiController(IRegularDealsRepository repo)
        {
            _repo = repo;
        }

        [HttpPost]
        public HttpResponseMessage Post(Agreement agreement)
        {
            OutDealTag res = null;

            res = _repo.SaveGhanges(agreement);
            return Request.CreateResponse(HttpStatusCode.OK, res);
           

            //return new HttpResponseMessage()
            //{
            //    Content = new StringContent(res.ToString(), Encoding.UTF8, "application/text"),
            //    StatusCode = HttpStatusCode.OK,
            //};                
            //}

        }       

    }

}
