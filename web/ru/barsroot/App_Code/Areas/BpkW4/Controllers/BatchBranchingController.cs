using BarsWeb.Controllers;
using System;
using System.IO;
using BarsWeb.Models;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace BarsWeb.Areas.BpkW4.Controllers
{
    public class BatchBranchingController : ApplicationController
    {
        public ActionResult Index()
        {
            return View();
        }
    }
}
