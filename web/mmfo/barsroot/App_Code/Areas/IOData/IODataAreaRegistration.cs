using System.Web.Http;
using System.Web.Mvc;
using BarsWeb.Areas.IOData.Infrastructure.DI.Abstract;
using BarsWeb.Areas.IOData.Infrastructure.DI.Implementation;
using BarsWeb.Infrastructure.Repository;
using BarsWeb.Infrastructure;

namespace BarsWeb.Areas.IOData
{
    public class IODataAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "IOData";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.Routes.MapHttpRoute(
                name: AreaName + "_api",
                routeTemplate: "api/" + AreaName + "/{controller}/{action}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );

            context.MapRoute(
                AreaName + "_default",
                AreaName + "/{controller}/{action}/{id}",
                Constants.DefaultRoute
            );

            BindAreaDi();
        }

        private void BindAreaDi()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            ninjectKernel.Bind<IIODataRepository>().To<IODataRepository>();
            ninjectKernel.Bind<IStatisticRepozitory>().To<StatisticRepozitory>();
        }
    }
}