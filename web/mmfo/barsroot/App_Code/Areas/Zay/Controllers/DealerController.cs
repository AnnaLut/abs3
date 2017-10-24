using System.Web.Mvc;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Controllers;
using System;

namespace BarsWeb.Areas.Zay.Controllers
{
    /// <summary>
    /// ZAY42
    /// </summary>
    public class DealerController : ApplicationController
    {
        private readonly ICurrencySightRepository _repository;
        public DealerController(ICurrencySightRepository repository)
        {
            _repository = repository;
        }

        public ActionResult Index()
        {
            ViewBag.dilViza = _repository.DilViza();
            ViewBag.bankDate = _repository.BankDate();

            return View();
        }        
    }
}