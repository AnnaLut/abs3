using System.Web.Http;
using System.Web.Mvc;
using BarsWeb.Areas.Reference.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Reference.Infrastructure.DI.Implamentation;
using BarsWeb.Areas.Reference.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Reference.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;

namespace BarsWeb.Areas.Reference
{
    public class DocAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "Reference";
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
                defaults: Constants.DefaultRoute, //new { controller = "Home", action = "Index", id = UrlParameter.Optional },
                constraints: new { lang = Constants.RouteLang }
            );
            context.MapRoute(
                AreaName + "_default",
                AreaName+"/{controller}/{action}/{id}",
                Constants.DefaultRoute// new {controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
            
            //все несистемные привязки
            BindAreaDi();
        }

        private void BindAreaDi()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            ninjectKernel.Bind<IReferenceModel>().To<ReferenceModel>();
            ninjectKernel.Bind<IHandBookRepository>().To<HandBookRepository>();
            ninjectKernel.Bind<IHandBookMetadataRepository>().To<HandBookMetadataRepository>();
            ninjectKernel.Bind<IUtils>().To<Infrastructure.DI.Implamentation.Utils>();
        }
    }
}