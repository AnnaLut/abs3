using Areas.Sep.Models;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Areas.Sep.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;

namespace BarsWeb.Areas.Sep.Controllers.Api
{
    [AuthorizeApi]
    public class bpRulesController : ApiController
    {
        private readonly IBpRulesRepository _repo;
        public bpRulesController()
	    {
            _repo = new BpRulesRepository();
	    }

        public HttpResponseMessage Get()
        {
            var rules = _repo.GetBpRules();
            return Request.CreateResponse(HttpStatusCode.OK, new { Data = rules });
        }

        public HttpResponseMessage Put(SepRule item)
        {
            if (_repo.UpdateBpRules(item))
            {
                return Request.CreateResponse(HttpStatusCode.OK);
            }

            return Request.CreateResponse(HttpStatusCode.BadRequest);
        }


        public HttpResponseMessage Post(SepRule item)
        {
            if (_repo.CreateBpRules(item))
            {
                return Request.CreateResponse(HttpStatusCode.OK);
            }

            return Request.CreateResponse(HttpStatusCode.BadRequest);
        }
        public HttpResponseMessage Delete(SepRule item)
        {
            if (_repo.DeleteBpRules(item))
            {
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            return Request.CreateResponse(HttpStatusCode.BadRequest);
        }
    }
}