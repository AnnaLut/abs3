using System.Web.Mvc;
using BarsWeb.Areas.Reporting.Infrastructure;
using BarsWeb.Areas.Reporting.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Controllers;
using System;
using BarsWeb.Models;
using System.Text;
using System.Net;
using BarsWeb.Core.Logger;
using Ninject;
using System.IO;
using BarsWeb.Infrastructure.Helpers;
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
        const string DETAILED_FILE = "nbu.xlsx";
        const string DETAILED_ARCHIVE = "nbu.zip";
        private readonly INbuRepository _repository;
        [Inject]
        public IDbLogger Logger { get; set; }
        public NbuController(INbuRepository repository)
        {
            _repository = repository;
        }
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult GetStructure(string fileCodeBase64, string schemeCode, string isCon)
        {
            var bytesFileCodeBase64 = Convert.FromBase64String(fileCodeBase64);
            string fileCode = Encoding.UTF8.GetString(bytesFileCodeBase64);
            var structure = _repository.GetReportStructure(fileCode, schemeCode);

            var result = new Utils().ConvertReportStructureToFields(structure);
            return Content(result);
        }

        public decimal? GetCustType(decimal rnk)
        {
            var custType = _repository.GetCustType(rnk);
            return custType;
        }

        public JsonResult fileInitialInfo(string id, string kf)
        {
            JsonResponse result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                var data = _repository.GetFileInitialInfo(Convert.ToInt32(id), kf);
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
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
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
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
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
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
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        // return ArchiveGrid 
        public ActionResult GetArchiveGrid(string fileCodeBase64, string kf, string reportDate)
        {
            if (string.IsNullOrEmpty(fileCodeBase64) || fileCodeBase64 == "undefined")
            {
                Response.StatusCode = (int)HttpStatusCode.BadRequest;
                return Content("немає кода файла");
            }
            Logger.Debug("begin GetArchiveGrid");
            byte[] bytesFileCodeBase64;
            string fileCode = "";
            var result = new JsonResult();
            try
            {
                if (!string.IsNullOrEmpty(fileCodeBase64))
                {
                    bytesFileCodeBase64 = Convert.FromBase64String(fileCodeBase64);
                    fileCode = Encoding.UTF8.GetString(bytesFileCodeBase64);
                }

                var data = _repository.ArchiveGrid(fileCode, kf, reportDate); // need to add!!!
                Logger.Debug("return data:    " + data.ToString());
                return Json(data, JsonRequestBehavior.AllowGet);
                //result.status = JsonResponseStatus.Ok;
            }
            catch (Exception e)
            {

                Response.StatusCode = (int)HttpStatusCode.BadRequest;
                return Content(e.Message);

            }
            // return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetVersions(string fileCodeBase64, string reportDate, string kf)
        {
            Logger.Debug("begin gerVersions");
            var bytesFileCodeBase64 = Convert.FromBase64String(fileCodeBase64);
            string fileCode = Encoding.UTF8.GetString(bytesFileCodeBase64);
            var result = new JsonResult();
            try
            {
                var data = _repository.GetVersion(reportDate, kf, fileCode); // need to add!!!
                Logger.Debug("return data ");
                return Json(data, JsonRequestBehavior.AllowGet);
                //result.status = JsonResponseStatus.Ok;
            }
            catch (Exception e)
            {
                Logger.Exception(e);
                Response.StatusCode = (int)HttpStatusCode.BadRequest;
                return Content(e.Message);

            }
        }

        [HttpGet]
        public FileResult GetExcel(string fName)
        {


            string tempDirName = System.IO.Path.GetDirectoryName(fName);
            FileResult result;

            if (string.IsNullOrEmpty(fName) || !System.IO.File.Exists(fName))
            {
                return File(Encoding.UTF8.GetBytes(string.Format("Файл не знайдено {0}", fName)), "text/plain", "ExceptionGetFile.txt");
            }
            string ext = fName.Substring(fName.LastIndexOf('.'));
            try
            {

                switch (ext)
                {
                    case ".zip":
                        return File(System.IO.File.ReadAllBytes(fName), "application/zip", DETAILED_ARCHIVE);
                    case ".csv":
                        return File(System.IO.File.ReadAllBytes(fName), "attachment", Path.GetFileName(fName));
                    default:
                        return File(System.IO.File.ReadAllBytes(fName), "attachment", DETAILED_FILE);
                }

            }
            catch (Exception ex)
            {
                Logger.Exception(ex);
                Logger.Error("GetExcel (reporting/nbu/getexcel): " + ex.Message);
                return File(Encoding.UTF8.GetBytes(ex.Message), "text/plain", "ExceptionGetFile.txt");
            }
            finally
            {
                if (ext.Contains(".zip") || ext.Contains(".csv"))
                    BaseIOHelper.DeleteDir(tempDirName);
                else
                    System.IO.File.Delete(fName);

            }

        }
    }
}