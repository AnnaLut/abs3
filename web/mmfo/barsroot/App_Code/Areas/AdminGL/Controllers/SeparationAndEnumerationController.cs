using BarsWeb.Core.Controllers;
using System.Web.Mvc;

namespace BarsWeb.Areas.AdminGL.Controllers
{
    [CheckAccessPage]
    [AuthorizeUser]
    public class SeparationAndEnumerationController : ApplicationController
    {
        public SeparationAndEnumerationController()
        {
            
        }

        public ViewResult SeparationAndEnumeration()
        {
            return View();
        }
    }
}

