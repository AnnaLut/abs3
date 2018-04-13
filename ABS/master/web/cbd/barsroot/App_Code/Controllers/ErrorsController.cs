using System;
using System.Web.Mvc;

namespace BarsWeb.Controllers
{
    public class ErrorsController : ApplicationController
    {
        public ActionResult Index(string type)
        {
            if (type.ToUpper() == "APPERROR")
            {
                Response.StatusDescription = "BRS-500";
                var model = System.Web.HttpContext.Current.Session["AppError"];
                if (model == null)
                {
                    model = new Exception("Помилка незнайдена");
                }
                return View(model);
            }
            return View();
        }
    }
}