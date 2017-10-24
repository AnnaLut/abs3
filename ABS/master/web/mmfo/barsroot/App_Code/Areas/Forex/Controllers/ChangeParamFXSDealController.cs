using BarsWeb.Areas.Forex.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Forex.Models;
using BarsWeb.Areas.Forex.Util;
using BarsWeb.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BarsWeb.Areas.Forex.Controllers
{
    //[CheckAccessPage]
    [AuthorizeUser]
    public class ChangeParamFXSDealController : ApplicationController
    {
        private readonly IRegularDealsRepository _repo;
        public ChangeParamFXSDealController(IRegularDealsRepository repo)
        {
            _repo = repo;
        }

        public ViewResult ChangeParamFXSDeal(decimal DEAL_TAG)
        {
            FXUPD fxupd = _repo.GetFXUPDeal(DEAL_TAG).FirstOrDefault();
            fxupd = _repo.GetFXUPDealAllFields(fxupd);
            ViewBag.FXUPD = JavaScriptConvert.SerializeObject(fxupd);
            return View();
        }

        [HttpGet]
        public ActionResult GetRevenueDropDown(decimal? kv)
        {
            var result = new BarsWeb.Models.JsonResponse(BarsWeb.Models.JsonResponseStatus.Ok);
            try
            {
                List<Revenue> data = _repo.GetRevenueDropDown(kv);
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                result.status = BarsWeb.Models.JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
                return Json(result, JsonRequestBehavior.AllowGet);
            }
        }
    }
}        