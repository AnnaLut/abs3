using Bars.Areas.Sep.Models;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using Kendo.Mvc.Extensions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using System.Web.Http.ModelBinding;

namespace BarsWeb.Areas.Sep.Controllers.Api
{
    [AuthorizeApi]
    public class Sep3720ApiController : ApiController
    {
        private readonly ISep3720Repository _repo;
        public Sep3720ApiController(ISep3720Repository repository)
        {
            _repo = repository;
        }

        [HttpGet]
        public HttpResponseMessage GetSep3720RegisterList([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request, Int32 rg_tp, String rg_dt_from, String rg_dt_to)
        {
            try
            {
                List<Sep3720Register> list = _repo.GetSep3720RegisterList(rg_tp, rg_dt_from, rg_dt_to);
                return Request.CreateResponse(HttpStatusCode.OK, list.ToDataSourceResult(request));
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message + (ex.InnerException == null ? "" : ". " + ex.InnerException.Message));
            }
        }
    }
}