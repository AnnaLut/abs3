using BarsWeb.Areas.InsUi.Infrastructure.DI.Abstract;
using BarsWeb.Areas.InsUi.Infrastructure.DI.Implementation;
using BarsWeb.Infrastructure.Repository;
using BarsWeb.Infrastructure;
using System.Web.Http;
using System.Web.Mvc;

namespace BarsWeb.Areas.InsUi
{
    public class InsAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "InsUi";
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
            ninjectKernel.Bind<IInsModel>().To<InsModel>();
            ninjectKernel.Bind<IInsRepository>().To<InsRepository>();
        }
    }
}