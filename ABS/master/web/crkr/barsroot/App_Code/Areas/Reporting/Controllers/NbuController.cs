using System.Web.Mvc;
using BarsWeb.Areas.Reporting.Infrastructure;
using BarsWeb.Areas.Reporting.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Controllers;
using System;
using Kendo.Mvc.UI;
using BarsWeb.Models;

namespace BarsWeb.Areas.Reporting.Controllers
{ 
    /// <summary>
    /// Advertising on tickets
    /// </summary>
    //[AuthorizeUser]
    [Authorize]
    [CheckAccessPage]
    public class NbuController : ApplicationController
    {
        private readonly INbuRepository _repository;
        public NbuController(INbuRepository repository)
        {
            _repository = repository;
        }
        public ActionResult Index() 
        {
            return View();
        }
        //     /barsroot/reporting/nbu/getstructure/01
        public ActionResult GetStructure(string id, string isCon)
        {
            var structure = _repository.GetReportStructure(id);
            var result = new Utils().ConvertReportStructureToFields(structure);

            return Content(result);
        }
        public ActionResult RowUpdate(string datf, string kodf, string oldKodp, string kodp, string znap, string nbuc)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repository.UpdateRow(datf, kodf, oldKodp, kodp, znap, nbuc);
                result.status = JsonResponseStatus.Ok;
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult RowInsert(string datf, string kodf, string kodp, string znap, string nbuc)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repository.InsertRow(datf, kodf, kodp, znap, nbuc);
                result.status = JsonResponseStatus.Ok;
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult RowDelete(string datf, string kodf, string kodp, string nbuc)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repository.DeleteRow(datf, kodf, kodp, nbuc);
                result.status = JsonResponseStatus.Ok;
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        // return ArchiveGrid 
        public ActionResult GetArchiveGrid(string kodf)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repository.ArchiveGrid(kodf); // need to add!!!
                result.status = JsonResponseStatus.Ok;
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
    }
}