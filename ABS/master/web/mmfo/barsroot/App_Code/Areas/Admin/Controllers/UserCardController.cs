using System.Web.Mvc;
using BarsWeb.Controllers;

namespace BarsWeb.Areas.Admin.Controllers
{
    public class UserCardController : ApplicationController
    {
        public UserCardController()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public ActionResult Card(string login)
        {
            ViewBag.Login = login;
            return View();
        }
    }
}