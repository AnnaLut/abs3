using System.Web.Mvc;
using BarsWeb.Controllers;

namespace BarsWeb.Areas.OpenCloseDay.Controllers
{
    [AuthorizeApi]
    public class FuncListController : ApplicationController
    {
        public ActionResult FuncOpen()
        {
            return View();
        }

        public ActionResult FuncClose()
        {
            return View();
        }

        public ActionResult FuncReglament()
        {
            return View();
        }
    }
}