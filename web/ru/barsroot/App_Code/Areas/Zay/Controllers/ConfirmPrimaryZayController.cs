using System.Web.Mvc;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Controllers;

namespace BarsWeb.Areas.Zay.Controllers
{
    /// <summary>
    /// ConfirmPrimaryZayController - підтвердження пріоритетних заявок
    /// </summary>

    //[CheckAccessPage]
    //[AuthorizeUser]
    public class ConfirmPrimaryZayController : ApplicationController
    {
        private readonly ICurrencySightRepository _repo;
        public ConfirmPrimaryZayController()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public ActionResult Index()
        {
            return View();
        }
    }

}