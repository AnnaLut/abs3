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
    //[CheckAccessPage]
    [Authorize]
    public class ADMOperController : ApplicationController
    {
        private readonly IADMRepository _repoADM;
        public ADMOperController(IADMRepository repoADM)
        {
            _repoADM = repoADM;
        }
        public ActionResult GetADMAllOperGrid(string codeApp, [DataSourceRequest] DataSourceRequest request)
        {
            IEnumerable<APPADM_ALL_OPER> list = _repoADM.GetADMOperList(codeApp, request);
            var total = _repoADM.GetADMOperCount(codeApp, request);
            return Json(new { Data = list, Total = total }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetADMAppOperGrid(string codeApp, [DataSourceRequest] DataSourceRequest request)
        {
            IEnumerable<V_APPADM_APP_OPER_WEB> list = _repoADM.GetADMAppOperList(codeApp, request);
            return Json(new { Data = list }, JsonRequestBehavior.AllowGet);
        }
    }
}
