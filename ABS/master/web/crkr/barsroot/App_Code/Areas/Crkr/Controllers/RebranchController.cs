using System.Web.Mvc;
using BarsWeb.Controllers;

namespace BarsWeb.Areas.Crkr.Controllers
{
    [AuthorizeUser]
    public class RebranchController : ApplicationController
    {
        public ActionResult Index()
        {
            return View();
        }
    }
}
