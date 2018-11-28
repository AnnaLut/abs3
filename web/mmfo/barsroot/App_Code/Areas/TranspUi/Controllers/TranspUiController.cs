using BarsWeb.Controllers;
using System;
using BarsWeb.Areas.TranspUi.Infrastructure.DI.Abstract;
using System.Web.Mvc;
using AttributeRouting.Web.Http;
using System.Net.Http;
using System.Net;
using BarsWeb.Core.Models.Binders.Api;
using BarsWeb.Core.Models;

namespace BarsWeb.Areas.TranspUi.Controllers
{
    [AuthorizeUser]
    public class TranspUiController : ApplicationController
    {
        public ActionResult Index(int formType = 1)
        {
            return View(formType);
        }
    }
}
