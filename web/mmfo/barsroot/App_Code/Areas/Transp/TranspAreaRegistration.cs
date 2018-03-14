using BarsWeb.Areas.Transp.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Transp.Infrastructure.DI.Implementation;
using BarsWeb.Infrastructure.Repository;
using BarsWeb.Infrastructure;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Routing;

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
                routeTemplate: "api/" + AreaName + "/{controller}/{action}/{req_type}",
                defaults: new { req_type = UrlParameter.Optional },
                constraints: new { httpMethod = new HttpMethodConstraint("POST") }
            );

                context.Routes.MapHttpRoute(
                name: AreaName + "_api_get",
                routeTemplate: "api/" + AreaName + "/{controller}/{req_type}",
                defaults: new { req_type = UrlParameter.Optional },
                constraints: new { httpMethod = new HttpMethodConstraint("GET") }
            );

            /*context.Routes.MapHttpRoute(
                name: AreaName + "_api",
                routeTemplate: "api/" + AreaName + "/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );*/

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