using System;
using System.Linq;
using System.Web.Mvc;
using BarsWeb.Areas.AccessToAccounts.Infrastructure.DI.Abstract;
using BarsWeb.Controllers;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using System.Collections.Generic;
using BarsWeb.Core.Models.Json;
using Areas.AccessToAccounts.Models;

namespace BarsWeb.Areas.AccessToAccounts.Controllers
{
    [CheckAccessPage]
    [AuthorizeUser]
    public class AccGroupsController : ApplicationController
    {
        private readonly IAccGroupsRepository _AccGroupsRep;

        public AccGroupsController(IAccGroupsRepository AccGroupsRep)
        {
            _AccGroupsRep = AccGroupsRep;
        }

        public ViewResult AccGroups()
        {
            return View();
        }

        [HttpGet]
        public ActionResult GetAccGroups()
        {
            var data = _AccGroupsRep.GetAccGroups();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ActionResult GetIssuedAccounts(decimal? grpId, decimal? ACC, string NLS)
        {
            var data = _AccGroupsRep.GetIssuedAccounts(grpId, ACC, NLS);
            return Json(data, JsonRequestBehavior.AllowGet);
        }

       

        [HttpGet]
        public ActionResult GetNotIssuedAccounts(decimal? grpId, string nls)
        {
            var data = _AccGroupsRep.GetNotIssuedAccounts(grpId, nls);
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult addAgrp(decimal grpId, decimal acc)
        {
            var result = new JsonResponse();
            try
            {
                _AccGroupsRep.addAgrp(grpId, acc);
                result.Status = JsonResponseStatus.Ok;
            }
            catch (Exception ex)
            {
                result.Status = JsonResponseStatus.Error;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult delAgrp(decimal grpId, decimal acc)
        {
            var result = new JsonResponse();
            try
            {
                _AccGroupsRep.delAgrp(grpId, acc);
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
