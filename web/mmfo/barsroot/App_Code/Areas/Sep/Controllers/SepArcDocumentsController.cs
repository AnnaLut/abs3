using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Core.Controllers;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;


namespace BarsWeb.Areas.Sep.Controllers
{
    [AuthorizeUser]
    public class SepArcDocumentsController : ApplicationController
    {

        private readonly ISepFilesRepository _repo;

        public SepArcDocumentsController(ISepFilesRepository repoSepParams)
        {
            _repo = repoSepParams;
        }
        [HttpGet]
        public ActionResult GetSepArcDocs([DataSourceRequest]DataSourceRequest request, string flt)
        {
            var docList = _repo.GetSepArcDocs(request, flt).ToList();
            decimal total = _repo.GetSepArcDocsCount(request, flt);
            return Json(new { Data = docList, Total = total }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult ExportButtonSave(string contentType, string base64, string fileName)
        {
            var fileContents = Convert.FromBase64String(base64);

            return File(fileContents, contentType, fileName);
        }
        public ActionResult Index()
        {
            return View();
        }
    }
}