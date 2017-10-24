using BarsWeb.Areas.BaseRates.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.BaseRates.Models;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using Kendo.Mvc.Extensions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;

namespace BarsWeb.Areas.BaseRates.Controllers.Api
{
    public class BaseRatesApiController : ApiController
    {

        private readonly IBaseRatesRepository _repository;

        public BaseRatesApiController(IBaseRatesRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public HttpResponseMessage GetDDBranches()
        {
            try
            {
                List<DDBranches> list = _repository.GetDDBranches();
                return Request.CreateResponse(HttpStatusCode.OK, list);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetBRates([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request)
        {
            try
            {
                List<V_BRATES_KF> list = _repository.GetBrates().ToList();
                return Request.CreateResponse(HttpStatusCode.OK, list.ToDataSourceResult(request));
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetInterestRates([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request, string branch, bool inarchive, int? brtype=null, int? brid=null)
        {
            try
            {
                if (brtype != null && brid != null)
                {
                    List<TbBrates> list = _repository.GetInterestRates(branch, inarchive, brtype, brid);
                    return Request.CreateResponse(HttpStatusCode.OK, list.ToDataSourceResult(request));
                }
                else
                    return Request.CreateResponse(HttpStatusCode.OK, new List<TbBrates>());
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetBankDate()
        {
            try
            {
                string bdate = _repository.GetBankDate().ToString("dd/MM/yyyy");
                return Request.CreateResponse(HttpStatusCode.OK, bdate);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetKVs()
        {
            try
            {
                List<DDKVs> list = _repository.GetKVs();
                return Request.CreateResponse(HttpStatusCode.OK, list);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage AddInterestBrateToBD([FromBody] AddInterestBrateRequestMode request)
        {
            try
            {
                //List<TbBrates> gridList = request["list"].ToObject<List<TbBrates>>();
                //decimal br_id = request["br_id"];
                _repository.AddInterestBratesToBD(request.InterestList, request.br_id);
                return Request.CreateResponse(HttpStatusCode.OK, "Дані збережені");
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage EditInterestBrateToBD([FromBody] EditInterestBrateRequestModel request)
        {
            try
            {

                _repository.EditInterestBratesToBD(request);
                return Request.CreateResponse(HttpStatusCode.OK, "Дані збережені");
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }
        [HttpGet]
        public HttpResponseMessage GetRateOptions(string branch, int brid, int kv, string bdate, string action)
        {
            try
            { 
                List<RatesOptions> list = new List<RatesOptions>();
                if (action == "update")
                    list = _repository.GetRateOptions(branch, brid, kv, bdate);
                return Request.CreateResponse(HttpStatusCode.OK, list);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage DeleteBrate([FromBody] dynamic request)
        {
            try
            {
                TbBrates model = request["model"].ToObject<TbBrates>();
                decimal br_id = request["br_id"];
                _repository.DeleteBrate(model, br_id);
                return Request.CreateResponse(HttpStatusCode.OK, "Дані виделені");
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetRatesTypes()
        {
            try
            {
                List<DDKVs> list = _repository.GetRatesTypes();
                return Request.CreateResponse(HttpStatusCode.OK, list);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage AddBaseRateToBD([FromBody] dynamic request)
        {
            try
            {
                V_BRATES_KF model = request["model"].ToObject<V_BRATES_KF>();
                _repository.AddBaseRateToBD(model);
                return Request.CreateResponse(HttpStatusCode.OK, "Дані виделені");
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }
    }
}