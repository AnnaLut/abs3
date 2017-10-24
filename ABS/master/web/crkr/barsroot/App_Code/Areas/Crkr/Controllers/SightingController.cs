using System.Web.Mvc;
using BarsWeb.Controllers;

namespace BarsWeb.Areas.Crkr.Controllers
{
    [AuthorizeUser]
    public class SightingController : ApplicationController
    {
        public ActionResult Control()
        {
            return View();
        }

        public ActionResult Oper()
        {
            return View();
        }
        public ActionResult Back()
        {
            return View();
        }
    }
}
