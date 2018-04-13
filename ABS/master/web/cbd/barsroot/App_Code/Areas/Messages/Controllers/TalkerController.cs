using System.Web.Mvc;
using BarsWeb.Areas.Messages.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Controllers;

namespace BarsWeb.Areas.Messages.Controllers
{ 
    /// <summary>
    /// Advertising on tickets
    /// </summary>
    [AuthorizeUser]
    //[Authorize]
    //[CheckAccessPage]
    public class TalkerController : ApplicationController
    {
        private readonly ITalkerRepository _repository;
        public TalkerController(ITalkerRepository repository)
        {
            _repository = repository;
        }
        /// <summary>
        /// перегляд рахунків
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            return View();
        }
    }
}