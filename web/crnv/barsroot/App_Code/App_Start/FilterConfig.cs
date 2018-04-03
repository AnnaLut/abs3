using System;
using System.Web;
using System.Web.Mvc;

namespace barsroot
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }

    public class AuthorizeSessionAttribute : ActionFilterAttribute
    {
        const string TRACEASP = "ASP.Trace.Mode";
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            
            if (Bars.Configuration.ConfigurationSettings.CustomSettings("traceSettings")[TRACEASP] == "On")
            {
                System.Diagnostics.Debug.Listeners.Clear();
                System.Diagnostics.Debug.Listeners.Add(new Bars.Application.TraceListener());
                System.Diagnostics.Debug.Write("On");
            }

            Bars.Classes.OraConnector.Handler.CheckAccessForPage();

        }

    }

    /// <summary>
    /// фільтер для перевірки авторизації на AJAX запросах
    /// </summary>
    public class AjaxAuthorizeAttribute : AuthorizeAttribute
    {
        protected override void HandleUnauthorizedRequest(AuthorizationContext context)
        {
            if (context.HttpContext.Request.IsAjaxRequest())
            {
                var urlHelper = new UrlHelper(context.RequestContext);
                context.HttpContext.Response.StatusCode = 403;
                context.Result = new JsonResult
                {
                    Data = new
                    {
                        Error = "NotAuthorized",
                        LogOnUrl = urlHelper.Action("LogOn", "Account")
                    },
                    JsonRequestBehavior = JsonRequestBehavior.AllowGet
                };
            }
            else
            {
                base.HandleUnauthorizedRequest(context);
            }
        }
    }
    /// <summary>
    /// филитр для проверки параметра partinal в запросе
    /// если параметер существует и его значение == true тогда в ответ уйдет частичное представление
    /// дополнительно в представлении необходимо обработать ViewBag.IsPartinal
    /// </summary>
    public class IsPartinalRequestAttribute : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            filterContext.Controller.ViewBag.IsPartinal = false; 
            var param = filterContext.RequestContext.HttpContext.Request.Params["partinal"];
            if (param!=null)
            {
                if (Convert.ToBoolean(param)==true)
                {
                    filterContext.Controller.ViewBag.IsPartinal = true;
                }
            }
            
        }
    }

}