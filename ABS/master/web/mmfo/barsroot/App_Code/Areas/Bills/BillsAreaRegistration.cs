using System.Web.Http;
using System.Web.Mvc;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;
using BarsWeb.Areas.Bills.Infrastructure.Repository;

namespace BarsWeb.Areas.Bills
{
    /// <summary>
    /// Маршрутизация запросов!
    /// </summary>
    public class BillsAreaRegistration : AreaRegistration
    {
        public override string AreaName { get { return "Bills"; } }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.Routes.IgnoreRoute("admin/dialog.aspx/{*pathInfo}");
            context.MapRoute(
                name: AreaName + "_lang",
                url: "{lang}/" + AreaName + "/{controller}/{action}/{id}",
                defaults: new { controller = "Bills", action = "Receivers", id = UrlParameter.Optional },
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
                    new { controller = "Bills", action = "Receivers", id = UrlParameter.Optional }
                );

            BindAreaDI();
        }
        private void BindAreaDI()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            ninjectKernel.Bind<IKendoBillsSqlCounter>().To<KendoBillsSqlCounter>();
            ninjectKernel.Bind<IKendoBillsSqlFilter>().To<KendoBillsSqlFilter>();
            ninjectKernel.Bind<IKendoBillsSqlTransformer>().To<KendoBillsSqlTransformer>();
            ninjectKernel.Bind<IBillsRepository>().To<BillsRepository>();
        }
    }
}