using System.Web.Mvc;

/// <summary>
/// Summary description for CimAreaRegistration
/// </summary>
public class CimAreaRegistration : AreaRegistration
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
        context.MapRoute(
            AreaName + "_default",
            AreaName + "/{controller}/{action}/{id}",
            new { controller = "Home", action = "Index", id = UrlParameter.Optional }
        );
    }
}