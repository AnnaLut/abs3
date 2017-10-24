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
using BarsWeb.Models;

namespace BarsWeb.Areas.Admin.Controllers
{
    [Authorize]
    public class ADMSegmentsController : ApplicationController
    {
        private readonly IADMSegmentsRepository _repoADM;
        public ADMSegmentsController(IADMSegmentsRepository repoADM)
        {
            _repoADM = repoADM;
        }
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult GetDWHData([DataSourceRequest] DataSourceRequest request)
        {
            //IEnumerable<V_DWHLOG> list = _repoADM.GetDWHData(request);
            //TODO: переделать на request + kendoSqlTransformer
            IEnumerable<V_DWHLOG> list = _repoADM.GetDWHData();
            // var total = _repoADM.CountAllAPPS(request);
            return Json(new { Data = list }, JsonRequestBehavior.AllowGet);
        }
        
    }
}

