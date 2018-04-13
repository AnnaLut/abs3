using System;
using System.IO.Compression;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http.Controllers;
using System.Web.Mvc;
using BarsWeb.Infrastructure;

using System.Linq;
using BarsWeb.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Infrastructure.Repository.DI.Implementation;

namespace BarsWeb
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
    /// <summary>
    /// перевірка авторизації
    /// </summary>
    public class AuthorizeUserAttribute : AuthorizeAttribute
    {
        protected override bool AuthorizeCore(HttpContextBase httpContext)
        {
            var isAuthorized = base.AuthorizeCore(httpContext);
            if (!isAuthorized)
            {
                httpContext.Response.Redirect(Constants.LoginPageUrl);
                return false;
            }
            return true;
        }
    }

    public class AuthorizeApiAttribute : System.Web.Http.AuthorizeAttribute
    {
        private string _message = "";
        protected override bool IsAuthorized(HttpActionContext context)
        {
            //context.Response.Headers.Add("Access-Control-Allow-Origin","*" );
            var headers = context.Request.Headers;
            var isAuthorized = base.IsAuthorized(context);
            if (!isAuthorized)
            {
                if (headers.Authorization != null)
                {
                    string scheme = headers.Authorization.Scheme.ToUpper();
                    if (scheme == "BASIC" || scheme == "HASHPASSWORD")
                    {
                        string userName;
                        string password;
                        if (!string.IsNullOrEmpty(headers.Authorization.Parameter))
                        {
                            var parametrer = Convert.FromBase64String(headers.Authorization.Parameter);
                            var array = System.Text.Encoding.Default.GetString(parametrer).Split(':');
                            userName = array[0];
                            password = array[1];
                        }
                        else
                        {
                            userName = headers.GetValues("UserName").FirstOrDefault();
                            password = headers.GetValues("Password").FirstOrDefault();
                        }
                        
                        var repository = new AccountRepository(new AppModel());
                        AuthorizedStatus register;
                        if (scheme == "BASIC")
                        {
                            register = repository.Authorize(userName, password);
                        }
                        else
                        {
                            register = repository.AuthorizeByHash(userName, password);
                        }
                        if (register.Status == AuthorizedStatusCode.Ok || 
                            register.Status == AuthorizedStatusCode.SelectDate)
                        {
                            return true;
                        }
                        _message = register.Message;
                    }
                    if (HttpContext.Current.User.Identity.IsAuthenticated)
                    {
                        return true;
                    }
                }

                return false;
            }
            return true;
        }
        protected override void HandleUnauthorizedRequest(HttpActionContext actionContext)
        {
            if (actionContext == null)
            {
                throw new ArgumentNullException("actionContext");
            }

            actionContext.Response = 
                actionContext.ControllerContext.Request.CreateErrorResponse(
                    HttpStatusCode.Unauthorized, 
                    string.IsNullOrEmpty(_message) ? "Користувач не авторизований": _message);
        }
    }

    /// <summary>
    /// Перевірити доступ до сторінки
    /// </summary>
    public class CheckAccessPageAttribute : ActionFilterAttribute
    {

        const string Traceasp = "ASP.Trace.Mode";
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (Bars.Configuration.ConfigurationSettings.CustomSettings("traceSettings")[Traceasp] == "On")
            {
                System.Diagnostics.Debug.Listeners.Clear();
                System.Diagnostics.Debug.Listeners.Add(new Bars.Application.TraceListener());
                System.Diagnostics.Debug.Write("On");
            }

            Bars.Classes.OraConnector.Handler.CheckAccessForPage();
        }

    }
    /// <summary>
    /// compress to gzip
    /// </summary>
    public class CompressFilter : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            HttpRequestBase request = filterContext.HttpContext.Request;

            string acceptEncoding = request.Headers["Accept-Encoding"];

            if (string.IsNullOrEmpty(acceptEncoding)) return;

            acceptEncoding = acceptEncoding.ToUpperInvariant();

            HttpResponseBase response = filterContext.HttpContext.Response;

            if (acceptEncoding.Contains("GZIP"))
            {
                response.AppendHeader("Content-encoding", "gzip");
                response.Filter = new GZipStream(response.Filter, CompressionMode.Compress);
            }
            else if (acceptEncoding.Contains("DEFLATE"))
            {
                response.AppendHeader("Content-encoding", "deflate");
                response.Filter = new DeflateStream(response.Filter, CompressionMode.Compress);
            }
        }
    }

    /// <summary>
    /// cashe filter attribute
    /// </summary>
    public class CacheFilterAttribute : ActionFilterAttribute
    {
        /// <summary>
        /// Gets or sets the cache duration in seconds. The default is 10 seconds.
        /// </summary>
        /// <value>The cache duration in seconds.</value>
        public int Duration
        {
            get;
            set;
        }

        public CacheFilterAttribute()
        {
            Duration = 10;
        }
        public override void OnActionExecuted(ActionExecutedContext filterContext)
        {
            if (Duration <= 0) return;

            HttpCachePolicyBase cache = filterContext.HttpContext.Response.Cache;
            TimeSpan cacheDuration = TimeSpan.FromSeconds(Duration);

            cache.SetCacheability(HttpCacheability.Public);
            cache.SetExpires(DateTime.Now.Add(cacheDuration));
            cache.SetMaxAge(cacheDuration);
            cache.AppendCacheExtension("must-revalidate, proxy-revalidate");
        }
    }








    [Obsolete]
    public class DeleteTmpFileAttribute : ActionFilterAttribute
    {
        public override void OnResultExecuted(ResultExecutedContext filterContext)
        {
            base.OnResultExecuted(filterContext);
            var fileName = filterContext.Controller.ViewBag.TmpFileName;
            if (fileName != null)
            {
                try
                {
                    System.IO.File.Delete(fileName);
                }
                catch (Exception e)
                {
                    //гасимо помилки
                }
                
            }
        }
    }

    /// <summary>
    /// фільтер для перевірки авторизації на AJAX запросах
    /// </summary>
    [Obsolete]
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
                        LogOnUrl = urlHelper.Action("LogIn", "Account")
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
    /// филитр для проверки параметра partial в запросе
    /// если параметер существует и его значение == true тогда в ответ уйдет частичное представление
    /// дополнительно в представлении необходимо обработать ViewBag.IsPartial
    /// </summary>
    [Obsolete]
    public class IsPartialRequestAttribute : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            filterContext.Controller.ViewBag.IsPartial = false; 
            var param = filterContext.RequestContext.HttpContext.Request.Params["partial"];
            if (param!=null)
            {
                if (Convert.ToBoolean(param))
                {
                    filterContext.Controller.ViewBag.IsPartial = true;
                }
            }
            
        }
    }

}

/*namespace MyProject.Infrastructure.WebAPI
{
    using System;
    using System.Globalization;
    using System.Net.Http.Headers;
    using System.Linq;
    using System.Web.Http.ValueProviders;
    using Newtonsoft.Json;
    public class HeaderValueProvider<T> : IValueProvider where T : class
    {
        private const string HeaderPrefix = "X-";
        private readonly HttpRequestHeaders _headers;

        public HeaderValueProvider(HttpRequestHeaders headers)
        {
            _headers = headers;
        }

        public bool ContainsPrefix(string prefix)
        {
            var contains = _headers.Any(h => h.Key.Contains(HeaderPrefix + prefix));
            return contains;
        }

        public ValueProviderResult GetValue(string key)
        {
            var contains = _headers.Any(h => h.Key.Contains(HeaderPrefix + key));
            if (!contains)
                return null;

            var value = _headers.GetValues(HeaderPrefix + key).First();
            var obj = JsonConvert.DeserializeObject<T>(value,
              new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });
            return new ValueProviderResult(obj, value, CultureInfo.InvariantCulture);
        }
    }
}*/