using System.Web.Http;
using System.Web.Mvc;
using BarsWeb.Areas.BaseRates.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.BaseRates.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;

namespace BarsWeb.Areas.BaseRates
{
    public class BaseRatesAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "BaseRates";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.Routes.MapHttpRoute(
                name:  AreaName + "_api",
                routeTemplate: "api/" + AreaName + "/{controller}/{action}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );

            context.MapRoute(
                name: AreaName + "_lang",
                url: "{lang}/"+AreaName+"/{controller}/{action}/{id}",
                defaults: Constants.DefaultRoute, 
                constraints: new { lang = Constants.RouteLang }
            );

            context.MapRoute(
                AreaName + "_default",
                AreaName+"/{controller}/{action}/{id}",
                Constants.DefaultRoute
            );
            
            //все несистемные привязки
            BindAreaDI();
        }

        private void BindAreaDI()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            ninjectKernel.Bind<IBaseRatesRepository>().To<BaseRatesRepository>();
        }
    }
}