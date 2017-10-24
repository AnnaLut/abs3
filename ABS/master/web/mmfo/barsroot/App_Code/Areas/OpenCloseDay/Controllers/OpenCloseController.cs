using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Web.Mvc;
using BarsWeb.Areas.OpenCloseDay.Infrastructure.DI.Abstract;
using BarsWeb.Controllers;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.OpenCloseDay.Controllers
{
    [CheckAccessPage]
    [Authorize]
    public class OpenCloseController : ApplicationController
    {
        private readonly IDateOperation _operation;

        public OpenCloseController(IDateOperation operation)
        {
            _operation = operation;
        }

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult CurrentDate(string passValue)
        {
            if (string.IsNullOrEmpty(passValue) || !_operation.CheckPass(passValue))
                return Json(new { State = "Error", Error = "Невірний пароль" }, JsonRequestBehavior.AllowGet);
            try
            {
                var date = _operation.GetCurrentDate();
                var date_new = _operation.GetNetDate();

                ViewBag.date_old = date;
                ViewBag.date_new = date_new;

                if (string.IsNullOrEmpty(date))
                {
                    return Json(new { State = "Error", Error = "Банківський день не відкритий" }, JsonRequestBehavior.AllowGet);
                }
                return PartialView();
            }
            catch (Exception ex)
            {
                return Json(new { State = "Error", Error = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult OPSeitings(string dayclose, string dayopen, string runId)
        {
            ViewBag.CloseDate = dayclose;
            ViewBag.OpenDate = dayopen;
            ViewBag.RunId = runId;

            return View();
        }

        public ActionResult OPHistory()
        {
            return View();
        }

        public ActionResult OPStageDirectory()
        {
            ViewBag.closeDate = _operation.GetCurrentDate();
            return View();
        }

        public ActionResult OPMonitoring(int deploy_id)
        {
            ViewBag.deploy_id = deploy_id;
            return View();
        }

        public ActionResult OpenClose(string currentDate)
        {
            if (!string.IsNullOrEmpty(currentDate))
            {
                try
                {
                    if (currentDate.Contains(_operation.GetCurrentDate()))
                    {
                        _operation.CloseBankDay();
                        //RedirectToAction("FuncClose","FuncList");
                        return Json(new { State = "OK" }, JsonRequestBehavior.AllowGet);
                    }
                }
                catch (Exception ex)
                {
                    return Json(new { State = "Error", Error = ex.Message }, JsonRequestBehavior.AllowGet);
                }
            }
            return Json(new { State = "Error", Error = "Немає банківської дати" }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult TabViev(string ref_id)
        {
            ViewBag.ref_id = ref_id;
            return View();
        }
    }
}