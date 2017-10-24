using System.Web.Mvc;
using BarsWeb.Areas.Payreg.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Payreg.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;

namespace BarsWeb.Areas.Payreg
{
    public class PayregAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "Payreg";
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
            var controllerFactory = ((NinjectControllerFactory) ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            ninjectKernel.Bind<IPayRegularRepository>().To<PayRegularRepository>();
        }
    }
}
