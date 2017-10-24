using System.Web.Mvc;
using BarsWeb.Controllers;

namespace BarsWeb.Areas.CorpLight.Controllers
{
    [AuthorizeUser]
    //[CheckAccessPage]
    public class RelatedCustomersController : ApplicationController
    {
        public ActionResult Index(decimal custId, string clmode="base")
        {
            ViewBag.CustId = custId;
            ViewBag.Clmode = clmode;
            return View();
        }
    }
}