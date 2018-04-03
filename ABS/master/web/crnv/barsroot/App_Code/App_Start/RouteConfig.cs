using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Routing;

namespace barsroot
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");
            routes.IgnoreRoute("{controller}/{resource}.axd/{*pathInfo}");
            routes.IgnoreRoute("{controller}/{action}/{resource}.axd/{*pathInfo}");
            routes.IgnoreRoute("{controller}/{action}/{id}/{resource}.axd/{*pathInfo}");

            routes.IgnoreRoute("{resource}.aspx/{*pathInfo}");
            routes.IgnoreRoute("{controller}/{resource}.aspx/{*pathInfo}");
            routes.IgnoreRoute("{controller}/{action}/{resource}.aspx/{*pathInfo}");
            routes.IgnoreRoute("{controller}/{action}/{id}/{resource}.aspx/{*pathInfo}");

            /*routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );*/

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}