using BarsWeb.Areas.ValuePapers.Infrastructure.DI.Abstract;
using BarsWeb.Areas.ValuePapers.Models;
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

namespace BarsWeb.Areas.ValuePapers.Controllers.Api
{
    public class PayTicketApiController : ApiController
    {
        private readonly IPayTicketRepository _repository;

        public PayTicketApiController(IPayTicketRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public HttpResponseMessage GetModel(string strPar01, string strPar02, decimal? nGrp, decimal? nMode)
        {
            try
            {
                var data = _repository.GetModel(strPar01, strPar02, nGrp, nMode);
                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetGridData([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request, string strPar01 = null, string strPar02 = null, decimal? nGrp = null, decimal? nMode = null, decimal? p_nRyn = null, decimal? p_nPf = null)
        {
            List<PayTicketGrid> data = new List<PayTicketGrid>();
            try
            {
                if (p_nPf != null)
                {
                    data = _repository.GetGridData(strPar01, strPar02, nGrp, nMode, p_nRyn, p_nPf);
                    return Request.CreateResponse(HttpStatusCode.OK, data.ToDataSourceResult(request));
                }
                else
                    return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage SaveCP(int p_nTipD, int p_cb_Zo, int p_nGrp, int p_nID, int p_nRYN, string p_nVidd, decimal p_SUMK)
        {
            try
            {
                var data = _repository.SaveCP(p_nTipD, p_cb_Zo, p_nGrp, p_nID, p_nRYN, p_nVidd, p_SUMK);
                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetSumiAll(string strPar01, int kv, int pf, int emi, string vidd, int dox, int ryn)
        {
            try
            {
                var data = _repository.GetSumiAll(strPar01, kv, pf, emi, vidd, dox, ryn);
                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetModel(int p_ID, decimal? nGrp)
        {
            try
            {
                var data = _repository.GetModel(p_ID, nGrp);
                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        public HttpResponseMessage GetdataListFor_cbm_RYN(int kv)
        {
            try
            {
                var data = _repository.dataListFor_cbm_RYN(kv);
                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetGridData([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request, int p_ID, int nRYN, int nGRP)
        {
            try
            {
                var data = _repository.GetGridData(p_ID, nRYN, nGRP);
                return Request.CreateResponse(HttpStatusCode.OK, data.ToDataSourceResult(request));
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetSumTicket(string strPar01 = null, string strPar02 = null, decimal? nGrp = null, decimal? nMode = null, decimal? p_nRyn = null, decimal? p_nPf = null)
        {
            try
            {
                var sum_ticket = new SumTicket();
                var data = _repository.GetGridData(strPar01, strPar02, nGrp, nMode, p_nRyn, p_nPf);
                var list = data.AsQueryable();
                sum_ticket.SUMN = list.Sum(s => s.p_OSTR);
                sum_ticket.SUMN2 = list.Sum(s => s.p_OSTR2) + list.Sum(s => s.p_OSTR3);
                sum_ticket.SUMNK = sum_ticket.SUMN + sum_ticket.SUMN2;
                return Request.CreateResponse(HttpStatusCode.OK, sum_ticket);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }
    }
}
