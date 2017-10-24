using Areas.Admin.Models;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Admin.Models.ADMU;
using BarsWeb.Controllers;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Linq;
using BarsWeb.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using System.Web.Mvc;
using Kendo.Mvc.Extensions;
using Oracle.DataAccess.Client;

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
            //ViewBag.Proxy = _paramsRepo.GetParam("PROXYUSR");
            return View();
        }
        public ActionResult GetADMUList([DataSourceRequest] DataSourceRequest request, string parameters)
        {
            try
            {
                var data = _repoADMU.GetADMUList(parameters).ToList();
                return Json(data.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }
        }
        public ActionResult GetBranchList(DataSourceRequest request)
        {
            try
            {
                IQueryable<V_USERADM_BRANCHES> data = _repoADMU.GetBranchList();
                return Json(data.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }
        }
        public ActionResult GetBranchLookups(DataSourceRequest request)
        {
            try
            {
                IQueryable<V_STAFF_USER_BRANCH_LOOKUP> data = _repoADMU.BranchLookups();
                return Json(data.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }
        }
        public ActionResult GetRoleLookups(DataSourceRequest request)
        {
            try
            {
                var data = _repoADMU.RoleLookups().Select(x => new  { ID = x.ID , ROLE_CODE = x.ROLE_CODE, ROLE_NAME = x.ROLE_NAME });
                return Json(data.ToDataSourceResult(request), JsonRequestBehavior.AllowGet); 
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }
        }

        public ActionResult GetUserRoles([DataSourceRequest] DataSourceRequest request, decimal userId)
        {
            try
            {
                var data = _repoADMU.UserRoles().Where(x => x.USER_ID == userId).Select(x => new { USER_ID = x.USER_ID, ROLE_NAME = x.ROLE_NAME, ROLE_CODE = x.ROLE_CODE, ROLE_ID = x.ROLE_ID, IS_GRANTED = x.IS_GRANTED, IS_APPROVED = x.IS_APPROVED });
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }
        }
        public ActionResult GetOraRolesLookups([DataSourceRequest] DataSourceRequest request)
        {
            try
            {
                IQueryable<V_STAFF_USER_ORA_ROLE_LOOKUP> data = _repoADMU.OracleRoleLookups();
                return Json(data.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }
        }
        public ActionResult CreateUser(CreateUserModel model)
        {
            try
            {
                var userCreated = _repoADMU.CreateUser(model);
                return Json(new { Message = "Створено новогого користувача. ID: " + userCreated }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                var oraEx = ((OracleException)ex).Number;
                if (oraEx == 20000)
                {
                    string[] msg = ((OracleException)ex).Message.Split('\n');
                    return DataSourceErrorResult(msg[0]);
                }
                else
                {
                    return DataSourceErrorResult(ex);
                }
            }
        }

        public ActionResult GetUserData(string loginName)
        {
            try
            {
                var data = _repoADMU.GetUserData(loginName);
                return Json(new {Data = data}, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }
        }

        public ActionResult ChangeAbsUserPassword(string login, string password)
        {
            try
            {
                _repoADMU.ChangeAbsUserPassword(login, password);
                return Json(new { Message = "Зміни паролю для " + login + " внесено."}, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex.Message);
            }
        }

        public ActionResult ChangeOraUserPassword(string login, string password)
        {
            try
            {
                _repoADMU.ChangeOraUserPassword(login, password);
                return Json(new { Message = "Зміни паролю для " + login + " внесено." }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }
        }

        public ActionResult LockUser(string login, string comment)
        {
            try
            {
                _repoADMU.LockUser(login, comment);
                return Json(new { Message = "Користувача " + login + " заблоковано." }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }
        }

        public ActionResult UnlockUser(string login)
        {
            try
            {
                _repoADMU.UnlockUser(login);
                return Json(new { Message = "Користувача " + login + " розблоковано." }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }
        }

        public ActionResult DelegateUserRights(string login, string delegatedUser, string validFrom, string validTo, string comment)
        {
            try
            {
                _repoADMU.DelegateUserRights(login, delegatedUser, validFrom, validTo, comment);
                return Json(new { Message = "Користувачу " + delegatedUser + " делеговано права користувача " + login }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }
        }

        public ActionResult CencelDelegateUserRights(string login)
        {
            try
            {
                _repoADMU.CencelDelegateUserRights(login);
                return Json(new { Message = "Всі делегування прав користувача " + login + " - скасовано." }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }
        }

        public ActionResult EditUser(EditUserModel item)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repoADMU.EditUser(item);
                result.message = "Редагування значень користувача " + item.LoginName + " збережено.";
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet); 
        }

        public ActionResult CloseUser(string login)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repoADMU.CloseUser(login);
                result.message = "Користувача " + login + " закрито.";
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
                    message = ex.ToString()
                }
            },JsonRequestBehavior.AllowGet);
        }

        private JsonResult DataSourceErrorResult(string exceptionMessage)
        {
            return Json(new DataSourceResult
            {
                Errors = new
                {
                    message = exceptionMessage
                }
            }, JsonRequestBehavior.AllowGet);
        }


        // ******************
        public ActionResult Empty()
        {
            return View();
        }
        // ******************

        /*

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
         * 
         * 
         */

        
    }
}
