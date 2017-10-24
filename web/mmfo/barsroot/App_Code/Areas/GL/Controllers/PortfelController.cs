using BarsWeb.Controllers;
using System.Web.Mvc;

namespace BarsWeb.Areas.GL.Controllers
{
    public class PortfelController : ApplicationController
    {
        public ActionResult Index(int MOD_ABS, string NBS_N)
        {
            ViewBag.MOD_ABS = MOD_ABS;
            ViewBag.NBS_N = NBS_N;
            return View();
        }
    }
}