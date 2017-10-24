using System.Web.Http;
using BarsWeb.Infrastructure;
using System.Web.Mvc;
using BarsWeb.Areas.SuperVisor.Infrastructure.DI.Abstract;
using BarsWeb.Areas.SuperVisor.Infrastructure.DI.Infrastructure;
using BarsWeb.Infrastructure.Repository;

namespace BarsWeb.Areas.SuperVisor
{
    public class SuperVisorAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get { return "SuperVisor"; }
        }
        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.Routes.IgnoreRoute("supervisor/dialog.aspx/{*pathInfo}");

            context.MapRoute(
                name: AreaName + "_lang",
                url: "{lang}/" + AreaName + "/{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional },
                constraints: new { lang = Constants.RouteLang }
            );

            context.Routes.MapHttpRoute(
                name: AreaName + "_api",
                routeTemplate: "api/" + AreaName + "/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );

            context.MapRoute(
                AreaName + "_default",
                AreaName + "/{controller}/{action}/{id}",
                new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );

            // dependencies : 
            BindAreaDI();
        }

        private void BindAreaDI()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            ninjectKernel.Bind<IBalanceRepository>().To<BalanceRepository>();
        }
    }
}