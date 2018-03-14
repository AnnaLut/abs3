using BarsWeb.Infrastructure.Repository;
using BarsWeb.Infrastructure;
using System.Web.Http;
using System.Web.Mvc;
using BarsWeb.Areas.F601.Infrastructure.DI.Abstract;

namespace BarsWeb.Areas.F601
{
    public class F601AreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "F601";
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
                AreaName + "_default",
                AreaName + "/{controller}/{action}/{id}",
                Constants.DefaultRoute
            );
            
            //все несистемные привязки
            BindAreaDi();
        }

        private void BindAreaDi()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            ninjectKernel.Bind<IF601Repository>().To<F601Repository>();
        }
    }
}