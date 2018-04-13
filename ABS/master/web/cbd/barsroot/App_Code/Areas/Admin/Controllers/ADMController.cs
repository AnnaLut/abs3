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
    [CheckAccessPage]
    [Authorize]
    public class ADMController : ApplicationController
    {
        private readonly IADMRepository _repoADM;
        public ADMController(IADMRepository repoADM)
        {
            _repoADM = repoADM;
        }
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult GetADMList([DataSourceRequest] DataSourceRequest request)
        {
            IQueryable<APPLIST> list = _repoADM.GetADMList();
            return Json(list.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }
        public ActionResult SetCurrentApp(string codeApp)
        {
            _repoADM.SetCurrentAppContext(codeApp);
            return null;
        }
        public ActionResult AddResourceToADM(string admId, decimal resVal, int tabId) 
        {
            _repoADM.AddResourceToADM(admId, resVal, tabId);
            return null;
        }
        public ActionResult RemoveResourceFromADM(string admId, decimal resVal, int tabId)
        {
            _repoADM.RemoveResourceFromADM(admId, resVal, tabId);
            return null;
        }
        public ActionResult CreateADM(string appCode, string appName, decimal frontID)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repoADM.CreateADM(appCode, appName, frontID);
                result.status = JsonResponseStatus.Ok;
                result.data = 1;
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.data = 0;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult DropADM(string appCode)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repoADM.DropADM(appCode);
                result.status = JsonResponseStatus.Ok;
                result.data = 1;
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.data = 0;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult EditADM(string appCode, string appName, decimal frontID)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repoADM.EditADM(appCode, appName, frontID);
                result.status = JsonResponseStatus.Ok;
                result.data = 1;
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.data = 0;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
    }
}

