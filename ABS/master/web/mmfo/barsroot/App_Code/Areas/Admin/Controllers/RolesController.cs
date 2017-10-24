using System;
using System.Web.Mvc;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Controllers;
using BarsWeb.Models;

namespace BarsWeb.Areas.Admin.Controllers
{
    [CheckAccessPage]
    [Authorize]
    public class RolesController : ApplicationController
    {
        private readonly IRolesRepository _repo;
        public RolesController(IRolesRepository repo)
        {
            _repo = repo;
        }

        public ActionResult Index()
        {
            return View();
        }
        
        public ActionResult CreateRole(string roleCode, string roleName)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repo.CreateRole(roleCode, roleName);
                result.message = "Створено нову роль. ID: " + result.data + ".";
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet); 
        }

        public ActionResult EditRole(string roleCode, string roleName)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repo.EditRole(roleCode, roleName);
                result.message = "Зміни для ролі " + roleName + " збережено.";
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet); 
        }

        public ActionResult UnlockRole(string roleCode)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repo.UnlockRole(roleCode);
                result.message = "Роль: " + roleCode + " - активовано.";
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet); 
        }
        
        public ActionResult DeleteRole(string roleCode)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repo.DeleteRole(roleCode);
                result.message = "Роль: " + roleCode + " - видалено.";
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult LockRole(string roleCode)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repo.LockRole(roleCode);
                result.message = "Роль: " + roleCode + " - деактивовано.";
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet); 
        }

        public ActionResult SetResourceAccessMode(string roleCode, string resourceTypeId, string resourceId, string accessModeId)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repo.SetResourceAccessMode(roleCode, resourceTypeId, resourceId, accessModeId);
                result.message = "Доступ змінено.";
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
    }
}