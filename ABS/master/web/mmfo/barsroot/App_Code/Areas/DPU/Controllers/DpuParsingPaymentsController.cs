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
    public class DpuParsingPaymentsController : ApplicationController
    {
        private readonly IDpuParsingPaymentsRepository _repository;

        public ActionResult Index()
        {
            return View();
        }
    }
}