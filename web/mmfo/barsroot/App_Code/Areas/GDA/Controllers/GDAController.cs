using BarsWeb.Controllers;
using System;
using System.Web.Mvc;

namespace BarsWeb.Areas.GDA.Controllers
{
    [AuthorizeUser]
    public class GDAController : ApplicationController
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult DepositDemand()
        {
            return View();
        }


        public ActionResult Dictionaries()
        {
            return View();
        }

        public ActionResult DictionaryDemand()
        {
            return View();
        }

        public ActionResult IndexFront()
        {
            return View();
        }
        public ActionResult IndexBack()
        {
            return View();
        }
    }
}

    
