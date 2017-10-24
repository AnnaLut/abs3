using System.Web.Mvc;
using BarsWeb.Core.Controllers;

namespace BarsWeb.Controllers
{
    public class NewsController : ApplicationController
    {
        public ActionResult Index()
        {
            return View();
        }
    }
}
