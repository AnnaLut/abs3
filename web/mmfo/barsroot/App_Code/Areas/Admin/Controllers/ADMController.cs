using Areas.Admin.Models;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Controllers;
using Kendo.Mvc.UI;
using System;
using System.Linq;
using System.Web.Mvc;
using Kendo.Mvc.Extensions;
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
            try
            {
                IQueryable<V_APPLIST_ADM> data = _repoADM.GetADMList();
                return Json(data.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }
        }

        public ActionResult CreateAdm(string admCode, string admName, string appType)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repoADM.CreateAdmItem(admCode, admName, appType);
                result.message = "Створено новий АРМ: " + admName + ".";
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet); 
        }

        public ActionResult EditAdm(string admCode, string admName, string appType)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repoADM.EditAdmItem(admCode, admName, appType);
                result.message = "Зміни до АРМу: " + admName + " успішно збережено.";
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult SetAdmResourceAccessMode(string admCode, string resourceTypeId, string resourceId, string accessModeId)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repoADM.SetAdmResourceAccessMode(admCode, resourceTypeId, resourceId, accessModeId);
                result.message = "Доступ змінено.";
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }


        private JsonResult DataSourceErrorResult(Exception ex)
        {
            return Json(new DataSourceResult
            {
                Errors = new
                {
                    message = ex.Message
                }
            }, JsonRequestBehavior.AllowGet);
        }
    }
}

