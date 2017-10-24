using BarsWeb.Areas.Forex.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Forex.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;

namespace BarsWeb.Areas.Forex.Controllers.Api
{

    [AuthorizeApi]
    public class ChangeFXSDealApiController : ApiController
    {
        private readonly IRegularDealsRepository _repo;

        public ChangeFXSDealApiController(IRegularDealsRepository repo)
        {
            _repo = repo;
        }

        [HttpPost]
        public HttpResponseMessage Post(FXUPD fxupd)
        {
            _repo.UpdateChanges(fxupd);
            return Request.CreateResponse(HttpStatusCode.OK); 
       }
    }
}
        