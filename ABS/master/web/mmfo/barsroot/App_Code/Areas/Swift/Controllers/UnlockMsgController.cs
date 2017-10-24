using BarsWeb.Controllers;
using System;
using System.Web.Mvc;

namespace BarsWeb.Areas.Swift.Controllers
{
    [AuthorizeUser]
    public class UnlockMsgController : ApplicationController
    {
        public ActionResult Index()
        {
            return View();
        }
    }
}
