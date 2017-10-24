using BarsWeb.Areas.PB1.Infrastructure.Repository.DI.Abstract;
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
public class FormingReportApiController : ApiController
{
    private readonly IFormingReportRepository _repository;
    public FormingReportApiController(IFormingReportRepository repository)
    {
        _repository = repository;
    }

    [HttpGet]
    public HttpResponseMessage GetDropDownData()
    {
        try
        {
            var list = _repository.GetDropDownData();
            return Request.CreateResponse(HttpStatusCode.OK, list);
        }
        catch (Exception ex)
        {
            return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
        }
    }

    [HttpGet]
    public HttpResponseMessage GetGridData([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request, string D, string KOD_B, bool data_do)
    {
        try
        {
            var list = _repository.GetGridData(D, KOD_B, data_do);
            return Request.CreateResponse(HttpStatusCode.OK, list.ToDataSourceResult(request));
        }
        catch (Exception ex)
        {
            return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
        }
    }

    [HttpGet]
    public HttpResponseMessage GetParams()
    {
        try
        {
            var model = _repository.GetParams();
            return Request.CreateResponse(HttpStatusCode.OK, model);
        }
        catch (Exception ex)
        {
            return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
        }
    }

    [HttpGet]
    public HttpResponseMessage CreateFileForPrint()
    {
        try
        {
            var model = _repository.CreateFileForPrint();
            return Request.CreateResponse(HttpStatusCode.OK, model);
        }
        catch (Exception ex)
        {
            return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
        }
    }
}