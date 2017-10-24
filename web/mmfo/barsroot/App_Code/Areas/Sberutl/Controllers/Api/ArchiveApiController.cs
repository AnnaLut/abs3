using BarsWeb.Areas.Sberutl.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sberutl.Models;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using Kendo.Mvc.Extensions;
using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using System.Web.Http.ModelBinding;

namespace BarsWeb.Areas.Sberutl.Controllers.Api
{
    public class ArchiveApiController : ApiController
    {
        private readonly IArchiveRepository _repository;

        public ArchiveApiController(IArchiveRepository repository)
        {
            _repository = repository;
        }

        public HttpResponseMessage GetGridData([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request, Int32 param)
        {
            try
            {
                List<OBPC_SALARY_IMPORT_LOG> list = _repository.GetGridData(param);
                return Request.CreateResponse(HttpStatusCode.OK, list.ToDataSourceResult(request));
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }
    }
}
