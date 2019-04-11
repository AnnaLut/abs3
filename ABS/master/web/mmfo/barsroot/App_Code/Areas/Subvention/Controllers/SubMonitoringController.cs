using BarsWeb.Controllers;
using System.Web.Mvc;

namespace BarsWeb.Areas.Subvention.Controllers
{
    [AuthorizeUser]
    public class SubMonitoringController : ApplicationController
    {
        public ActionResult Index()
        {
            return View();
        }
    }
}
