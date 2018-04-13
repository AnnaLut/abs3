using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Admin.Models;
using BarsWeb.Controllers;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace BarsWeb.Areas.Admin.Controllers
{
    [CheckAccessPage]
    [Authorize]
    public class ADMRefController : ApplicationController
    {
        private readonly IADMRepository _repoADM;
        public ADMRefController(IADMRepository repoADM)
        {
            _repoADM = repoADM;
        }
        public ActionResult GetADMAllRefGrid()
        {
            IQueryable<V_APPADM_ALL_REF> list = _repoADM.GetADMRefList();
            var total = _repoADM.GetADMRefCount();
            return Json(new { Data = list, Total = total}, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetADMAppRefGrid()
        {
            IEnumerable<V_APPADM_APP_REF> list = _repoADM.GetADMAppRefList();
            return Json(new { Data = list }, JsonRequestBehavior.AllowGet);
        }
    }
}
