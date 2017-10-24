using System;
using System.Linq;
using System.Web.Mvc;
using BarsWeb.Areas.AccessToAccounts.Infrastructure.DI.Abstract;
using Kendo.Mvc.Extensions;
using System.Collections.Generic;
using BarsWeb.Core.Models.Json;
using Kendo.Mvc.UI;
using BarsWeb.Core.Controllers;
using Areas.AccessToAccounts.Models;
using System.Web;

namespace BarsWeb.Areas.AccessToAccounts.Controllers
{

    [CheckAccessPage]
    [AuthorizeUser]
    public class AccessToAccountsMainController : ApplicationController
    {

        private readonly IAccessToAccountsMainRepository _AccessToAccountsRep;

        public AccessToAccountsMainController(IAccessToAccountsMainRepository AccessToAccountsRep)
        {
            _AccessToAccountsRep = AccessToAccountsRep;
        }

        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public ActionResult GetAccounts([DataSourceRequest] DataSourceRequest request)
        {
            IQueryable<Accounts> data = _AccessToAccountsRep.GetAccounts(request);
            var dataCount = _AccessToAccountsRep.AccountsDataCount(request);
            return Json(new { Data = data, Total = dataCount }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ActionResult GetGroupServingAccount(decimal ID, [DataSourceRequest] DataSourceRequest request)
        {
            if (ID == -1)
            {
                return Json(new { Data = 0, Total = 0 }, JsonRequestBehavior.AllowGet);
            }

            IQueryable<ServingGroups> data = _AccessToAccountsRep.GetGroupServingAccount(ID, request);
            var dataCount = _AccessToAccountsRep.GroupServingAccountDataCount(ID, request);
            return Json(new { Data = data, Total = dataCount }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ActionResult GetGroupUsers(decimal ID, [DataSourceRequest] DataSourceRequest request)
        {
            if (ID == -1)
            {
                return Json(new { Data = 0, Total = 0 }, JsonRequestBehavior.AllowGet);
            }

            IQueryable<ServingGroups> data = _AccessToAccountsRep.GetGroupUsers(ID, request);
            var dataCount = _AccessToAccountsRep.GroupUsersDataCount(ID, request);
            return Json(new { Data = data, Total = dataCount }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ActionResult GetTheGroups(decimal ID, [DataSourceRequest] DataSourceRequest request)
        {
            try
            {
                if (ID == -1)
                {
                    return Json(new { Data = 0, Total = 0 }, JsonRequestBehavior.AllowGet);
                }

                IQueryable<TheGroup> data = _AccessToAccountsRep.GetTheGroups(ID, request);
                var dataCount = _AccessToAccountsRep.TheGroupsDataCount(ID, request);
                return Json(new { Data = data, Total = dataCount }, JsonRequestBehavior.AllowGet);

            }
            catch(Exception ex)
            {
                return null;
            }

        }

        [HttpGet]
        public ActionResult GetDropDownAccountGroup(decimal ID)
        {
            IQueryable<ServingGroups> data = _AccessToAccountsRep.GetDropDownAccountGroup(ID);
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ActionResult GetDropDownGroupUsers(decimal ID)
        {

            IQueryable<ServingGroups> data = _AccessToAccountsRep.GetDropDownGroupUsers(ID);
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ActionResult GetDropDownUsers(decimal ID)
        {

            IQueryable<ServingGroups> data = _AccessToAccountsRep.GetDropDownUsers(ID);
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult AddAccountGroup(decimal AccID, decimal ID)
        {
            var result = new JsonResponse();
            try
            {
                _AccessToAccountsRep.AddAccountGroup(AccID, ID);
                result.Status = JsonResponseStatus.Ok;
            }
            catch (Exception ex)
            {
                result.Status = JsonResponseStatus.Error;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult AddGroupUsers(decimal AccGroupID, decimal ID)
        {
            var result = new JsonResponse();
            try
            {
                _AccessToAccountsRep.AddGroupUsers(AccGroupID, ID);
                result.Status = JsonResponseStatus.Ok;
            }
            catch (Exception ex)
            {
                result.Status = JsonResponseStatus.Error;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult AddUser(decimal UserGroupID, decimal ID)
        {
            var result = new JsonResponse();
            try
            {
                _AccessToAccountsRep.AddUser(UserGroupID, ID);
                result.Status = JsonResponseStatus.Ok;
            }
            catch (Exception ex)
            {
                result.Status = JsonResponseStatus.Error;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        [HttpDelete]
        public ActionResult DeleteGroupAccount(decimal IDAcc, decimal IDAccGroup)
        {
            var result = new JsonResponse();
            try
            {
                _AccessToAccountsRep.DeleteGroupAccount(IDAcc, IDAccGroup);
                result.Status = JsonResponseStatus.Ok;
            }
            catch (Exception ex)
            {
                result.Status = JsonResponseStatus.Error;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        
        [HttpDelete]
        public ActionResult DeleteGroupUser(decimal IDAccGroup, decimal IDUserGroup)
        {
            var result = new JsonResponse();
            try
            {
                _AccessToAccountsRep.DeleteGroupUser(IDAccGroup, IDUserGroup);
                result.Status = JsonResponseStatus.Ok;
            }
            catch (Exception ex)
            {
                result.Status = JsonResponseStatus.Error;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
       
        [HttpDelete]
        public ActionResult DeleteUser(decimal IDUserGroup, decimal IDUser)
        {
            var result = new JsonResponse();
            try
            {
                _AccessToAccountsRep.DeleteUser(IDUserGroup, IDUser);
                result.Status = JsonResponseStatus.Ok;
            }
            catch (Exception ex)
            {
                result.Status = JsonResponseStatus.Error;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        
        [HttpPut]
        public ActionResult UpdateUser(List<UserUpdate> userUpdate)
        {

            var result = new JsonResponse();
            try
            {
                _AccessToAccountsRep.UpdateUser(userUpdate);
                result.Status = JsonResponseStatus.Ok;
            }
            catch (Exception ex)
            {
                result.Status = JsonResponseStatus.Error;
            }
            return Json(result, JsonRequestBehavior.AllowGet);

        }

    }
}
