using System.Web.Mvc;
using BarsWeb.Areas.SuperVisor.Infrastructure.DI.Abstract;
using BarsWeb.Areas.ValuePapers.Infrastructure.DI.Abstract;
using BarsWeb.Controllers;
using System;

namespace BarsWeb.Areas.ValuePapers.Controllers
{
    [Authorize]
    public class GeneralFolderController : ApplicationController
    {
        //private readonly IGeneralFolderRepository _repo;
        //public GeneralFolderController(IGeneralFolderRepository repo)
        //{
        //    _repo = repo;
        //}

        public ActionResult Index(InitParams initParams)
        {
            return View(initParams);
        }

        [HttpPost]
        public ActionResult Excel_Export_Save(string contentType, string base64, string fileName)
        {
            var fileContents = Convert.FromBase64String(base64);

            return File(fileContents, contentType, fileName);
        }

        public ActionResult MoneyFlow(InitParams initParams, String REF)
        {
            ViewBag.REF = REF;
            return View(initParams);
        }
    }
}