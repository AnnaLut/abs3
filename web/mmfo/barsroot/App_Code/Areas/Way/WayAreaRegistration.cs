using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using BarsWeb.Areas.Way.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Way.Infrastructure.DI.Implementation;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;


namespace BarsWeb.Areas.Way
{
    public class WayAreaRegistration : AreaRegistration
    {
        public override string AreaName 
        {
            get { return "Way"; }
        }
        public override void RegisterArea(AreaRegistrationContext context) 
        {
            context.Routes.IgnoreRoute("admin/dialog.aspx/{*pathInfo}");
            context.MapRoute(
                name: AreaName + "_lang",
                url: "{lang}/" + AreaName + "/{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional },
                constraints: new { lang = Constants.RouteLang }
            );

            context.Routes.MapHttpRoute(
               name: AreaName + "_api",
               routeTemplate: "api/" + AreaName + "/{controller}/{action}/{id}",
               defaults: new { id = RouteParameter.Optional }
            );

            context.MapRoute(
                    AreaName + "_default",
                    AreaName+"/{controller}/{action}/{id}",
                    new {controller = "Home", action = "Index", id = UrlParameter.Optional }
                );

            BindAreaDI();
            //RegisterBundles(BundleTable.Bundles);
        }
        private void BindAreaDI() {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            ninjectKernel.Bind<IWayRepository>().To<WayRepository>();
            ninjectKernel.Bind<IInstantCardsRepository>().To<InstantCardsRepository>();
            ninjectKernel.Bind<IInstallmentRepository>().To<InstallmentRepository>();
        }
    }    
}