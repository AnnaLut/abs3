using System.Web.Mvc;
using BarsWeb.Areas.PC.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;
using System.Web.Http;
using BarsWeb.Areas.PC.Infrastructure.Repository.DI.Implementation;

namespace BarsWeb.Areas.PC
{
    public class PCAreaRegisration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "PC";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                name: AreaName + "_lang",
                url: "{lang}/" + AreaName + "/{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional },
                constraints: new { lang = Constants.RouteLang }
            );
            context.MapRoute(
                AreaName + "_default",
                AreaName + "/{controller}/{action}/{id}",
                new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );

            context.Routes.MapHttpRoute(
                name: AreaName + "Action_api",
                routeTemplate: "api/" + AreaName + "/{controller}/{action}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );
            //все несистемные привязки
            BindAreaDI();
            //RegisterBundles(BundleTable.Bundles);
        }
        private void BindAreaDI()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            ninjectKernel.Bind<IPCRepository>().To<PCRepository>();
        }

    }
}
