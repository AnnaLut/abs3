using BarsWeb.Areas.PfuServer.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.PfuServer.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Areas.PfuSync.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.PfuSync.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;
using System.Web.Http;
using System.Web.Mvc;

namespace BarsWeb.Areas.PfuServer
{
    public class PfuServerAreaRegistration : AreaRegistration
    {

        public override string AreaName
        {
            get { return "PfuServer"; }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
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
            BindAreaDI();
        }
        private void BindAreaDI()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            ninjectKernel.Bind<IPfuServerRepository>().To<PfuServerRepository>();
            ninjectKernel.Bind<IPfuSyncGZipRepository>().To<PfuSyncGZipRepository>();

            
        }
    }

}