using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Admin.Models;
using BarsWeb.Controllers;
using BarsWeb.Models;
using Kendo.Mvc.UI;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BarsWeb.Areas.Admin.Controllers
{
    //[CheckAccessPage]
    [Authorize]
    public class ConfirmController : ApplicationController
    {
        private readonly IConfirmRepository _repo;
        public ConfirmController(IConfirmRepository repo)
        {
            _repo = repo;
        }
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult GetUserConfirmGrid([DataSourceRequest] DataSourceRequest request)
        {
            IEnumerable<V_USER_RESOURCES_CONFIRM> data = _repo.GetUserConfirmData(request);
            var total = _repo.CountUserConfirmData(request);
            return Json(new { Data = data, Total = total }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetAppConfirmGrid([DataSourceRequest] DataSourceRequest request)
        {
            IEnumerable<V_APP_RESOURCES_CONFIRM> data = _repo.GetAppConfirmData(request);
            var total = _repo.CountAppConfirmData(request);
            return Json(new { Data = data, Total = total }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult UserApproveCommand(string userId, string resId, string obj)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repo.ConfirmUserApproving(userId, resId, obj);
                result.message = "Ресурс успішно додано!";
            }
            catch (Exception ex)
            {
                result.message = ex.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult UserRevokeCommand(string userId, string resId, string obj)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repo.ConfirmUserRevoking(userId, resId, obj);
                result.message = "Ресурс успішно видалено!";
            }
            catch (Exception ex)
            {
                result.message = ex.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult AppApproveCommand(string id, string codeapp, string obj)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repo.ConfirmAppApproving(id, codeapp, obj);
                result.message = "Ресурс успішно додано!";
            }
            catch (Exception ex)
            {
                result.message = ex.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult AppRevokeCommand(string id, string codeapp, string obj)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repo.ConfirmAppRevoking(id, codeapp, obj);
                result.message = "Ресурс успішно видалено!";
            }
            catch (Exception ex)
            {
                result.message = ex.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
    }
}
