using System.Web.Http;
using System.Web.Mvc;
using BarsWeb.Areas.Crkr.Infrastructure.DI.Implementation;
using BarsWeb.Areas.Crkr.Infrastructure.DI.Abstract;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;

namespace BarsWeb.Areas.Crkr
{
    /// <summary>
    /// Summary description for CrkrAreaRegistration
    /// </summary>
    public class CrkrAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "Crkr";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                    name: AreaName + "_lang",
                    url: "{lang}/" + AreaName + "/{controller}/{action}/{id}",
                    defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional },
                    constraints: new { lang = Constants.RouteLang }
                );

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
            BindAreaDi();
        }

        private void BindAreaDi()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            ninjectKernel.Bind<ICrkrRepository>().To<CrkrRepository>();
            ninjectKernel.Bind<ICaGrcRepository>().To<CaGrcRepository>();
        }
    }

}