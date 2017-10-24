using System;
using System.Web.Mvc;
using BarsWeb.Controllers;

namespace BarsWeb.Areas.Crkr.Controllers
{
    [AuthorizeUser]
    public class RegPayController : ApplicationController
    {
        public ActionResult Payments()
        {
            return View();
        }

        public ActionResult Paymregistry(string type)
        {
            return View();
        }

        [HttpPost]
        public ActionResult XmlProxy(string contentType, string base64, string fileName)
        {
            var fileContents = Convert.FromBase64String(base64);

            return File(fileContents, contentType, fileName);
        }
    }
}
