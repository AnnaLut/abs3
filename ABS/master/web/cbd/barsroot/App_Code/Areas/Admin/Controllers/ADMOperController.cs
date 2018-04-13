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
    public class ADMOperController : ApplicationController
    {
        private readonly IADMRepository _repoADM;
        public ADMOperController(IADMRepository repoADM)
        {
            _repoADM = repoADM;
        }
        public ActionResult GetADMAllOperGrid()
        {
            IQueryable<V_APPADM_ALL_OPER> list = _repoADM.GetADMOperList();
            var total = _repoADM.GetADMOperCount();
            return Json(new { Data = list, Total = total }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetADMAppOperGrid()
        {
            IEnumerable<V_APPADM_APP_OPER> list = _repoADM.GetADMAppOperList();
            return Json(new { Data = list }, JsonRequestBehavior.AllowGet);
        }
    }
}
