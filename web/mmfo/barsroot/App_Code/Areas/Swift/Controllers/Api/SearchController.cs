using Areas.Swift.Models;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.Swift.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Swift.Infrastructure.DI.Implementation;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;

namespace BarsWeb.Areas.Swift.Controllers.Api
{
    public class SearchController : ApiController
    {
        readonly ISwiftRepository _repo;

        public SearchController(ISwiftRepository repo) { _repo = repo; }

        [HttpGet]
        public HttpResponseMessage SearchMain([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string text, string d1, string d2)
        {
            try
            {
                DateTime dt1 = DateTime.ParseExact(d1, "dd.MM.yyyy", CultureInfo.InvariantCulture);
                DateTime dt2 = DateTime.ParseExact(d2, "dd.MM.yyyy", CultureInfo.InvariantCulture);

                BarsSql sql = SqlCreatorSearch.SearchMain(text, dt1, dt2);
                IEnumerable<SearchMsg> data = _repo.SearchGlobal<SearchMsg>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
    }
}
