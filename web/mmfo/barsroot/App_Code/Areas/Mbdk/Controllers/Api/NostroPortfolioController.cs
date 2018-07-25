using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Mbdk.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Mbdk.Models;
using System.Web.Script.Serialization;
using Kendo.Mvc.UI;
using Kendo.Mvc.Extensions;
using System.Web.Http.ModelBinding;
using System.Collections.Generic;

namespace BarsWeb.Areas.Mbdk.Controllers.Api
{
    public class NostroPortfolioController : ApiController
    {
        private readonly INostroRepository _nostro;

        public NostroPortfolioController(INostroRepository nostro)
        {
            _nostro = nostro;
        }

        [HttpPost]
        public HttpResponseMessage InsertNostro([FromBody]InsertNostroPortfolioRow row)
        {
            try
            {
                _nostro.InsertNostro(row);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage UpdateNostro([FromBody]UpdateNostroPortfolioRow row)
        {
            try
            {
                _nostro.UpdateNostro(row);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage DeleteNostro([FromBody]string nd)
        {
            try
            {
                _nostro.DeleteNostro(Convert.ToDecimal(nd));
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage SetMasIni([FromBody]string nd)
        {
            try
            {
                _nostro.PulSetMasIni(nd);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }
        [HttpGet]
        public HttpResponseMessage GetNostroList([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                List<NostroPortfolioRow> _data = _nostro.GetNostroList();
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = _data, Total = _data.Count });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetDataList()
        {
            try
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = _nostro.GetDataList() });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }
    }
}
