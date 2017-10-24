using System.Web.Mvc;
using BarsWeb.Areas.DptAdm.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.DptAdm.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;
using System.Web.Http;

namespace BarsWeb.Areas.DptAdm
{
    public class DptAdmAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "DptAdm";
            }
        }
        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.Routes.MapHttpRoute(
                name: AreaName + "Action_api",
                routeTemplate: "api/" + AreaName + "/{controller}/{action}/{id}",
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
            BindAreaDI();
        }

        private void BindAreaDI()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            ninjectKernel.Bind<IDptAdmRepository>().To<DptAdmRepository>();
            ninjectKernel.Bind<IEditFinesDFORepository>().To<EditFinesDFORepository>();
            ninjectKernel.Bind<IAdditionalFuncRepository>().To<AdditionalFuncRepository>();
        }
    
    }


}