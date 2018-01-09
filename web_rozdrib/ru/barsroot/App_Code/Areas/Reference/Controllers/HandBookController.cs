using System.Web.Mvc;
using BarsWeb.Areas.Reference.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Reference.Models;
using BarsWeb.Controllers;

namespace BarsWeb.Areas.Reference.Controllers
{ 
    /// <summary>
    /// Advertising on tickets
    /// </summary>
    [AuthorizeUser]
    //[Authorize]
    //[CheckAccessPage]
    public class HandBookController : ApplicationController
    {
        private readonly IHandBookRepository _repository;

        public HandBookController(IHandBookRepository repository)
        {
            _repository = repository;
        }

        public ActionResult Index(HandBookRequest request)
        {
            return View(request);
        }
    }
}