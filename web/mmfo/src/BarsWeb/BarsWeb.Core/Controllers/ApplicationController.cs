using System;
using System.Globalization;
using System.IO;
using System.Threading;
using System.Web.Mvc;
using BarsWeb.Core.Models.Json;

namespace BarsWeb.Core.Controllers
{
    public abstract class ApplicationController : Controller 
    {
        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            string lang = Convert.ToString(filterContext.RequestContext.RouteData.Values["lang"]); 
            ViewBag.lang = lang;
            if (string.IsNullOrWhiteSpace(lang))
            {
                lang = "uk";
            }
            /*if (Request.UserLanguages != null)
            {

                // Validate culture name
                string cultureName = Request.UserLanguages[0]; // obtain it from HTTP header AcceptLanguages
                if (!string.IsNullOrEmpty(cultureName))
                {
                    // Modify current thread's culture            
                    lang = cultureName;
                }
            }*/
            Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(lang);
            Thread.CurrentThread.CurrentUICulture = CultureInfo.CreateSpecificCulture(lang);
            base.OnActionExecuting(filterContext);
        }
        protected JsonResult ErrorJson(string message)
        {
            return Json(new JsonResponse(JsonResponseStatus.Error, message), JsonRequestBehavior.AllowGet);
        }

        protected JsonResult ErrorJson(string message, object data)
        {
            return ErrorJson(new JsonResponse(JsonResponseStatus.Error, message, data));
        }
        protected JsonResult ErrorJson(Exception exception)
        {
            var res = new JsonResponse(JsonResponseStatus.Error)
            {
                Message = exception.InnerException == null ? exception.Message : exception.InnerException.Message
            };
            return ErrorJson(res);
        }
        protected JsonResult ErrorJson(JsonResponse response)
        {
            return Json(response, JsonRequestBehavior.AllowGet);
        }

        protected string RenderPartialViewToString(string viewName, object model)
        {
            if (string.IsNullOrEmpty(viewName))
                viewName = ControllerContext.RouteData.GetRequiredString("action");

            ViewData.Model = model;

            using (var sw = new StringWriter())
            {
                ViewEngineResult viewResult = ViewEngines.Engines.FindPartialView(ControllerContext, viewName);
                var viewContext = new ViewContext(ControllerContext, viewResult.View, ViewData, TempData, sw);
                viewResult.View.Render(viewContext, sw);

                return sw.GetStringBuilder().ToString();
            }
        }
        [HttpPost]
        public ActionResult ConvertBase64ToFile(string base64, string contentType = "attachment", string fileName = "file")
        {
            if (string.IsNullOrEmpty(fileName))
            {
                fileName = "file";
            }
            if (string.IsNullOrEmpty(contentType))
            {
                contentType = "attachment";
            }
            var fileContents = Convert.FromBase64String(base64);

            return File(fileContents, contentType, fileName);
        }
    }
}