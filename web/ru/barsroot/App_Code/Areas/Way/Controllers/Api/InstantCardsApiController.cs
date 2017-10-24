using AttributeRouting.Web.Http;
using BarsWeb.Areas.Way.Infrastructure.DI.Abstract;
using BarsWeb.Areas.DptAdm.Models;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using Kendo.Mvc.Extensions;
using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;

/// <summary>
/// Summary description for InstantCardsController
/// </summary>
/// 
namespace BarsWeb.Areas.Way.Controllers.Api
{
    public class InstantCardsApiController : ApiController
    {
        private readonly IInstantCardsRepository _repository;

        public InstantCardsApiController(IInstantCardsRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public HttpResponseMessage GetProduct()
        {
            var fileList = _repository.GetProduct<Product>();
            return Request.CreateResponse(HttpStatusCode.OK, fileList);
        }

        [HttpGet]
        public HttpResponseMessage GetCardType(string code)
        {
            var fileList = _repository.GetCardType<CardType>(code);
            return Request.CreateResponse(HttpStatusCode.OK, fileList);
        }
        [HttpGet]
        public HttpResponseMessage GetKV(string sProductId)
        {
            var fileList = _repository.GetKV(sProductId);
            return Request.CreateResponse(HttpStatusCode.OK, fileList);
        }
        [HttpGet]
        public HttpResponseMessage GetNB(string sProductId)
        {
            var fileList = _repository.GetNB(sProductId);
            return Request.CreateResponse(HttpStatusCode.OK, fileList);
        }
        [HttpGet]
        public HttpResponseMessage GetBranch()
        {
            var fileList = _repository.GetBranch();
            return Request.CreateResponse(HttpStatusCode.OK, fileList);
        }

        [HttpPost]
        public HttpResponseMessage GetInstantCards([FromBody] dynamic request) {
            _repository.GetInstantCards(request.CARD_TYPE, request.CARD_AMOUNT);
            return Request.CreateResponse(HttpStatusCode.OK);
        }
        
    }
}