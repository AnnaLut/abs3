using System;
using System.Globalization;
using System.Web.Mvc;
using BarsWeb.Areas.OpenCloseDay.Infrastructure.DI.Abstract;
using BarsWeb.Controllers;

namespace BarsWeb.Areas.OpenCloseDay.Controllers
{
    public class OpenDayController : ApplicationController
    {

        private readonly IDateOperation _operation;

        public OpenDayController(IDateOperation operation)
        {
            _operation = operation;
        }
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult CreateDate(string passValue)
        {
            if (string.IsNullOrEmpty(passValue) || !_operation.CheckPass(passValue))
                return Json(new { State = "Error", Error = "Невірний пароль" }, JsonRequestBehavior.AllowGet);
            try
            {
                var nextDate = _operation.GetNetDate();
                ViewBag.date = nextDate;
                return PartialView();
            }
            catch (Exception ex)
            {
                return Json(new { State = "Error", Error = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult CreateDay(string currentDate)
        {
            if (!string.IsNullOrEmpty(currentDate))
            {
                try
                {
                    DateTime bankdate;
                    if (DateTime.TryParseExact(currentDate,"dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out bankdate))
                    {
                        _operation.CreateDay(bankdate);
                        //RedirectToAction("FuncOpen", "FuncList");
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
