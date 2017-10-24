using System.Web.Mvc;
using BarsWeb.Areas.Cash.Infrastructure.DI.Abstract.Center;
using BarsWeb.Controllers;

namespace BarsWeb.Areas.Cash.Controllers
{
    /// <summary>
    /// Розподіл лімітів
    /// </summary>
    [AuthorizeUser]
    public class TresholdController : ApplicationController
    {
        /// <summary>
        /// Головна форма
        /// </summary>
        /// <returns></returns>
        public ViewResult Index()
        {
            return View();
        }

        /// <summary>
        /// Форма редігування
        /// </summary>
        /// <returns></returns>
        public ViewResult Edit()
        {
            return View();
        }
    }
}