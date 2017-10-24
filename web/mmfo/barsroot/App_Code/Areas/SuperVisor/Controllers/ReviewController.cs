using System.Web.Mvc;
using BarsWeb.Areas.SuperVisor.Infrastructure.DI.Abstract;
using BarsWeb.Controllers;

namespace BarsWeb.Areas.SuperVisor.Controllers
{
    public class ReviewController : ApplicationController
    {
        private readonly IBalanceRepository _repository;
        public ReviewController(IBalanceRepository repository)
        {
            _repository = repository;
        }

        public ActionResult Index()
        {
            ViewBag.bDate = _repository.BankDate();
            return View();
        }
    }
}