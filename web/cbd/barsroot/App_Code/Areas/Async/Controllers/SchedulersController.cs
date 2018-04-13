using System.Web.Mvc;
using BarsWeb.Controllers;

namespace BarsWeb.Areas.Async.Controllers
{
    /// <summary>
    /// Списки счетов
    /// </summary>
    [AuthorizeUser]
    public class SchedulersController : ApplicationController
    {
        public ViewResult Index()
        {
            return View();
        }

        public ActionResult Edit()
        {
            return View();
        }
    }
}