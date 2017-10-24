using System.Web.Mvc;
using BarsWeb.Controllers;

namespace BarsWeb.Areas.Crkr.Controllers
{
    [AuthorizeUser]
    //[CheckAccessPage]
    public class DepositProfileController : ApplicationController
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="depoid"></param>
        /// <param name="flag"></param>
        /// <returns></returns>
        public ActionResult DepositInventory(string depoid, string flag)
        {
            return View();
        }

        public ActionResult ReplenishmentDepo(string rnk)
        {
            return View();
        }
    }
}