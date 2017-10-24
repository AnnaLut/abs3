using BarsWeb.Controllers;
using System;
using BarsWeb.Areas.CustomerList.Infrastructure.DI.Abstract;
using System.Web.Mvc;
using AttributeRouting.Web.Http;
using System.Net.Http;
using System.Net;
using BarsWeb.Core.Models.Binders.Api;
using BarsWeb.Core.Models;

namespace BarsWeb.Areas.CustomerList.Controllers
{
    [AuthorizeUser]
    public class CustomerListController : ApplicationController
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult TotalCurrency()
        {
            return View();
        }
    }
}
