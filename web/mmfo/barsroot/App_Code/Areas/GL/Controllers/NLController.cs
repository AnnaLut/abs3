using System.Web.Mvc;
using BarsWeb.Controllers;

namespace BarsWeb.Areas.GL.Controllers
{
    public class NLController : ApplicationController
    {
        public ActionResult Index()
        {
            return View();
        }
    }
}