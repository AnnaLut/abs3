using System.Web.Http;
using System.Web.Mvc;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;
using AttributeRouting.Web.Http.WebHost;
using BarsWeb.Areas.LinkedGroupReference.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Areas.LinkedGroupReference.Infrastructure.Repository.DI.Abstract;
using System.Web.Optimization;

namespace BarsWeb.Areas.LinkedGroupReference
{
    public class LinkedGroupReferenceAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "LinkedGroupReference";
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

            context.MapRoute(
                AreaName + "_default",
                AreaName + "/{controller}/{action}/{id}",
                new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
            
            BindAreaDI();
        }

        private void BindAreaDI()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            ninjectKernel.Bind<ILinkedGroupReferenceRepository>().To<LinkedGroupReferenceRepository>();
        }

    }
}