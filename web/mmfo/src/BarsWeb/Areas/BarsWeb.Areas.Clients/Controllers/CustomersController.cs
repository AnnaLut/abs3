using System.Web.Mvc;
using BarsWeb.Core.Controllers;

namespace BarsWeb.Areas.Clients.Controllers
{ 
    [Authorize]
    //[CheckAccessPage]
    public class CustomersController : ApplicationController
    {

        public CustomersController()
        {

        }
        /// <summary>
        /// view customers list
        /// </summary>
        /// <returns></returns>
        public ViewResult Index()
        {
            return View();
        }

        public ActionResult Show(int id)
        {
            return View();
        }

        public ViewResult SelectCustomerType()
        {
            return View();
        }

        public ViewResult Search()
        {
            return View();
        }
    }
}