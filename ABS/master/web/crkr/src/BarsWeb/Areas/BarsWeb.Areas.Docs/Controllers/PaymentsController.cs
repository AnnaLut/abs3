using System.Web.Mvc;
using BarsWeb.Core.Controllers;

namespace BarsWeb.Areas.Docs.Controllers
{
    [Authorize]
    public class PaymentsController : ApplicationController
    {
        public new ActionResult User()
        {
            return View();
        }

        public ActionResult Branch()
        {
            return View();
        }

        public ActionResult Archive()
        {
            return View();
        }
    }
}