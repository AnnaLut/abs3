using BarsWeb.Controllers;
using System;
using BarsWeb.Areas.Teller.Infrastructure.DI.Abstract;
using System.Web.Mvc;
using System.Net;
using System.Collections.Generic;
using System.Linq;
using BarsWeb.Areas.Teller.Model;
using Kendo.Mvc.UI;
using Kendo.Mvc.Extensions;
using BarsWeb.Areas.Teller.Enums;

namespace BarsWeb.Areas.Teller.Controllers
{
    [AuthorizeUser]
    public class TellerController : ApplicationController
    {
        ITellerRepository repository;
        public TellerController(ITellerRepository _repository)
        {
            this.repository = _repository;
        }

        public ActionResult ATM(ATMModel data)
        {
            TellerWindowStatusModel windStatus = new TellerWindowStatusModel();
            windStatus = repository.ExecuteGetStatus(data);
            if (!String.IsNullOrEmpty(windStatus.Status) && windStatus.Status == "OK" && windStatus.Status == "??")
                windStatus.OperDesc = "OK";
            if (windStatus == null || String.IsNullOrEmpty(windStatus.OperDesc) && windStatus.Status != "OK")
                Response.StatusCode = (int)HttpStatusCode.InternalServerError;
            return View(windStatus);
        }

        public ActionResult EncashmentForm()
        {
            return View();
        }

        public ActionResult Technical()
        {
            List<ATMTechnicalButtonsModel> model = repository.GetTechnicalButtons();
            return View(model);
        }

        public ActionResult EncashmentWindow(String data)
        {
            EncashmentClientModel model = new EncashmentClientModel
            {
                EncashmentType =  data,
                Currency       =  repository.GetCurrencyList().ToList(),
                Role           =  repository.GetRole(),
                NonAmount      =  "0",
                ToxFlag = 0 //не показываем кнопку внесения
            };
            if (data != "INPUT")
                model.NonAmount = repository.GetEncashmentNonAmount("980");
            if (data == "OUTPUT")
                model.NonAtmAmount = repository.nonAtmAmount();
            model.ToxFlag = repository.GetToxFlag();
            return View(model);
        }

        public ActionResult ATMCurrency(String code, String permission)
        {
            var model = repository.GetAtmCurrencyList(code);
            ViewBag.Code = code;
            ViewBag.nonAtm = repository.GetEncashmentNonAmount(code);
            ViewBag.Permission = String.IsNullOrEmpty(permission) ? "0" : permission;
            return PartialView(model);
        }

        public ActionResult EncashmentList()
        {
            repository.CreateCollectOpper();
            return View();
        }

        public JsonResult EncashmentList_Read([DataSourceRequest]DataSourceRequest request)
        {
            DataSourceResult result = repository.EncashmentList().ToDataSourceResult(request);
            return Json(result, JsonRequestBehavior.AllowGet);
        }
    }
}