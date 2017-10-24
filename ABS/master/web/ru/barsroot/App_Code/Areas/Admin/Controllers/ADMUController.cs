using Areas.Admin.Models;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Admin.Models;
using BarsWeb.Controllers;
using Kendo.Mvc.UI;
using System;
using System.Linq;
using System.Collections.Generic;
using BarsWeb.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using System.Web.Mvc;
using System.Text;

namespace BarsWeb.Areas.Admin.Controllers
{
    [CheckAccessPage]
    [Authorize]
    public class ADMUController : ApplicationController
    {
        private readonly IADMURepository _repoADMU;
        private readonly IParamsRepository _paramsRepo;
        public ADMUController(IADMURepository repoADMU, IParamsRepository paramsRepo)
        {
            _repoADMU = repoADMU;
            _paramsRepo = paramsRepo;
        }
        public ActionResult Index()
        {
            ViewBag.Proxy = _paramsRepo.GetParam("PROXYUSR");
            return View();
        }
        public ActionResult GetADMUList([DataSourceRequest] DataSourceRequest request)
        {
            //IQueryable<STAFF_BASE> list = _repoADMU.GetADMUList();
            IEnumerable<V_USERADM_USERS> list = _repoADMU.GetADMUList(request);
            var total = _repoADMU.CountADMUList(request);
            return Json(new { Data = list, Total = total }, JsonRequestBehavior.AllowGet);
            //return Json(list.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }
        public ActionResult SetADMUContext(decimal userId)
        {
            _repoADMU.SetCurrentUserContext(userId);
            return null;
        }
        public ActionResult AddResourceToUser(decimal userID, string resVal, int tabID, string nbuA017)
        {
            _repoADMU.AddResourcetoUser(userID, resVal, tabID, nbuA017);
            return null;
        }
        public ActionResult RemoveResourceFromUser(decimal userID, string resVal, int tabID, string nbuA017)
        {
            _repoADMU.RemoveResourceFromUser(userID, resVal, tabID, nbuA017);
            return null;
        }
        public ActionResult GetCurrentUser(decimal userId)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                V_USERADM_USERS user = _repoADMU.GetCurrentUser(userId);
                result.data = user;
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        // GetClassList - населення dataSource для dropdownClassList даними з серверу, а не хардово з в"юхи
        // наразі, його не використовую. дані для дропа хардово вбив на в"юсі.
        public ActionResult GetClassList()
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                IEnumerable<STAFF_CLASS> clsList = _repoADMU.GetClassData();
                result.data = clsList;
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
            }
            return Json(new { Data = result }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetUserRoles(string userLogin)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                IEnumerable<string> rolesList = _repoADMU.GetUserRoles(userLogin);
                result.data = rolesList.ToList().Select(r => new { value = r, text = r });
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetExpireDate(decimal userId)
        {
            var result = _repoADMU.GetExpireDate(userId);
            return Json(new { Data = result }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult AddUser(
            string p_usrfio,      
            string p_usrtabn,    
            decimal p_usrtype,    
            decimal p_usraccown,   
            string p_usrbranch,   
            decimal? p_usrusearc,  
            decimal p_usrusegtw,   
            string p_usrwprof,    
            string p_reclogname, 
            string p_recpasswd,  
            string p_recappauth,  
            string p_recprof,   
            string p_recdefrole,  
            string p_recrsgrp,  
            decimal? p_usrid,      
            string p_gtwpasswd,   
            string p_canselectbranch,
            string p_chgpwd,      
            decimal? p_tipid)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repoADMU.AddUser(p_usrfio, p_usrtabn, p_usrtype, p_usraccown, p_usrbranch, p_usrusearc, p_usrusegtw, p_usrwprof,
                    p_reclogname, p_recpasswd, p_recappauth, p_recprof, p_recdefrole, p_recrsgrp, p_usrid, p_gtwpasswd,
                    p_canselectbranch, p_chgpwd, p_tipid);
                result.status = JsonResponseStatus.Ok;
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult EditUser(
            decimal p_usrid,
            string p_usrfio, 
            string p_usrtabn, 
            decimal p_usrtype,
            decimal? p_usraccown, 
            string p_usrbranch, 
            decimal? p_usrarc,
            decimal? p_usrusegtw, 
            string p_usrwprof,
            string p_recpasswd,
            string p_recappauth,
            string p_recprof,
            string p_recdefrole, 
            string p_recrsgrp,
            string p_canselectbranch, 
            string p_chgpwd,
            decimal? p_tipid)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repoADMU.EditUser(p_usrid, p_usrfio, p_usrtabn, p_usrtype, p_usraccown, p_usrbranch, p_usrarc, p_usrusegtw, 
                p_usrwprof, p_recpasswd, p_recappauth, p_recprof, p_recdefrole, p_recrsgrp, p_canselectbranch, p_chgpwd, p_tipid);
                result.status = JsonResponseStatus.Ok;
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult DropUser(decimal dropUserID)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repoADMU.DropUser(dropUserID);
                result.status = JsonResponseStatus.Ok;
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetBranchList(DataSourceRequest request)
        {
            IEnumerable<V_USERADM_BRANCHES> list = _repoADMU.GetBranchList(request);
            var total = _repoADMU.CountBranches(request);
            return Json(new { Data = list, Total = total }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetUsersResourceList(DataSourceRequest request)
        {
            IEnumerable<V_USERADM_RESOURCES> list = _repoADMU.GetUserResources(request);
            var total = _repoADMU.CountUserResources(request);
            return Json(new { Data = list, Total = total }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult CloneUser(string cloneUserParam)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repoADMU.CloneUser(cloneUserParam);
                result.status = JsonResponseStatus.Ok;
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetTransmitUserList(DataSourceRequest request)
        {
            IEnumerable<USER> list = _repoADMU.GetTransmitUserList(request);
            var total = _repoADMU.CountTransmitUserList(request);
            return Json(new { Data = list, Total = total }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetTransmitUserAccounts(decimal oldUserId, decimal newUserId)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repoADMU.GetTransmitUserAccounts(oldUserId, newUserId);
                result.status = JsonResponseStatus.Ok;
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult LockUser(decimal userId, string dateStart, string dateEnd)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repoADMU.LockUser(userId, dateStart, dateEnd);
                result.status = JsonResponseStatus.Ok;
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult UnlockUser(decimal userId, string dateStart, string dateEnd)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repoADMU.UnlockUser(userId, dateStart, dateEnd);
                result.status = JsonResponseStatus.Ok;
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public FileResult File(string userId)
        {
            string reportString = "PROMPT Скрипт загрузки ресурсов пользователя " + userId +
                "\r\nDELETE\r\nFROM applist_staff\r\nWHERE id=" + userId + ";\r\nDELETE\r\nFROM groups_staff\r\nWHERE id=" + userId +
                ";\r\nDELETE\r\nFROM staff_chk\r\nWHERE id=" + userId + ";\r\nDELETE\r\nFROM staff_klf00\r\nWHERE id=" + userId +
                ";\r\nDELETE\r\nFROM staff_tts\r\nWHERE id=" + userId + ";\r\ncommit;\r\nexec bars_useradm.change_user_privs(" + userId + ");";
            var contentType = "text/plain";

            var bytes = Encoding.UTF8.GetBytes(reportString);
            var result = new FileContentResult(bytes, contentType);
            result.FileDownloadName = "SQL_USER_ID_" + userId + "_script.txt";
            return result; 
        }
    }
}
