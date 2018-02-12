using BarsWeb.Controllers;
using System;
using BarsWeb.Areas.SWCompare.Infrastructure.DI.Abstract;
using System.Web.Mvc;
using AttributeRouting.Web.Http;
using System.Net.Http;
using System.Net;
using BarsWeb.Core.Models.Binders.Api;
using BarsWeb.Core.Models;

namespace BarsWeb.Areas.SWCompare.Controllers
{
    [AuthorizeUser]
    public class SWCompareController : ApplicationController
    {
        public ActionResult Index()
        {
            return View();
        }
    }
}
