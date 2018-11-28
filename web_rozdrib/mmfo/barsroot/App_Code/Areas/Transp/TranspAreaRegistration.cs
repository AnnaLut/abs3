using BarsWeb.Areas.Transp.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Transp.Infrastructure.DI.Implementation;
using BarsWeb.Infrastructure.Repository;
using BarsWeb.Infrastructure;
using System.Web.Http;
using System.Web.Mvc;

namespace BarsWeb.Areas.Transp
{
    public class TranspAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "Transp";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.Routes.MapHttpRoute(
                name: AreaName + "_api_post",
                routeTemplate: "api/" + AreaName + "/{controller}/{req_type}/{req_act}",
                defaults: new { req_type = UrlParameter.Optional, req_act = UrlParameter.Optional }
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
            //ninjectKernel.Bind<ITranspModel>().To<TranspModel>();
            ninjectKernel.Bind<ITranspRepository>().To<TranspRepository>();
        }
    }
}