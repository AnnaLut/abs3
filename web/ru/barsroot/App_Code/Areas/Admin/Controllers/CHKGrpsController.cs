﻿using Areas.Admin.Models;
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
    public class CHKGrpsController : ApplicationController
    {
        private readonly IADMURepository _repoADMU;
        public CHKGrpsController(IADMURepository repoADMU)
        {
            _repoADMU = repoADMU; 
        }
        public ActionResult GetAllCHKGrpsGrid(decimal userID, [DataSourceRequest] DataSourceRequest request)
        {
            IEnumerable<USERADM_ALL_CHKGRPS> list = _repoADMU.GetCHKGRPSList(userID, request);
            var total = _repoADMU.CountCHKGRPSList(userID, request);
            return Json(new { Data = list, Total = total }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetCurrentUserCHKGrps(decimal userID, [DataSourceRequest] DataSourceRequest request)
        {
            IEnumerable<V_USERADM_USER_CHKGRPS_WEB> result = _repoADMU.GetCurrentUserChkGrps(userID, request);
            return Json(new { Data = result }, JsonRequestBehavior.AllowGet);
        }
    }
}

