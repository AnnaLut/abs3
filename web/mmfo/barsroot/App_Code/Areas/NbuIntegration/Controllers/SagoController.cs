using BarsWeb.Controllers;
using System.Web.Mvc;

namespace BarsWeb.Areas.NbuIntegration.Controllers
{
    [AuthorizeUser]
    public class SagoController : ApplicationController
    {
        public ActionResult Index()
        {
            return View();
        }
    }
}
