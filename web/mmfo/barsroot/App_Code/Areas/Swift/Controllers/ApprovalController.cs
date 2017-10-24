using BarsWeb.Controllers;
using System;
using System.Web.Mvc;

namespace BarsWeb.Areas.Swift.Controllers
{
    [AuthorizeUser]
    public class ApprovalController : ApplicationController
    {
        public ActionResult Index()
        {
            return View();
        }
    }
}