using System.Collections.Generic;
using System.Web.Mvc;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Admin.Models;
using BarsWeb.Controllers;
using Kendo.Mvc.UI;
using BarsWeb.Areas.Admin.Models.ListSet;

namespace BarsWeb.Areas.Admin.Controllers
{
    [CheckAccessPage]
    [Authorize]
    public class ListSetController : ApplicationController
    {
        private readonly IListSetRepository _repo;
        public ListSetController(IListSetRepository repo)
        {
            _repo = repo;
        }

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GetListSetData([DataSourceRequest] DataSourceRequest request)
        {
            IEnumerable<LIST_SET> data = _repo.ListSetData(request);
            var dataCount = _repo.CountListSetData(request);
            return Json(new { Data = data, Total = dataCount }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetListfuncsetData([DataSourceRequest] DataSourceRequest request, decimal setId)
        {
            IEnumerable<LIST_FUNCSET> data = _repo.ListFuncsetData(request, setId);
            var dataCount = _repo.CountListFuncsetData(request, setId);
            return Json(new {Data = data, Total = dataCount}, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetOperlistHandbookData([DataSourceRequest] DataSourceRequest request, decimal setId)
        {
            IEnumerable<OPERLIST_Handbook> data = _repo.OperlistHandbook(request, setId);
            var dataCount = _repo.CountOperlistHandbook(request, setId);
            return Json(new {Data = data, Total = dataCount}, JsonRequestBehavior.AllowGet);
        }
    }
}