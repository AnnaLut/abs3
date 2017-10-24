using BarsWeb.Areas.DPU.Infrastructure.DI.Abstract;
using BarsWeb.Controllers;
using System;
using System.Web.Mvc;

/// <summary>
/// Summary description for EditFinesDFOController
/// </summary>
/// 

namespace BarsWeb.Areas.DPU.Controllers
{
    public class DPUController : ApplicationController
    {
        private readonly IDPURepository _repository;

        public DPUController(IDPURepository repository)
        {
            _repository = repository;
        }

        public ActionResult Index()
        {
            return View();
        }
    }
}