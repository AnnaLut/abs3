using BarsWeb.Controllers;
using System.Web.Mvc;

namespace BarsWeb.Areas.BpkW4.Controllers
{
    [AuthorizeUser]
    public class AutoOfficialNoteController : ApplicationController
    {
        public ActionResult Index()
        {
            return View();
        }
    }
}

