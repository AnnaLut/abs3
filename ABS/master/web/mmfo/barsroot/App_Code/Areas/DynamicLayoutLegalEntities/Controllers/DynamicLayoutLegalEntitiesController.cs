using BarsWeb.Controllers;
using System;
using BarsWeb.Areas.DynamicLayoutLegalEntities.Infrastructure.DI.Abstract;
using System.Web.Mvc;
using AttributeRouting.Web.Http;
using System.Net.Http;
using System.Net;
using BarsWeb.Core.Models.Binders.Api;
using BarsWeb.Core.Models;

namespace BarsWeb.Areas.DynamicLayoutLegalEntities.Controllers
{
    [AuthorizeUser]
    public class DynamicLayoutLegalEntitiesController : ApplicationController
    {
        public ActionResult Index()
        {
            //ViewBag.Title = "��������� ������������� �� ������";
            return View();
        }

        public ActionResult calculateStatic()
        {
            return View();
        }
    }
}