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
    public class ADMUController : ApplicationController
    {
        private readonly IADMURepository _repoADMU;
        public ADMUController(IADMURepository repoADMU)
        {
            _repoADMU = repoADMU;
        }
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult GetADMUList([DataSourceRequest] DataSourceRequest request)
        {
            IQueryable<STAFF_BASE> list = _repoADMU.GetADMUList();
            return Json(list.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }
        public ActionResult SetADMUContext(decimal userId)
        {
            _repoADMU.SetCurrentUserContext(userId);
            return null;
        }
        public ActionResult AddResourceToUser(decimal userID, string resVal, int tabID, string nbuA017)
        {
            _repoADMU.AddResourcetoUser(userID, resVal, tabID, nbuA017);
            return null;
        }
        public ActionResult RemoveResourceFromUser(decimal userID, string resVal, int tabID, string nbuA017)
        {
            _repoADMU.RemoveResourceFromUser(userID, resVal, tabID, nbuA017);
            return null;
        }
    }
}
