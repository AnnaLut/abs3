using System.Web.Http;
using System.Web.Mvc;
using BarsWeb.Infrastructure.Repository;

namespace BarsWeb.Areas.MyCard
{
    public class MyCardAreaRegistration :AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "MyCard";
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
                new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
            //BindAreaDi();
        }

        private void BindAreaDi()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            //ninjectKernel.Bind<IAdvertisingRepository>().To<AdvertisingRepository>();
        }
    }

}
