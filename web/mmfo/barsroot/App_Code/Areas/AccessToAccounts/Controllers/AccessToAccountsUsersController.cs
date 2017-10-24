using System;
using System.Linq;
using System.Web.Mvc;
using BarsWeb.Areas.AccessToAccounts.Infrastructure.DI.Abstract;
using Kendo.Mvc.Extensions;
using System.Collections.Generic;
using BarsWeb.Core.Models.Json;
using Kendo.Mvc.UI;
using BarsWeb.Core.Controllers;

namespace BarsWeb.Areas.AccessToAccounts.Controllers
{
    [CheckAccessPage]
    [AuthorizeUser]
    public class AccessToAccountsUsersController : ApplicationController
    {

        private readonly IAccessToAccountsUsersRepository _AccessToAccountsRep;

        public AccessToAccountsUsersController(IAccessToAccountsUsersRepository AccessToAccountsRep)
        {
            _AccessToAccountsRep = AccessToAccountsRep;
        }

        public ViewResult Users()
        {
            return View();
        }


        [HttpGet]
        public ActionResult GetGroups([DataSourceRequest] DataSourceRequest request)
        {
            var data = _AccessToAccountsRep.GetGroups(request);
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ActionResult GetUserGroups( decimal ID, [DataSourceRequest] DataSourceRequest request)
        {
            var data = _AccessToAccountsRep.GetUserGroups(ID, request);
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        
        [HttpGet]
        public ActionResult GetAccountsGroups(decimal ID, [DataSourceRequest] DataSourceRequest request)
        {
            var data = _AccessToAccountsRep.GetAccountsGroups(ID, request);
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult ChangeUserGroup(decimal GroupID, decimal ID)
        {
            var result = new JsonResponse();
            try
            {
                _AccessToAccountsRep.ChangeUserGroup(GroupID, ID);
                result.Status = JsonResponseStatus.Ok;
            }
            catch(Exception ex)
            {
                result.Status = JsonResponseStatus.Error;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult ChangeAccountsGroup(decimal GroupID, decimal ID)
        {
            var result = new JsonResponse();
            try
            {
                _AccessToAccountsRep.ChangeAccountsGroup(GroupID, ID);
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
