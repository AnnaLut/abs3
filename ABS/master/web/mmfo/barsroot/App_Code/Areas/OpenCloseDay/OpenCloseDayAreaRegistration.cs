using System.Web.Http;
using System.Web.Mvc;
using BarsWeb.Areas.OpenCloseDay.Infrastructure.DI.Abstract;
using BarsWeb.Areas.OpenCloseDay.Infrastructure.DI.Implementation;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;

namespace BarsWeb.Areas.OpenCloseDay
{
    /// <summary>
    /// Summary description for CrkrAreaRegistration
    /// </summary>
    public class OpenCloseDayAreaRegistration : AreaRegistration
    {


        public override string AreaName
        {
            get
            {
                return "OpenCloseDay";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.Routes.MapHttpRoute(
                name: AreaName + "_api",
                routeTemplate: "api/" + AreaName + "/{controller}/{action}/{id}",
               defaults: new
               {
                   AreaName = "OpenCloseDay",
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
            ninjectKernel.Bind<IDateOperation>().To<DateOperation>();
            ninjectKernel.Bind<IFuncListOperation>().To<FuncListOperation>();
            ninjectKernel.Bind<IStatisticsOperations>().To<StatisticsOperations>();
        }
    }

}