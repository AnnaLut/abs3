using System.Web.Mvc;
using BarsWeb.Controllers;
using Kendo.Mvc.UI;
using BarsWeb.Areas.DptSocial.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.DptSocial.Infrastructure.Repository.DI.Implementation;
using System;

namespace BarsWeb.Areas.DptSocial.Controllers
{

    [AuthorizeUser]
    public class ImportFilesController : ApplicationController
    {
        private readonly IImportFilesRepository _repository;
        public ImportFilesController(ImportFilesRepository repository)
        {
            _repository = repository;
        }

        public ActionResult ViewImportedFiles(Int32 file_tp = 1)
        {
            ViewBag.file_tp = file_tp;
            return View();
        }

        public ActionResult ImportFiles()
        {
            return View();
        }
    }
}