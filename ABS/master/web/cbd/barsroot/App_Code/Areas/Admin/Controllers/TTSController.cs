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
    public class TTSController : ApplicationController
    {
        private readonly IADMURepository _repoADMU;
        public TTSController(IADMURepository repoADMU)
        {
            _repoADMU = repoADMU;
        }
        public ActionResult GetAllTTSGrid([DataSourceRequest] DataSourceRequest request)
        {
            IEnumerable<V_USERADM_ALL_TTS> list = _repoADMU.GetTTSList(request);
            var total = _repoADMU.CountTTSList(request);
            return Json(new { Data = list, Total = total }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetCurrentUserTTS([DataSourceRequest] DataSourceRequest request)
        {
            IEnumerable<V_USERADM_USER_TTS> result = _repoADMU.GetCurrentUserTTS(request);
            return Json(new { Data = result }, JsonRequestBehavior.AllowGet);
        }
    }
}

