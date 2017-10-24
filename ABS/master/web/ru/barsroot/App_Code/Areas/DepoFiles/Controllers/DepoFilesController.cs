using System.Web.Mvc;
using BarsWeb.Controllers;
using BarsWeb.Areas.DepoFiles.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.DepoFiles.Models;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.DepoFiles.Controllers
{

    [AuthorizeUser]
    public class DepoFilesController : ApplicationController
    {
        private readonly IDepoFilesRepository _repository;
        public DepoFilesController(IDepoFilesRepository repository)
        {
            _repository = repository;
        }

        public ActionResult AcceptedFiles(bool? gb = null, string delete = null)
        {
            ViewBag.GB = gb;
            ViewBag.Delete = delete;
            return View();
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Update([DataSourceRequest] DataSourceRequest request, GridBranch product)
        {
            return View("Index");
        }

        public ActionResult AcceptFile(string mode, string filename = null, string dat = null, decimal? header_id = null, bool? gb = null)
        {
            ViewBag.Mode = mode;
            ViewBag.Dat = dat;
            ViewBag.Header_id = header_id;
            ViewBag.FileName = filename;
            ViewBag.GB = gb;
            return View();
        }

    }
}