using System;
using System.Linq;
using System.Web.Mvc;
using BarsWeb.Areas.AccessToAccounts.Infrastructure.DI.Abstract;
using BarsWeb.Controllers;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using System.Collections.Generic;
using BarsWeb.Core.Models.Json;
using Areas.AccessToAccounts.Models;

namespace BarsWeb.Areas.AccessToAccounts.Controllers
{
    [CheckAccessPage]
    [AuthorizeUser]
    public class AccessRoleGroupsController : ApplicationController
    {
        private readonly IAccRoleGroupsRepository _AccRoleGroupsRep;

        public AccessRoleGroupsController(IAccRoleGroupsRepository AccRoleGroupsRep)
        {
            _AccRoleGroupsRep = AccRoleGroupsRep;
        }

        public ActionResult AccessGroups()
        {
            return View();
        }

        [HttpGet]
        public ActionResult GetAccRoleGroups([DataSourceRequest] DataSourceRequest request)
        {
            var data = _AccRoleGroupsRep.GetAccRoleGroups();
            return Json(data.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ActionResult GetRoles([DataSourceRequest] DataSourceRequest request, decimal? grpId)
        {
            try
            {
                var data = _AccRoleGroupsRep.GetRoles(grpId);
                return Json(data.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(ex.Message);
            }
        }

        [HttpGet]
        public ActionResult GetUsers([DataSourceRequest] DataSourceRequest request, decimal? grpId)
        {
            var data = _AccRoleGroupsRep.GetUsers(grpId);
            return Json(data.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }
        [HttpGet]
        public ActionResult GetGrpAccounts([DataSourceRequest] DataSourceRequest request, decimal? grpId, string myfilter)
        {
            var data = new List<GrpAccounts>();
           if (request.Filters.Count != 0)
            {
                data = _AccRoleGroupsRep.GetGrpAccounts(grpId, myfilter);
            }
            return Json(data.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ActionResult GetAccounts([DataSourceRequest] DataSourceRequest request, decimal? grpId)
        {
            var data = _AccRoleGroupsRep.GetAccounts(grpId);
            return Json(data.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public string GetFilterValue([DataSourceRequest] DataSourceRequest request, decimal? grpId)
        {
            var data = _AccRoleGroupsRep.GetFilterValue(grpId);
            return data;
        }

    }
}
