using System.Web.Http;
using System.Web.Mvc;
using AttributeRouting.Web.Http.WebHost;
using BarsWeb.Areas.Reporting.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Reporting.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;

namespace BarsWeb.Areas.Reporting
{
    public class ReportingAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "Reporting";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            GlobalConfiguration.Configuration.Routes.MapHttpAttributeRoutes();

            context.Routes.MapHttpRoute(
                name:  AreaName + "_api",
                routeTemplate: "api/" + AreaName + "/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );

            context.MapRoute(
                name: AreaName + "_lang",
                url: "{lang}/"+AreaName+"/{controller}/{action}/{id}",
                defaults: Constants.DefaultRoute, //new { controller = "Home", action = "Index", id = UrlParameter.Optional },
                constraints: new { lang = Constants.RouteLang }
            );
            context.MapRoute(
                AreaName + "_default",
                AreaName+"/{controller}/{action}/{id}",
                Constants.DefaultRoute// new {controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
            
            //все несистемные привязки
            BindAreaDI();
        }

        private void BindAreaDI()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            ninjectKernel.Bind<IReportingModel>().To<ReportingModel>();
            ninjectKernel.Bind<INbuRepository>().To<NbuRepository>();
        }
    }
}