using BarsWeb.Controllers;
using System;
using BarsWeb.Areas.Swift.Infrastructure.DI.Abstract;
using System.Web.Mvc;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.Swift.Infrastructure.DI.Implementation;
using System.Linq;
using BarsWeb.Models;
using System.Collections.Generic;
using Kendo.Mvc.UI;
using Kendo.Mvc.Extensions;
using BarsWeb.Areas.Forex.Infrastructure.DI.Abstract;
using Kendo.Mvc;
using Areas.Swift.Models;

namespace BarsWeb.Areas.Swift.Controllers
{
    [AuthorizeUser]
    public class GPIDocsReviewController : ApplicationController
    {

        readonly ISwiftRepository _repo;
        private readonly IRegularDealsRepository _repoForBankDate;

        public GPIDocsReviewController(ISwiftRepository repo, IRegularDealsRepository repoForBankDate)
        {
            _repo = repo;
            _repoForBankDate = repoForBankDate;
        }

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GetMainGridItems([DataSourceRequest]DataSourceRequest request, bool isFirstLoad)
        {
            try
            {
                if (isFirstLoad)
                {
                    DateTime bankDate = _repoForBankDate.GetBankDate();
                    TimeSpan fiveDaysSpan = new TimeSpan(5, 0, 0, 0);
                    request.Filters.Add(new FilterDescriptor("VDate", FilterOperator.IsGreaterThanOrEqualTo, bankDate.Subtract(fiveDaysSpan)));
                }

                if (request.Filters != null && request.Filters.Count > 0)
                {
                    var transformedFilters = request.Filters.Select(TransformFilterDescriptors).ToList();
                    request.Filters = transformedFilters;
                }

                //var dataList = _repo.GetMTGridItems();

                Core.Models.DataSourceRequest coreRequest = new Core.Models.DataSourceRequest();
                coreRequest.Page = request.Page;
                coreRequest.PageSize = request.PageSize;
                coreRequest.Sorts = request.Sorts;
                coreRequest.Filters = request.Filters;
                coreRequest.Aggregates = request.Aggregates;
                coreRequest.Groups = request.Groups;

                var sql = SqlCreatorGPIMessages.GetGPIMessagesList();
                var dataList = _repo.GetMTGridItemsFast<SwiftGPIStatuses>(coreRequest, sql);
                var dataCount = _repo.CountGlobal(coreRequest, sql);
                return Json(new { Data = dataList, Total = dataCount }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new DataSourceResult { Errors = "Помилка у методі GetMainGridItems: " + ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult GetMT199GridItems([DataSourceRequest]DataSourceRequest request, string curUETR)
        {
            JsonResponse result = new JsonResponse(JsonResponseStatus.Ok);
            DataSourceResult dataSourceResult = null;
                try
                {
                if (request.Filters != null && request.Filters.Count > 0)
                {
                    var transformedFilters = request.Filters.Select(TransformFilterDescriptors).ToList();
                    request.Filters = transformedFilters;
                }

                var dataList = _repo.GetMT199GridItems(curUETR);
                    dataSourceResult = dataList.ToDataSourceResult(request);
                }
                catch (Exception ex)
                {
                    dataSourceResult = new DataSourceResult
                    {
                        Errors = "Помилка у методі GetMT199GridItems: " + ex.Message
                    };
                }
            return Json(dataSourceResult, JsonRequestBehavior.AllowGet);
        }

        //Can be used to truncate time from datetime values so that if we compare one datetime equally to another we get result based only on date
        //Can be passed to basic helper classes for Kendo files ans transformations
        public IFilterDescriptor TransformFilterDescriptors(IFilterDescriptor filter)
        {
            if (filter is CompositeFilterDescriptor)
            {
                var compositeFilterDescriptor = filter as CompositeFilterDescriptor;
                var transformedCompositeFilterDescriptor = new CompositeFilterDescriptor { LogicalOperator = compositeFilterDescriptor.LogicalOperator };
                foreach (var filterDescriptor in compositeFilterDescriptor.FilterDescriptors)
                {
                    transformedCompositeFilterDescriptor.FilterDescriptors.Add(TransformFilterDescriptors(filterDescriptor));
                }
                return transformedCompositeFilterDescriptor;
            }
            if (filter is FilterDescriptor)
            {
                var filterDescriptor = filter as FilterDescriptor;
                if (filterDescriptor.Value is DateTime)
                {
                    var value = (DateTime)filterDescriptor.Value;
                    switch (filterDescriptor.Operator)
                    {
                        case FilterOperator.IsEqualTo:
                            //convert the "is equal to <date><time>" filter to a "is greater than or equal to <date> 00:00:00" AND "is less than or equal to <date> 23:59:59"
                            var isEqualCompositeFilterDescriptor = new CompositeFilterDescriptor { LogicalOperator = FilterCompositionLogicalOperator.And };
                            isEqualCompositeFilterDescriptor.FilterDescriptors.Add(new FilterDescriptor(filterDescriptor.Member,
                                FilterOperator.IsGreaterThanOrEqualTo, new DateTime(value.Year, value.Month, value.Day, 0, 0, 0)));
                            isEqualCompositeFilterDescriptor.FilterDescriptors.Add(new FilterDescriptor(filterDescriptor.Member,
                                FilterOperator.IsLessThanOrEqualTo, new DateTime(value.Year, value.Month, value.Day, 23, 59, 59)));
                            return isEqualCompositeFilterDescriptor;

                        case FilterOperator.IsNotEqualTo:
                            //convert the "is not equal to <date><time>" filter to a "is less than <date> 00:00:00" OR "is greater than <date> 23:59:59"
                            var notEqualCompositeFilterDescriptor = new CompositeFilterDescriptor { LogicalOperator = FilterCompositionLogicalOperator.Or };
                            notEqualCompositeFilterDescriptor.FilterDescriptors.Add(new FilterDescriptor(filterDescriptor.Member,
                                FilterOperator.IsLessThan, new DateTime(value.Year, value.Month, value.Day, 0, 0, 0)));
                            notEqualCompositeFilterDescriptor.FilterDescriptors.Add(new FilterDescriptor(filterDescriptor.Member,
                                FilterOperator.IsGreaterThan, new DateTime(value.Year, value.Month, value.Day, 23, 59, 59)));
                            return notEqualCompositeFilterDescriptor;

                        case FilterOperator.IsGreaterThanOrEqualTo:
                            //convert the "is greater than or equal to <date><time>" filter to a "is greater than or equal to <date> 00:00:00"
                            filterDescriptor.Value = new DateTime(value.Year, value.Month, value.Day, 0, 0, 0);
                            return filterDescriptor;

                        case FilterOperator.IsGreaterThan:
                            //convert the "is greater than <date><time>" filter to a "is greater than <date> 23:59:59"
                            filterDescriptor.Value = new DateTime(value.Year, value.Month, value.Day, 23, 59, 59);
                            return filterDescriptor;

                        case FilterOperator.IsLessThanOrEqualTo:
                            //convert the "is less than or equal to <date><time>" filter to a "is less than or equal to <date> 23:59:59"
                            filterDescriptor.Value = new DateTime(value.Year, value.Month, value.Day, 23, 59, 59);
                            return filterDescriptor;

                        case FilterOperator.IsLessThan:
                            //convert the "is less than <date><time>" filter to a "is less than <date> 00:00:00"
                            filterDescriptor.Value = new DateTime(value.Year, value.Month, value.Day, 0, 0, 0);
                            return filterDescriptor;

                        default:
                            throw new Exception(string.Format("Filter operator '{0}' is not supported for DateTime member '{1}'", filterDescriptor.Operator, filterDescriptor.Member));
                    }
                }
            }
            return filter;
        }
    }
}
