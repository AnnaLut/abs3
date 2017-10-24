using BarsWeb.Areas.PC.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Controllers;
using ICSharpCode.SharpZipLib.Zip;
using System;
using System.Collections.Generic;
using System.IO;
using System.Web.Mvc;

namespace BarsWeb.Areas.PC.Controllers
{
    public class PCController : ApplicationController
    {
        private readonly IPCRepository _repository;

        public PCController(IPCRepository repository)
        {
            _repository = repository;
        }

        public ActionResult Index()
        {
            return View();
        }
    }
}
