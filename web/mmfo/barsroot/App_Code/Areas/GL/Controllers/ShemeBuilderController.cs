using System.Web.Mvc;
using BarsWeb.Areas.GL.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Controllers;

namespace BarsWeb.Areas.GL.Controllers
{
    [Authorize]
    [CheckAccessPage]
    public class SchemeBuilderController : ApplicationController
    {
        private readonly ISchemeBuilderRepository _repository;
        public SchemeBuilderController(ISchemeBuilderRepository repository)
        {
            _repository = repository;
        }
        public ActionResult Index()
        {
            return View();
        }
    }
}