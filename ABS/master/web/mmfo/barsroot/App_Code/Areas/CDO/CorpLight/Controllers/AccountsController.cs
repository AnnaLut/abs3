using System.Web.Mvc;
using BarsWeb.Controllers;
using AttributeRouting.Web.Http;

namespace BarsWeb.Areas.CDO.CorpLight.Controllers
{
    [AuthorizeUser]
    //[CheckAccessPage]
    public class AccountsController : ApplicationController
    {
        //[GET("cdo/corplight/accounts/index")]
        public ActionResult Index()
        { 
            return View();
        }
    }
}