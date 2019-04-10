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
using Newtonsoft.Json;

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
        public ActionResult GetADMUList([DataSourceRequest] DataSourceRequest request, string parameters, MainFilters mainFilter)
        {
            try
            {
                var a = _repoADMU.ADMUList(request, parameters, mainFilter);
                var jsonResult = Json(a, JsonRequestBehavior.AllowGet);
                jsonResult.MaxJsonLength = int.MaxValue;

                return jsonResult;
            }
            catch (Exception ex)
            {
                return DataSourceErrorResult(ex);
            }
        }

        public ActionResult GetBranchesDdlData()
        {
            try
            {
                IEnumerable<UserBranches> data = _repoADMU.GerBranchesDdlData();
                return Json(data, JsonRequestBehavior.AllowGet);
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
                var data = _repoADMU.RoleLookups().Select(x => new { ID = x.ID, ROLE_CODE = x.ROLE_CODE, ROLE_NAME = x.ROLE_NAME });
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
                return Json(new { Data = data }, JsonRequestBehavior.AllowGet);
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
                return Json(new { Message = "Зміни паролю для " + login + " внесено." }, JsonRequestBehavior.AllowGet);
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
            }, JsonRequestBehavior.AllowGet);
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
    }
}
