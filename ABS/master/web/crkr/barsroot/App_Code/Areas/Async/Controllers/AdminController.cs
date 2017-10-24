using System.Web.Mvc;
using BarsWeb.Areas.Cash.Infrastructure.DI.Abstract.Center;
using BarsWeb.Controllers;

namespace BarsWeb.Areas.Async.Controllers
{
    /// <summary>
    /// Списки счетов
    /// </summary>
    [AuthorizeUser]
    public class AdminController : ApplicationController
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