using BarsWeb.Controllers;
using System;
using BarsWeb.Areas.ImageViewer.Infrastructure.DI.Abstract;
using System.Web.Mvc;
using AttributeRouting.Web.Http;
using System.Net.Http;
using System.Net;
using BarsWeb.Core.Models.Binders.Api;
using BarsWeb.Core.Models;

namespace BarsWeb.Areas.ImageViewer.Controllers
{
    [AuthorizeUser]
    public class ImageViewerController : ApplicationController
    {
        public ActionResult Index()
        {
            return View();
        }
    }
}
