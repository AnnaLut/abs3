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
    public class ADMRepController : ApplicationController
    {
        private readonly IADMRepository _repoADM;
        public ADMRepController(IADMRepository repoADM)
        {
            _repoADM = repoADM;
        }
        public ActionResult GetADMAllRepGrid()
        {
            IEnumerable<V_APPADM_ALL_REP> list = _repoADM.GetADMRepList();
            var total = _repoADM.GetADMRepCount();
            return Json(new { Data = list, Total = total }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetADMAppRepGrid()
        {
            IEnumerable<V_APPADM_APP_REP> list = _repoADM.GetADMAppRepList();
            return Json(new { Data = list }, JsonRequestBehavior.AllowGet);
        }
    }
}
