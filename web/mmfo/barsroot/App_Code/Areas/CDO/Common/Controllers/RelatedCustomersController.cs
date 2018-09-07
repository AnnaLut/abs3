using System.Web.Mvc;
using BarsWeb.Controllers;

namespace BarsWeb.Areas.CDO.Common.Controllers
{
    [AuthorizeUser]
    //[CheckAccessPage]
    public class RelatedCustomersController : ApplicationController
    {
        public ActionResult Index(decimal custId,bool addCorp2Tube = false, string clmode="base")
        {
            ViewBag.CustId = custId;
            ViewBag.Clmode = clmode;
            ViewBag.AddCorp2Tube = addCorp2Tube;
            return View();
        }
    }
}