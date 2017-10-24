using System.Web.Mvc;
using System.Web.Routing;

namespace BarsWeb
{
    public class RouteConfig
    {
        public static string UrlPrefix { get { return "api"; } }
        public static string UrlPrefixRelative { get { return "~/api"; } }
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.js/{*pathInfo}");
            routes.IgnoreRoute("{controller}/{resource}.js/{*pathInfo}");
            routes.IgnoreRoute("{controller}/{action}/{resource}.js/{*pathInfo}");
            routes.IgnoreRoute("{controller}/{action}/{id}/{resource}.js/{*pathInfo}");

            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");
            routes.IgnoreRoute("{controller}/{resource}.axd/{*pathInfo}");
            routes.IgnoreRoute("{controller}/{action}/{resource}.axd/{*pathInfo}");
            routes.IgnoreRoute("{controller}/{action}/{id}/{resource}.axd/{*pathInfo}");

            routes.IgnoreRoute("{resource}.aspx/{*pathInfo}");
            routes.IgnoreRoute("{controller}/{resource}.aspx/{*pathInfo}");
            routes.IgnoreRoute("{controller}/{action}/{resource}.aspx/{*pathInfo}");
            routes.IgnoreRoute("{controller}/{action}/{id}/{resource}.aspx/{*pathInfo}");

            routes.IgnoreRoute("{resource}.asmx/{*pathInfo}");
            routes.IgnoreRoute("{controller}/{resource}.asmx/{*pathInfo}");
            routes.IgnoreRoute("{controller}/{action}/{resource}.asmx/{*pathInfo}");
            routes.IgnoreRoute("{controller}/{action}/{id}/{resource}.asmx/{*pathInfo}");

            /*routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );*/
           
            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional },//Constants.DefaultRoute
                namespaces: new[] { "BarsWeb.Controllers","Controllers" }
            );
        }
    }
}