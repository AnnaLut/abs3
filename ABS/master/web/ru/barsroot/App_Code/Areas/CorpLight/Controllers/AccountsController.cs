using System.Web.Mvc;
using BarsWeb.Controllers;

namespace BarsWeb.Areas.CorpLight.Controllers
{
    [AuthorizeUser]
    //[CheckAccessPage]
    public class AccountsController : ApplicationController
    {
        public ActionResult Index()
        { 
            return View();
        }
    }
}