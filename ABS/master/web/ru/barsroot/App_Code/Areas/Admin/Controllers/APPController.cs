using Areas.Admin.Models;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Admin.Models;
using BarsWeb.Controllers;
using Kendo.Mvc.UI;
using System;
using System.Linq;
using System.Web.Mvc;
using Kendo.Mvc.Extensions;
using System.Collections.Generic;

namespace BarsWeb.Areas.Admin.Controllers
{
    [CheckAccessPage]
    [Authorize]
    public class APPController : ApplicationController
    {
        private readonly IADMURepository _repoADMU;
        public APPController(IADMURepository repoADMU)
        {
            _repoADMU = repoADMU;
        }
        public ActionResult GetAllAPPsGrid(decimal userID, [DataSourceRequest] DataSourceRequest request)
        {
            IEnumerable<USERADM_ALL_APPS_WEB> list = _repoADMU.GetAPPsList(userID, request);
            var total = _repoADMU.CountAPPsList(userID, request);
            return Json(new { Data = list, Total = total }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetCurrentUserAPPs(decimal userID, [DataSourceRequest] DataSourceRequest request)
        {
            IEnumerable<V_USERADM_USER_APPS_WEB> result = _repoADMU.GetCurrentUserApps(userID, request);
            return Json(new { Data = result }, JsonRequestBehavior.AllowGet);
        }
    }
}

