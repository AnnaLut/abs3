using Areas.Admin.Models;
using BarsWeb.Controllers;
using Kendo.Mvc.UI;
using System;
using System.Linq;
using BarsWeb.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using System.Web.Mvc;
using Kendo.Mvc.Extensions;
using Oracle.DataAccess.Client;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Web;
using System.Xml;
using BarsWeb.Areas.Way.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Way.Models;
using FastReport.Utils;
using Ionic.Zlib;

namespace BarsWeb.Areas.Way.Controllers
{
    //[CheckAccessPage]
    //[Authorize]
    public class WayAppController : ApplicationController
    {
        private readonly IWayRepository _repository;
        public WayAppController(IWayRepository repository)
        {
            _repository = repository;
        }
        public ActionResult Index() 
        {
            return View();
        }
        public ActionResult Save(IEnumerable<HttpPostedFileBase> files)
        {
            // The Name of the Upload component is "files"
            if (files != null)
            {
                foreach (var file in files)
                {
                    byte[] fileData;
                    using (var binaryReader = new BinaryReader(file.InputStream))
                    {
                        fileData = binaryReader.ReadBytes(file.ContentLength);
                    }
                    var id = _repository.ImportFile(file.FileName, fileData, false);
                }
            }
            
            // Return an empty string to signify success
            return Content("1");

        }
        public ActionResult Remove(string[] fileNames)
        {
            // The parameter of the Remove action must be called "fileNames"

            if (fileNames != null)
            {
                foreach (var fullName in fileNames)
                {
                    var fileName = Path.GetFileName(fullName);
                    var physicalPath = Path.Combine(Server.MapPath("~/App_Data"), fileName);

                    // TODO: Verify user permissions

                    if (System.IO.File.Exists(physicalPath))
                    {
                        // The files are not actually removed in this demo
                        // System.IO.File.Delete(physicalPath);
                    }
                }
            }

            // Return an empty string to signify success
            return Content("");
        }

        [HttpGet]
        public ActionResult FileUpload()
        {
            return View();
        }
    }
}