using System.Web.Http;
using System.Web.Mvc;
using BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Implementation;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;

namespace BarsWeb.Areas.Cdm
{
    public class CdmAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "Cdm";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.Routes.MapHttpRoute(
                name: AreaName + "_api",
                routeTemplate: "CDMService/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );

            context.Routes.MapHttpRoute(
    name: AreaName + "_api2",
    routeTemplate: "api/" + AreaName + "/{controller}/{id}",
    defaults: new { id = RouteParameter.Optional }
); 

            context.MapRoute(
                name: AreaName + "_lang",
                url: "{lang}/" + AreaName + "/{controller}/{action}/{id}",
                defaults: Constants.DefaultRoute, //new { controller = "Home", action = "Index", id = UrlParameter.Optional },
                constraints: new { lang = Constants.RouteLang }
            );
            context.MapRoute(
                AreaName + "_default",
                AreaName + "/{controller}/{action}/{id}",
                Constants.DefaultRoute// new {controller = "Home", action = "Index", id = UrlParameter.Optional }
            );

            //все несистемные привязки
            BindAreaDI();
        }

        private void BindAreaDI()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            ninjectKernel.Bind<ICdmRepository>().To<CdmRepository>();
            ninjectKernel.Bind<IBanksRepository>().To<BanksRepository>();
        }
    }
}