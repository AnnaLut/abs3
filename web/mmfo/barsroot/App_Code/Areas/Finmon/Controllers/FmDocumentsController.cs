using System.Web.Mvc;
using BarsWeb.Controllers;

namespace BarsWeb.Areas.Finmon.Controllers
{
    [AuthorizeUser]
    [CheckAccessPage]
    public class FmDocumentsController : ApplicationController
    {
        public ActionResult Index()
        {
            return View();
        }
    }
}