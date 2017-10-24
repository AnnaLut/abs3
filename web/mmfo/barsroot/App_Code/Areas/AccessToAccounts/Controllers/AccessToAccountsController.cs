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
    public class AccessToAccountsController : ApplicationController
    {

        private readonly IAccessToAccountsRepository _AccessToAccountsRep;

        public AccessToAccountsController(IAccessToAccountsRepository AccessToAccountsRep)
        {
            _AccessToAccountsRep = AccessToAccountsRep;
        }

        public ViewResult Accounts()
        {
            return View();
        }
        
        [HttpGet]
        public ActionResult GetAccounts([DataSourceRequest] DataSourceRequest request)
        {
            var data = _AccessToAccountsRep.GetAccounts(request);
            return Json(data, JsonRequestBehavior.AllowGet);
        }        

        [HttpGet]
        public ActionResult GetLeftUsers(decimal ID, [DataSourceRequest] DataSourceRequest request)
        {
            var data = _AccessToAccountsRep.GetLeftUsers(ID, request);
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ActionResult GetRightUsers(decimal ID, [DataSourceRequest] DataSourceRequest request)
        {
            var data = _AccessToAccountsRep.GetRightUsers(ID, request);
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult ChangeLeftUser(decimal AccountID, decimal ID)
        {
            var result = new JsonResponse();
            try
            {
                _AccessToAccountsRep.ChangeLeftUser(AccountID, ID);
                result.Status = JsonResponseStatus.Ok;
            }
            catch (Exception ex)
            {
                result.Status = JsonResponseStatus.Error;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        
        [HttpPost]
        public ActionResult ChangeRightUser(decimal AccountID, decimal ID)
        {
            var result = new JsonResponse();
            try
            {
                _AccessToAccountsRep.ChangeRightUser(AccountID, ID);
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