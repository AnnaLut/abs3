using System.Web.Http;
using System.Web.Mvc;
using BarsWeb.Infrastructure.Repository;
using BarsWeb.Areas.FastReport.Infrastructure.DI.Implementation;

/// <summary>
/// Работа/генерация файлов с помощью fastReport (.frx)
/// </summary>
public class FastReportAreaRegistration : AreaRegistration
{
    public override string AreaName { get { return "FastReport"; } }

    public override void RegisterArea(AreaRegistrationContext context)
    {
        context.Routes.IgnoreRoute("admin/dialog.aspx/{*pathInfo}");
        //context.MapRoute(
        //    name: AreaName + "_lang",
        //    url: "{lang}/" + AreaName + "/{controller}/{action}/{id}",
        //    defaults: new { controller = "FastReport", action = "Index", id = UrlParameter.Optional },
        //    constraints: new { lang = Constants.RouteLang }
        //);
        context.Routes.MapHttpRoute(
            name: AreaName + "_api",
            routeTemplate: "api/" + AreaName + "/{controller}/{action}/{id}",
            defaults: new { id = RouteParameter.Optional }
        );
        //context.MapRoute(
        //        AreaName + "_default",
        //        AreaName + "/{controller}/{action}/{id}",
        //        new { controller = "FastReport", action = "Index", id = UrlParameter.Optional }
        //    );

        BindAreaDI();
    }
    private void BindAreaDI()
    {
        var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
        var ninjectKernel = controllerFactory.NinjectKernel;
        ninjectKernel.Bind<IFastReportRepository>().To<FastReportRepository>();
    }
}