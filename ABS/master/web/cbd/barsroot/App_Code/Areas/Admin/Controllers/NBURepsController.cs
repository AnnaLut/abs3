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
    public class NBURepsController : ApplicationController
    {
        private readonly IADMURepository _repoADMU;
        public NBURepsController(IADMURepository repoADMU)
        {
            _repoADMU = repoADMU;
        }
        public ActionResult GetNBURepsGrid([DataSourceRequest] DataSourceRequest request)
        {
            IEnumerable<V_USERADM_ALL_NBUREPS> list = _repoADMU.GetNBUREPSList(request);
            var total = _repoADMU.CountNBUREPSList(request);
            return Json(new { Data = list, Total = total }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetCurrentUserNBUReps([DataSourceRequest] DataSourceRequest request)
        {
            IEnumerable<V_USERADM_USER_NBUREPS> result = _repoADMU.GetCurrentUserNBURps(request);
            return Json(new { Data = result }, JsonRequestBehavior.AllowGet);
        }
    }
}

