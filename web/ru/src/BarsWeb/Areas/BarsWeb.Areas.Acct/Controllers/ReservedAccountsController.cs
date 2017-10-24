using System.Web.Mvc;
using BarsWeb.Core.Controllers;

namespace BarsWeb.Areas.Acct.Controllers
{
    [Authorize]
    public class ReservedAccountsController : ApplicationController
    {
        public ActionResult Index()
        {
            return View(); 
        }
    }
}
