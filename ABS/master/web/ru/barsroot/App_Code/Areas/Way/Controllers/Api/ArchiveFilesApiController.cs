using BarsWeb.Areas.Way.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Way.Models;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using System;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;
using System.Web.Http;
using System.Web.Http.ModelBinding;

namespace BarsWeb.Areas.Way.Controllers.Api
{
    [AuthorizeApi]
    public class ArchiveFilesApiController: ApiController {

        private readonly IWayRepository _repository;
        public ArchiveFilesApiController(IWayRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public HttpResponseMessage Get(
           [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request )
        {
            try
            {
                var files = _repository.ArchFiles().ToList();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = files.ToDataSourceResult(request), Message = "Ok" });
                return response;
            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = 0, Message = exception.Message });
            }
        }
    }    
}