using BarsWeb.Controllers;
using System;
using System.Web.Mvc;

namespace BarsWeb.Areas.PaymentVerification.Controllers
{
    [AuthorizeUser]
    public class PaymentVerificationController : ApplicationController
    {
        public ActionResult Index()
        {
            return View();
        }
    }
}
