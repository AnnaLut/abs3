using BarsWeb;
using BarsWeb.Areas.Way.Infrastructure.DI.Abstract;
using BarsWeb.Controllers;
using System.Web;
using System.Web.Mvc;

namespace BarsWeb.Areas.Way.Controllers
{
    [AuthorizeUser]
    public class InstallmentController : ApplicationController
    {
        public ActionResult Index(int? nd)
        {
            return View(nd);
        }
    }
}