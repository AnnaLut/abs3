using System.Web.Mvc;
using BarsWeb.Core.Controllers;

namespace BarsWeb.Areas.Acct.Controllers
{
    [Authorize]
    public class StatementsController : ApplicationController
    {
        public ActionResult Index()
        {
            return View(); 
        }
    }
}
