using System.Web.Mvc;

/// <summary>
/// Summary description for CimAreaRegistration
/// </summary>
public class CimAreaRegistration: AreaRegistration
{
    public override string AreaName
    {
        get
        {
            return "Cim";
        }
    }

    public override void RegisterArea(AreaRegistrationContext context)
    {
        context.Routes.IgnoreRoute("cim/{pathInfo}/{ *allaspx}", new { allaspx = @".*\.aspx(/.*) ? " });
        context.Routes.IgnoreRoute("cim/payments/dialog.aspx/{*pathInfo}");
        context.Routes.IgnoreRoute("cim/contracts/{*pathInfo}");
        context.MapRoute(
            AreaName + "_default",
            AreaName + "/{controller}/{action}/{id}",
            new { controller = "Home", action = "Index", id = UrlParameter.Optional }
        );
    }
}