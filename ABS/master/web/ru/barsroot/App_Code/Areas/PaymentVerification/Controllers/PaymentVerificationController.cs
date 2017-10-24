using BarsWeb.Controllers;
using System;
using BarsWeb.Areas.PaymentVerification.Infrastructure.DI.Abstract;
using System.Web.Mvc;
using AttributeRouting.Web.Http;
using System.Net.Http;
using System.Net;
using BarsWeb.Core.Models.Binders.Api;
using BarsWeb.Core.Models;

namespace BarsWeb.Areas.PaymentVerification.Controllers
{
    public class PaymentVerificationController : ApplicationController
    {
        public ActionResult Index()
        {
            return View();
        }
    }
}
