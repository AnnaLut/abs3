using BarsWeb.Controllers;
using System;
using System.Web.Mvc;
using BarsWeb.Areas.Way4Bpk.Controllers.Api;
using System.Collections.Generic;
using System.Linq;

namespace BarsWeb.Areas.Way4Bpk.Controllers
{
    [AuthorizeUser]
    public class Way4BpkController : ApplicationController
    {
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public JsonResult SetSession(List<SessionData> o)
        {
            string[] decimalKeys = { "docNumberKK", "currentRnk" };
            foreach (SessionData obj in o)
            {
                if (!string.IsNullOrEmpty(obj.Value))
                {
                    if (decimalKeys.Contains(obj.Key))
                    {
                        Session[obj.Key] = new List<object>() { decimal.Parse(obj.Value) };
                    }
                    else
                    {
                        Session[obj.Key] = new List<object>() { obj.Value };
                    }                    
                }
                else
                {
                    Session.Remove(obj.Key);
                }
            }
            return Json(new { Result = "OK" });
        }
    }
}
