using BarsWeb.Controllers;
using System;
using BarsWeb.Areas.Swift.Infrastructure.DI.Abstract;
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
using System.Web;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using BarsWeb.Areas.Forex.Infrastructure.DI.Abstract;
using AttributeRouting.Web.Http;
using BarsWeb;

namespace BarsWeb.Areas.Swift.Controllers
{
    //[AuthorizeApi]
    public class GPIDocsReviewApiController : ApiController
    {

        readonly ISwiftRepository _repo;
        private readonly IRegularDealsRepository _repoForBankDate;
        public GPIDocsReviewApiController(ISwiftRepository repo, IRegularDealsRepository repoForBankDate)
        {
            _repo = repo;
            _repoForBankDate = repoForBankDate;
        }

        [HttpGet]
        public HttpResponseMessage GetMainGridItems([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, bool isFirstLoad)
        {
            try
            {
                if (isFirstLoad)
                {
                    DateTime bankDate = _repoForBankDate.GetBankDate();
                    TimeSpan fiveDaysSpan = new TimeSpan(5, 0, 0, 0);
                    request.Filters.Add(new Kendo.Mvc.FilterDescriptor("DateIn", Kendo.Mvc.FilterOperator.IsGreaterThanOrEqualTo, bankDate.Subtract(fiveDaysSpan)));
                }

                BarsSql sql = SqlCreatorGPIMessages.GetGPIMessagesList();
                IEnumerable<SwiftGPIStatuses> dataList = _repo.SearchGlobal<SwiftGPIStatuses>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                //here we can filter request if no filter is set or if we receive parameter that page is loaded for the first time
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = dataList, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        public HttpResponseMessage GetMT199GridItems([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string curUETR)
        {
            try
            {
                BarsSql sql = SqlCreatorGPIMessages.GetGPIMessages199List(curUETR);
                IEnumerable<SwiftGPIStatusesMT199> dataList = _repo.SearchGlobal<SwiftGPIStatusesMT199>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = dataList, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
    }
}
