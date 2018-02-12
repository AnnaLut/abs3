using System.Web.Http;
using System.Web.Mvc;
using BarsWeb.Areas.ReserveAccs.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.ReserveAccs.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;
using AttributeRouting.Web.Http.WebHost;

namespace BarsWeb.Areas.ReserveAccs
{
    public class ReserveAccsAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "ReserveAccs";
            }
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
                AreaName + "/{controller}/{action}/{id}",
                new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
            //все несистемные привязки
            BindAreaDI();
        }

        private void BindAreaDI()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            ninjectKernel.Bind<IReserveAccsRepository>().To<ReserveAccsRepository>();
        }
    }
}