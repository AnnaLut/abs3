using BarsWeb.Controllers;
using System;
using BarsWeb.Areas.DownloadXsdScheme.Infrastructure.DI.Abstract;
using System.Web.Mvc;
using AttributeRouting.Web.Http;
using System.Net.Http;
using System.Net;
using BarsWeb.Core.Models.Binders.Api;
using BarsWeb.Core.Models;

namespace BarsWeb.Areas.DownloadXsdScheme.Controllers
{
    [AuthorizeUser]
    public class DownloadXsdSchemeController : ApplicationController
    {
        public ActionResult Index()
        {
            return View();
        }
    }
}
