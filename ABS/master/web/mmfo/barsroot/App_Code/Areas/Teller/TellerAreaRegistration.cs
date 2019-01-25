using System;
using System.Web.Http;
using System.Web.Mvc;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;
using BarsWeb.Areas.Teller.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Teller.Infrastructure.DI.Implementation;
using BarsWeb.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Areas.Teller.Patterns.TellerWindowStatus;

/// <summary>
/// Summary description for TellerAreaRegistration
/// </summary>
public class TellerAreaRegistration : AreaRegistration
{
    public override string AreaName { get { return "Teller"; } }

    public override void RegisterArea(AreaRegistrationContext context)
    {
        context.Routes.IgnoreRoute("admin/dialog.aspx/{*pathInfo}");
        context.MapRoute(
            name: AreaName + "_lang",
            url: "{lang}/" + AreaName + "/{controller}/{action}/{id}",
            defaults: new { controller = "Teller", action = "Index", id = UrlParameter.Optional },
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
                new { controller = "Teller", action = "Index", id = UrlParameter.Optional }
            );

        BindAreaDI();
    }
    private void BindAreaDI()
    {
        var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
        var ninjectKernel = controllerFactory.NinjectKernel;
        ninjectKernel.Bind<ITellerRepository>().To<TellerRepository>();
    }
}