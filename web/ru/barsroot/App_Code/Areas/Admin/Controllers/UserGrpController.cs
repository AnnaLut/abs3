using System;
using System.Web.Mvc;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using System.Collections;
using BarsWeb.Areas.Admin.Models;
using System.Collections.Generic;
using System.Web.Mvc;
using BarsWeb.Controllers;
using Kendo.Mvc.UI;
using BarsWeb.Models;

namespace BarsWeb.Areas.Admin.Controllers
{
    [CheckAccessPage]
    [Authorize]
    public class UserGrpController : ApplicationController
    {
        private readonly IADMURepository _repoADMU;
        public UserGrpController(IADMURepository repoADMU)
        {
            _repoADMU = repoADMU;
        }

        public ActionResult GetUserGrpsGrid(DataSourceRequest request, decimal userId)
        {
            IEnumerable<USERADM_USERGRP_WEB> data = _repoADMU.UserGrpData(request, userId);
            var dataCount = _repoADMU.UserGrpCount(request, userId);
            return Json(new { Data = data, Total = dataCount }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetGrps(DataSourceRequest request, decimal userId)
        {
            IEnumerable<USERADM_ALL_GRP_WEB> data = _repoADMU.GrpData(request, userId);
            var dataCount = _repoADMU.GrpCount(request, userId);
            return Json(new { Data = data, Total = dataCount }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult ChangeStatus(decimal userId, decimal tabid, bool pr, bool deb, bool cre)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repoADMU.ChangeStatus(userId, tabid, pr, deb, cre);
                result.status = JsonResponseStatus.Ok;
            }
            catch (Exception ex)
            {
                result.status = JsonResponseStatus.Error;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
    }
    
}

