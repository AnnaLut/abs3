using BarsWeb.Controllers;
using System.Web.Mvc;

/// <summary>
/// Summary description for AverageExcEarningsController
/// </summary>
/// 
namespace BarsWeb.Areas.Zay.Controllers
{
    [Authorize]
    public class AverageExcEarningsController : ApplicationController
    {
        public AverageExcEarningsController()
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