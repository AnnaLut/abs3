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
                    request.Filters.Add(new Kendo.Mvc.FilterDescriptor("DateIn", Kendo.Mvc.FilterOperator.IsGreaterThanOrEqualTo, bankDate.Subtract(fiveDaysSpan)));
                }

                var dataList = _repo.GetMTGridItems();
                return Json(dataList.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new DataSourceResult { Errors = "Помилка у методі GetMainGridItems: " + ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult GetMT199GridItems([DataSourceRequest]DataSourceRequest request, string curUETR)
        {
            JsonResponse result = new JsonResponse(JsonResponseStatus.Ok);
            if (String.IsNullOrEmpty(curUETR))
            {
                return Json(new DataSourceResult { Errors = "Помилка у методі GetMT199GridItems: значення UETR не може бути порожнім" }, JsonRequestBehavior.AllowGet);
            }
            else
                try
                {
                    var dataList = _repo.GetMT199GridItems(curUETR);
                    return Json(dataList.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
                }
                catch (Exception ex)
                {
                    return Json(new DataSourceResult { Errors = "Помилка у методі GetMT199GridItems: " + ex.Message }, JsonRequestBehavior.AllowGet);
                }
        }
    }
}
