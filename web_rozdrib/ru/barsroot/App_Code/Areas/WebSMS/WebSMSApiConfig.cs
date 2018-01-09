using System.Web.Http;
using System.Web.Mvc;
using BarsWeb.Areas.Reference.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Reference.Infrastructure.DI.Implamentation;
using BarsWeb.Areas.Reference.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Reference.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;

namespace BarsWeb.Areas.WebSMS
{
    public class WebSMSAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "WebSMS";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.Routes.MapHttpRoute(
                name: AreaName + "_api",
                routeTemplate: "api/" + AreaName + "/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );

            context.MapRoute(
                name: AreaName + "_lang",
                url: "{lang}/" + AreaName + "/{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional },
                constraints: new { lang = Constants.RouteLang }
            );
            context.MapRoute(
                AreaName + "_default",
                AreaName + "/{controller}/{action}/{id}",
                new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );

            //все несистемные привязки
        //    BindAreaDI();
        }

       /* private void BindAreaDI()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            ninjectKernel.Bind<ICreditFactoryModel>().To<CreditFactoryModel>();
            ninjectKernel.Bind<ICreditFactoryRepository>().To<CreditFactoryRepository>();
        }*/
    }
}