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
        public ActionResult GetAllAPPsGrid([DataSourceRequest] DataSourceRequest request)
        {
            IEnumerable<UserADM_AllApps> list = _repoADMU.GetAPPsList(request);
            var total = _repoADMU.CountAPPsList(request);
            return Json(new { Data = list, Total = total }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetCurrentUserAPPs([DataSourceRequest] DataSourceRequest request)
        {
            IEnumerable<V_USERADM_USER_APPS> result = _repoADMU.GetCurrentUserApps(request);
            return Json(new { Data = result }, JsonRequestBehavior.AllowGet);
        }
    }
}

