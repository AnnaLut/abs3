using BarsWeb.Areas.PB1.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.PB1.Models;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using System.Web.Http.ModelBinding;

/// <summary>
/// Summary description for PB1ApiController
/// </summary>
public class AddRequisitesApiController : ApiController
{
    private readonly IAddRequisitesRepository _repository;
    public AddRequisitesApiController(IAddRequisitesRepository repository)
    {
        _repository = repository;
    }

    [HttpGet]
    public HttpResponseMessage GetBankDate()
    {
        try
        {
            string bankdate = _repository.GetBankDate();
            return Request.CreateResponse(HttpStatusCode.OK, bankdate);
        }
        catch (Exception ex)
        {
            return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
        }
    }

    [HttpGet]
    public HttpResponseMessage GetGridData([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request, string dc, string date)
    {
        try
        {
            var data = _repository.GetGridData(dc, date);
            return Request.CreateResponse(HttpStatusCode.OK, data.ToDataSourceResult(request));
        }
        catch (Exception ex)
        {
            return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
        }
    }

    [HttpGet]
    public HttpResponseMessage GetParams(string date)
    {
        try
        {
            var data = _repository.GetParams(date);
            return Request.CreateResponse(HttpStatusCode.OK, data);
        }
        catch (Exception ex)
        {
            return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
        }
    }

    [HttpGet]
    public HttpResponseMessage GetText(string name)
    {
        try
        {
            var data = _repository.GetText(name);
            return Request.CreateResponse(HttpStatusCode.OK, data);
        }
        catch (Exception ex)
        {
            return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
        }
    }

    [HttpPost]
    public HttpResponseMessage SaveData([FromBody] dynamic data)
    {
        try
        {
            List<RequisitesGrid> gridList = data.ToObject<List<RequisitesGrid>>();
            _repository.SaveData(gridList);
            return Request.CreateResponse(HttpStatusCode.OK, "");
        }
        catch (Exception ex)
        {
            return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
        }
    }

    [HttpGet]
    public HttpResponseMessage GetLoroBanks([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request)
    {
        try
        {
            var data = _repository.GetLoroBanks();
            return Request.CreateResponse(HttpStatusCode.OK, data.ToDataSourceResult(request));
        }
        catch (Exception ex)
        {
            return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
        }
    }

    [HttpGet]
    public HttpResponseMessage GetLoroParams([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request, decimal refer)
    {
        try
        {
            var data = _repository.GetLoroParams(refer);
            return Request.CreateResponse(HttpStatusCode.OK, data);
        }
        catch (Exception ex)
        {
            return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
        }
    }

    [HttpPost]
    public HttpResponseMessage SaveLoroData([FromBody] dynamic data)
    {
        try
        {
            List<LoroBank> gridList = data.ToObject<List<LoroBank>>();
            _repository.SaveLoroData(gridList);
            return Request.CreateResponse(HttpStatusCode.OK, "");
        }
        catch (Exception ex)
        {
            return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
        }
    }

    [HttpGet]
    public HttpResponseMessage DeleteLoroData(string okpo)
    {
        try
        {
            _repository.DeleteLoroData(okpo);
            return Request.CreateResponse(HttpStatusCode.OK, "OK");
        }
        catch (Exception ex)
        {
            return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
        }
    }

    [HttpGet]
    public HttpResponseMessage V_OKPO(string okpo)
    {
        try
        {
            string okp = _repository.V_OKPO(okpo);
            return Request.CreateResponse(HttpStatusCode.OK, okp);
        }
        catch (Exception ex)
        {
            return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
        }
    }

    [HttpPost]
    public HttpResponseMessage OK([FromBody] dynamic data)
    {
        try
        {
            LoroBank gridList = data["model"].ToObject<LoroBank>();
            decimal refer = Convert.ToDecimal(data["refer"]);
            _repository.OK(gridList, refer);
            return Request.CreateResponse(HttpStatusCode.OK, "");
        }
        catch (Exception ex)
        {
            return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
        }
    }
}