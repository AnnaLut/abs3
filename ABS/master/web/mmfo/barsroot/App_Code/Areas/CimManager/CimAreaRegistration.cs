using System.Web.Mvc;


namespace BarsWeb.Areas.CimManager
{
	/// <summary>
	/// Summary description for CimAreaRegistration
	/// </summary>
	public class CimManagerAreaRegistration : AreaRegistration
	{
		public override string AreaName
		{
			get
			{
				return "CimManager";
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
}