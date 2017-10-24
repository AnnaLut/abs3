using BarsWeb.Controllers;
using System;
using BarsWeb.Areas.Upload.Infrastructure.DI.Abstract;
using System.Web.Mvc;
using AttributeRouting.Web.Http;
using System.Net.Http;
using System.Net;
using BarsWeb.Core.Models.Binders.Api;
using BarsWeb.Core.Models;

namespace BarsWeb.Areas.Upload.Controllers
{
    public class UploadController : ApplicationController
    {
        public ActionResult Index()
        {
            return View();
        }
    }
}
