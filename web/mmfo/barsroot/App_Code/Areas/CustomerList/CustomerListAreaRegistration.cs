using System;
using System.Web.Http;
using System.Web.Mvc;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;
using BarsWeb.Areas.CustomerList.Infrastructure.DI.Abstract;
using BarsWeb.Areas.CustomerList.Infrastructure.DI.Implementation;


/// <summary>
/// Summary description for CustomerListAreaRegistration
/// </summary>
public class CustomerListAreaRegistration : AreaRegistration
{
    public override string AreaName { get { return "CustomerList"; } }

    public override void RegisterArea(AreaRegistrationContext context)
    {
        context.Routes.IgnoreRoute("CustomerList/dialog.aspx/{*pathInfo}");
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

        BindAreaDI();
    }
    private void BindAreaDI()
    {
        var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
        var ninjectKernel = controllerFactory.NinjectKernel;
        ninjectKernel.Bind<ICustomerListRepository>().To<CustomerListRepository>();
    }
}