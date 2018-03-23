using AttributeRouting.Web.Http;
using BarsWeb.Areas.BpkW4.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.BpkW4.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Areas.BpkW4.Models;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using System.Web.Http.ModelBinding;

namespace BarsWeb.Areas.BpkW4.Controllers.Api
{
    public class InstantCardApiController: ApiController
    {
        readonly IInstantCardRepository _repo;

        public InstantCardApiController(IInstantCardRepository repository) { _repo = repository; }

        [HttpPost]
        [POST("/api/BpkW4/InstantCardApi/createinstantcards")]
        public HttpResponseMessage CreateInstantCards(InstantCard obj)
        {
            try
            {
                BarsSql sql = SqlCreatorBPK.CreateInstantCardsM(obj);
                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

                return Request.CreateResponse(HttpStatusCode.OK, new { });
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpGet]
        [GET("/api/BpkW4/InstantCardApi/cardtype")]
        public HttpResponseMessage CardType([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string product_code)
        {
            try
            {
                IEnumerable<CardTypeResult> data = _repo.ExecuteStoreQuery<CardTypeResult>(SqlCreatorBPK.CardType(product_code));
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, new { Data = data });
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpGet]
        [GET("/api/BpkW4/InstantCardApi/product")]
        public HttpResponseMessage Product()
        {
            try
            {
                IEnumerable<ProductResult> data = _repo.ExecuteStoreQuery<ProductResult>(SqlCreatorBPK.Product());
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, new { Data = data});
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpGet]
        [GET("/api/BpkW4/InstantCardApi/batchesmmsb")]
        public HttpResponseMessage BatchesMmsb([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                BarsSql sql = SqlCreatorBPK.BatchesMmsb();
                IEnumerable<BatchesMmsbResult> data = _repo.SearchGlobal<BatchesMmsbResult>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

    }
}

