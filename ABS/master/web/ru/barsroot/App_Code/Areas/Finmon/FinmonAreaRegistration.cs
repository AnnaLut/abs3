using System.Web.Http;
using System.Web.Mvc;
using BarsWeb.Areas.Finmom.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Finmom.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;

namespace BarsWeb.Areas.Finmon
{
    public class FinmonAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "Finmon";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.Routes.MapHttpRoute(
                name:  AreaName + "_api",
                routeTemplate: "api/" + AreaName + "/{controller}/{id}",
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
            ninjectKernel.Bind<IFinmonRepository>().To<FinmonRepository>();
        }
    }
}