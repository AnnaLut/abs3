using System.Web.Mvc;
using BarsWeb.Controllers;

namespace BarsWeb.Areas.Zay.Controllers
{
    //[CheckAccessPage]
    //[AuthorizeUser]
    public class BirjaController : ApplicationController
    {
        public BirjaController()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public ActionResult Index()
        {
            return View();
        }
    }
}