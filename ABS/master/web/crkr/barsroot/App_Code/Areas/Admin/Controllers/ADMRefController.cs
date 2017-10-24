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
    public class ADMRefController : ApplicationController
    {
        private readonly IADMRepository _repoADM;
        public ADMRefController(IADMRepository repoADM)
        {
            _repoADM = repoADM;
        }
        public ActionResult GetADMAllRefGrid(string codeApp, [DataSourceRequest] DataSourceRequest request)
        {
            IEnumerable<APPADM_ALL_REF> list = _repoADM.GetADMRefList(codeApp, request);
            var total = _repoADM.GetADMRefCount(codeApp, request);
            return Json(new { Data = list, Total = total}, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetADMAppRefGrid(string codeApp, [DataSourceRequest] DataSourceRequest request)
        {
            IEnumerable<V_APPADM_APP_REF_WEB> list = _repoADM.GetADMAppRefList(codeApp, request);
            return Json(new { Data = list }, JsonRequestBehavior.AllowGet);
        }
    }
}
