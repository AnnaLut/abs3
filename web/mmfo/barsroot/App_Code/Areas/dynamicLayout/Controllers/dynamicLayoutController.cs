using BarsWeb.Controllers;
using System;
using BarsWeb.Areas.dynamicLayout.Infrastructure.DI.Abstract;
using System.Web.Mvc;
using AttributeRouting.Web.Http;
using System.Net.Http;
using System.Net;
using BarsWeb.Core.Models.Binders.Api;
using BarsWeb.Core.Models;

namespace BarsWeb.Areas.dynamicLayout.Controllers
{
    [AuthorizeUser]
    public class dynamicLayoutController : ApplicationController
    {
        public ActionResult Index()
        {
            //ViewBag.Title = "Створення розпорядження по вибору";
            return View();
        }

        public ActionResult calculateStatic()
        {
            return View();
        }

    }
}
