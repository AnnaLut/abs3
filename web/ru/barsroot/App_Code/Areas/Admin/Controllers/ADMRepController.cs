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
        public ActionResult GetADMAllRepGrid(string codeApp, [DataSourceRequest] DataSourceRequest request)
        {
            IEnumerable<APPADM_ALL_REP> list = _repoADM.GetADMRepList(codeApp, request);
            var total = _repoADM.GetADMRepCount(codeApp, request);
            return Json(new { Data = list, Total = total }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetADMAppRepGrid(string codeApp, [DataSourceRequest] DataSourceRequest request)
        {
            IEnumerable<V_APPADM_APP_REP_WEB> list = _repoADM.GetADMAppRepList(codeApp, request);
            return Json(new { Data = list }, JsonRequestBehavior.AllowGet);
        }
    }
}
