using System.Web.Http;
using System.Web.Mvc;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;

namespace BarsWeb.Areas.TechWorks
{
    public class TechWorksAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "TechWorks";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.Routes.MapHttpRoute(
                name: AreaName + "_api",
                routeTemplate: "api/" + AreaName + "/{controller}/{action}/{id}",
               defaults: new
               {
                   AreaName = "TechWorks",
                   controller = RouteParameter.Optional,
                   action = RouteParameter.Optional,
                   id = UrlParameter.Optional
               }
            );
            context.MapRoute(
                    name: AreaName + "_lang",
                    url: "{lang}/" + AreaName + "/{controller}/{action}/{id}",
                    defaults: new
                    {
                        controller = "Home",
                        action = "Index",
                        id = UrlParameter.Optional
                    },
                    constraints: new { lang = Constants.RouteLang }
                );
            context.MapRoute(
                AreaName + "_default",
                AreaName + "/{controller}/{action}/{id}",
                new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );

            BindAreaDI();
        }

        private void BindAreaDI()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            //ninjectKernel.Bind<ISchemeBuilderRepository>().To<SchemeBuilderRepository>();
        }
    }
}