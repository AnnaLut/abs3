using System.Linq;
using System.Web.Http;
using System.Web.Mvc;
using BarsWeb.Areas.Kernel.Infrastructure.Repository.DI.Abstract;
using Areas.Kernel.Models;
using BarsWeb.Controllers;
using Kendo.Mvc.UI;
using Kendo.Mvc.Extensions;

namespace BarsWeb.Areas.Kernel.Controllers
{
    [System.Web.Mvc.Authorize]
    public class KrnModuleController : ApplicationController
    {
        private readonly IKrnModuleRepository _repoModule;
        private readonly IKrnModuleVersionsRepository _repoModuleVrs;
        public KrnModuleController(IKrnModuleRepository repoModule, IKrnModuleVersionsRepository repoModuleVrs)
        {
            _repoModule = repoModule;
            _repoModuleVrs = repoModuleVrs;
        }
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult GetKrnModuleList([DataSourceRequest] DataSourceRequest request)
        {
            IQueryable<KRN_MODULE_VRS_HIST> list = _repoModule.GetKrnModuleList();
            return Json(list.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetKrnModuleVersionList([DataSourceRequest] DataSourceRequest request)
        {
            IQueryable<KRN_MODULE_VERSIONS> list = _repoModuleVrs.GetKrnModuleVersionsList();
            return Json(list.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }
    }

}
