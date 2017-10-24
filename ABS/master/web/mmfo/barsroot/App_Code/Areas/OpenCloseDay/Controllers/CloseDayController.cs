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
    public class CloseDayController : ApplicationController
    {
        private readonly IDateOperation _operation;

        public CloseDayController(IDateOperation operation)
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
                ViewBag.date = date;
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

        public ActionResult CloseDay(string currentDate)
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
    }
}