using System.Web.Mvc;
using BarsWeb.Controllers;
using Kendo.Mvc.UI;
using BarsWeb.Areas.Sberutl.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sberutl.Infrastructure.Repository.DI.Implementation;
using System;

namespace BarsWeb.Areas.Sberutl.Controllers
{
    [AuthorizeUser]
    public class ArchiveController : ApplicationController
    {
        private readonly IArchiveRepository _repository;
        public ArchiveController(ArchiveRepository repository)
        {
            _repository = repository;
        }

        public ActionResult Index(Int32 param)
        {
            ViewBag.param = param;
            return View();
        }
    }
}