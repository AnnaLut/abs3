using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;
using Kendo.Mvc.Extensions;
using System.Web.Http.ModelBinding;
using Kendo.Mvc.UI;
using AttributeRouting.Web.Http;

namespace BarsWeb.Areas.Zay.Controllers.Api
{
    [AuthorizeApi]
    public class AverageEarningsController : ApiController
    {
        private readonly ICurrencyOperations _operation;
        public AverageEarningsController(ICurrencyOperations operation)
        {
            _operation = operation;
        }
        [HttpGet]
        public HttpResponseMessage Get([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                var data = _operation.GetCurEarning();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, data.ToDataSourceResult(request));
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }
        [HttpGet]
        public HttpResponseMessage GetSplitSum([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, decimal nRef, decimal AMNT)
        {
            try
            {
                _Spliter _data = new _Spliter();
                _data.nRef = nRef;
                _data.AMNT = AMNT;
                var data = _operation.GetSplitSum(_data);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, data.ToDataSourceResult(request));
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }
        [HttpPost]
        [POST("/api/zay/AverageEarnings/SaveSettings")]
        public HttpResponseMessage SaveSettings([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, decimal? ID, decimal nREF, decimal SALE_TP, decimal AMNT)
        {
            try
            {
                V_ZAY_SPLIT_AMOUNT _data = new V_ZAY_SPLIT_AMOUNT();
                _data.ID = ID;
                _data.TP_ID = SALE_TP;
                _data.AMNT = AMNT; 
                _operation.SaveSplitSettings(_data, nREF);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK);
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }
        [HttpPost]
        public HttpResponseMessage DeleteSetting([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, decimal ID)
        {
            try
            {
                _operation.DeleteSetting(ID);
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