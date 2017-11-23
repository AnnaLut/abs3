using BarsWeb.Controllers;
using System;
using System.Web.Mvc;

namespace BarsWeb.Areas.RequestsProcessing.Controllers
{
    [AuthorizeUser]
    public class RequestsProcessingController : ApplicationController
    {
        public ActionResult Index()
        {
            return View();
        }
    }
}
