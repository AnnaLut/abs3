using System.Web.Http;
using System.Web.Mvc;
using BarsWeb.Areas.Mbdk.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Mbdk.Infrastructure.DI.Implementation;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;

namespace BarsWeb.Areas.Mbdk
{
    /// <summary>
    /// Summary description for CrkrAreaRegistration
    /// </summary>
    public class MbdkAreaRegistration : AreaRegistration
    {


        public override string AreaName
        {
            get
            {
                return "Mbdk";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.Routes.MapHttpRoute(
                name: AreaName + "_api",
                routeTemplate: "api/" + AreaName + "/{controller}/{action}/{id}",
               defaults: new
               {
                   AreaName = "Mbdk",
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
            BindAreaDi();
        }

        private void BindAreaDi()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            ninjectKernel.Bind<IDealRepository>().To<DealRepository>();
            ninjectKernel.Bind<INostroRepository>().To<NostroRepository>();

        }
    }

}