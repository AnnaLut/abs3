using System.Web.Mvc;
using BarsWeb.Areas.ValuePapers.Infrastructure.DI.Abstract;
using BarsWeb.Controllers;

namespace BarsWeb.Areas.ValuePapers.Controllers
{
    public class CPToAnotherBagController : ApplicationController
    {
        private readonly ICPToAnotherBagRepository _repository;

        public CPToAnotherBagController(ICPToAnotherBagRepository repository)
        {
            _repository = repository;
        }

        public ActionResult SelectFromMD()
        {
            return View();
        }

        public ActionResult Index(decimal id)
        {
            ViewBag.id = id;
            return View();
        }
    }
}
