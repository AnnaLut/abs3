using BarsWeb.Controllers;
using System;
using System.Web.Mvc;

namespace BarsWeb.Areas.Mcp.Controllers
{
    [AuthorizeUser]
    public class McpController : ApplicationController
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult ErrorsRecords()
        {
            return View();
        }

        public ActionResult PayAccept()
        {
            return View();
        }

        public ActionResult RecBlockFm()
        {
            return View();
        }
    }
}
