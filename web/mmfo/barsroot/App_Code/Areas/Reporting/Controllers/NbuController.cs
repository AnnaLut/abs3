﻿using System.Web.Mvc;
using BarsWeb.Areas.Reporting.Infrastructure;
using BarsWeb.Areas.Reporting.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Controllers;
using System;
using BarsWeb.Models;
using System.Text;
using System.Net;
using BarsWeb.Core.Logger;
using Ninject;

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
        public ActionResult GetArchiveGrid(string fileCodeBase64,string kf,string reportDate)
        {
            if (string.IsNullOrEmpty(fileCodeBase64) || fileCodeBase64 == "undefined")
            {
                Response.StatusCode = (int)HttpStatusCode.BadRequest;
                return Content("немає кода файла"); 
            }
            Logger.Debug("begin GetArchiveGrid");
            byte[] bytesFileCodeBase64 ;
            string fileCode = "";
           var result = new JsonResult();
            try
            {
                if(!string.IsNullOrEmpty(fileCodeBase64))
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
            //DataSourceAdapter dataSourceAdapter = new DataSourceAdapter();
            //WebDatasourceModel datasourceModel = JsonToObject<WebDatasourceModel>(gridData) ?? new WebDatasourceModel();
            //var req = dataSourceAdapter.ParsDataSours(datasourceModel);

            //List<Columns> columns = new List<Columns>();

            //string vn = _repository.GetViewName(Encoding.UTF8.GetString(Convert.FromBase64String(fileCodeBase64)), true);
            //List<AllColComments> tc = _repository.GetTableComments(vn);

            //List<string[]> title = new List<string[]>();
            //foreach (AllColComments col in tc)
            //{
            //    if (col.COLUMN_NAME != "DESCRIPTION")
            //    {
            //        title.Add(new string[] { col.COLUMN_NAME, col.COMMENTS });
            //    }                
            //}
            //AllColComments columnDesc = tc.Find((col)=>col.COLUMN_NAME == "DESCRIPTION");
            //if (columnDesc != null)
            //{   
            //    title.Add(new string[] { columnDesc.COLUMN_NAME, columnDesc.COMMENTS });  // put comments to the end of list
            //}

            //List<Dictionary<string, object>> res = _repository.GetDetailedReportDyn(req, vn, Encoding.UTF8.GetString(Convert.FromBase64String(fileCodeBase64)), reportDate, kf, fieldCode, schemeCode);

            //List<TableInfo> ti = _repository.GetTableInfo(vn);

            //var exel = new ExcelHelpers<List<Dictionary<string, object>>>(res, title, ti, null);

            // todo: add filters and sorts
            //List<DetailedReport> res = _repository.GetDetailedReportList(Encoding.UTF8.GetString(Convert.FromBase64String(fileCodeBase64)), reportDate, kf, fieldCode, schemeCode);
            //var exel = new ExcelHelpers<DetailedReport>(res, true);

            if (string.IsNullOrEmpty(fName) || !System.IO.File.Exists(fName))
            {
                throw new Exception(string.Format("Файл не знайдено {0}", fName));
            }

            byte[] fileBytes = System.IO.File.ReadAllBytes(fName);
            try
            {
                System.IO.File.Delete(fName);
            }
            catch (Exception ex) { }
            return File(fileBytes, "attachment", DETAILED_FILE);          
        }
    }    
}