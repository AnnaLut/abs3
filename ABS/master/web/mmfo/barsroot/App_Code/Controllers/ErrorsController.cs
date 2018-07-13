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
                    model = System.Web.HttpContext.Current.Application["AppError"];
                if (model == null)
                    model = new Exception("Помилка незнайдена");
                ViewBag.FatalError = 0;
                return View(model);
            }

            if (type.ToUpper() == "HTTP_STATUS_REQUEST_TIMEOUT")
            {
                var model = System.Web.HttpContext.Current.Session["AppError"];
                if (model == null)
                    model = System.Web.HttpContext.Current.Application["AppError"];
                if (model == null)
                    model = new Exception("Помилка незнайдена");
                ViewBag.FatalError = 1;
                System.Web.HttpContext.Current.Response.StatusCode = 408;
                return View(model);
            }

            if (type.ToUpper()=="FATAL")
            {
                //ложим сайт (заявка COBUMMFO-8553)
                System.Web.HttpContext.Current.Response.StatusCode = 408;

                Response.Flush();
                Response.Close();
                Response.End();
                return null;
            }

            var result= View();
            return result;
        }
    }
}