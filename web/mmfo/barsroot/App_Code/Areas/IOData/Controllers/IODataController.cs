using System.Web.Mvc;
using BarsWeb.Controllers;

namespace BarsWeb.Areas.IOData.Controllers
{
    public class IODataController : ApplicationController
    {
        public IODataController()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult DailyTasks()
        {
            return View();
        }
    }
}