﻿using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;
using System.Web.Http.ModelBinding;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Zay.Controllers.Api.ZaySale
{
    //[AuthorizeApi]
    public class DealerSaleController : ApiController
    {
        private readonly ICurrencySightRepository _repository;
        public DealerSaleController(ICurrencySightRepository repository)
        {
            _repository = repository;
        }
        public HttpResponseMessage Get(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request,
            decimal dk, decimal? sos, decimal? visa)
        {
            try
            {
                var data = _repository.DealerSaleData(dk, sos, visa).ToList();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    data.ToDataSourceResult(request));
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }

        public HttpResponseMessage GetDdlValues(decimal dk, decimal? sos, decimal? visa, string field)
        {
            try
            {
                var data = _repository.DealerFieldValues(dk, sos, visa, field).ToList();
                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }

    }
}