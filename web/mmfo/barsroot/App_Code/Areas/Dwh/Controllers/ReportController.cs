using System;
using System.Activities.Expressions;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.Mvc;
using BarsWeb.Controllers;
using BarsWeb.Areas.Dwh.Infrastructure.Repository.DI.Abstract;
using Kendo.Mvc.UI;
using Kendo.Mvc.Extensions;
using System.Text;
using Newtonsoft.Json;
using BarsWeb.Areas.Dwh.Models;
using System.Web;
using System.IO.Compression;
using Bars.Web.Report;
using ICSharpCode.SharpZipLib.Zip;

namespace BarsWeb.Areas.Dwh.Controllers
{
    [CheckAccessPage]
    [Authorize]
    public class ReportController : ApplicationController
    {
        private readonly IReportRepository _repository;
        public ReportController(IReportRepository repository)
        {
            _repository = repository;
        }

        public ActionResult Index(string moduleId)
        {
            ViewBag.Module = moduleId;
            return View();
        }
        public ActionResult GridByModule(string moduleId)
        {
            ViewBag.Module = moduleId;
            return View();
        }

        public ActionResult GridByModule_Read(DataSourceRequest request, string moduleId)
        {
            var reports = _repository.ReportData(request, moduleId);
            DataSourceResult result = reports.ToList().ToDataSourceResult(request);
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GridResults(string moduleId)
        {
            ViewBag.ModuleID = moduleId;
            return View();
        }
        public ActionResult GridResults_Read(DataSourceRequest request, string moduleId)
        {
            var results = _repository.ReportResultData(request, moduleId);
            DataSourceResult resultData = results.ToList().ToDataSourceResult(request);
            return Json(resultData, JsonRequestBehavior.AllowGet);
        }
        public ActionResult Display(decimal id, string moduleId)
        {
            var report = _repository.ReportItem(id, moduleId);
            var parameters = new FrxParameters();
            if (!string.IsNullOrWhiteSpace(report.PARAMS))
            {
                parameters = BindParamsFromUrl(JsonConvert.DeserializeObject<IEnumerable<ReportParam>>(report.PARAMS));
            }
            var webReport = new FrxDoc(
                FrxDoc.GetTemplatePathByFileName(report.TEMPLATE_NAME),
                parameters,
                null);
            //return View(webReport.GetWebReport());
            return View(webReport);
        }
        
        public ActionResult Download(decimal id, string moduleId)
        {
            var report = _repository.ReportItem(id, moduleId);
            var parameters = new FrxParameters();
            if (!string.IsNullOrWhiteSpace(report.PARAMS))
            {
                parameters = BindParamsFromUrl(JsonConvert.DeserializeObject<IEnumerable<ReportParam>>(report.PARAMS));
            }
            var webReport = new FrxDoc(
                FrxDoc.GetTemplatePathByFileName(report.TEMPLATE_NAME),
                parameters,
                null);
            var ms = new MemoryStream();
            //webReport.ExportToMemoryStream(FrxExportTypes.Excel2007, ms);

            var fileName = _repository.GetResultFileName(id, ParamsToXml(parameters));

            return File(ms, "application/vnd.ms-excel",fileName);
        }

        private string ParamsToXml(IEnumerable<FrxParameter> parameters)
        {
            var paramsForBase = new StringBuilder();
            paramsForBase.Append("<ReportParams>");
            foreach (var item in parameters)
            {
                string paramValue;
                if (item.Type == TypeCode.DateTime)
                {
                    var d = (DateTime)item.Value;
                    paramValue = d.Date.ToShortDateString();
                }
                else
                {
                    paramValue = item.Value.ToString();
                }
                paramsForBase.AppendFormat("<Param Id=\"{0}\" Value=\"{1}\" />", item.Name, paramValue);
            }
            paramsForBase.Append("</ReportParams>");

            return paramsForBase.ToString();
        }

        public ActionResult Enqueue(decimal id, string moduleId)
        {
            var report = _repository.ReportItem(id, moduleId);
            var parameters = new FrxParameters();
            if (!string.IsNullOrWhiteSpace(report.PARAMS))
            {
                parameters = BindParamsFromUrl(JsonConvert.DeserializeObject<IEnumerable<ReportParam>>(report.PARAMS));
            }
            _repository.EnqueueReport(id, ParamsToXml(parameters));
            return Json(new { status = "ok" }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult DownloadResults(decimal id, string moduleId)
        {
            var reports = _repository.GetReportResults(id);
            if (reports == null)//|| !reports.Any()
            {
                throw new HttpException(404, "Reports not found!");
            }
            MemoryStream str = new MemoryStream();
            ZipOutputStream zip = new ZipOutputStream(str);
            byte[] data = null;
            string tempFile = Path.GetTempFileName();
                
            foreach (var report in reports)
            {
              // System.IO.File.WriteAllBytes(tempFile, data);
                //ZipEntry zipEntry = new ZipEntry(Path.GetFileName(report.RESULT_FILE_NAME));
                //zip.PutNextEntry(zipEntry);
                //FileStream fs = System.IO.File.Create(report.RESULT_FILE_NAME);
                //byte[] buffer = report.FIL;
                //fs.Read(buffer, 0, buffer.Length);
                //zip.Write(buffer, 0, buffer.Length);
                //fs.Close();

                ZipEntry zipEntry = new ZipEntry(Path.GetFileName(report.RESULT_FILE_NAME));
                zip.PutNextEntry(zipEntry);
                FileStream fs = System.IO.File.Create(tempFile);
                byte[] buffer = report.FIL;
                fs.Read(buffer, 0, buffer.Length);
                zip.Write(buffer, 0, buffer.Length);
                fs.Close();
            }

            zip.Close();
            str.Close();
            var fileName = "reports.zip";
            var repQuery = _repository.GetAllReportResults(moduleId).SingleOrDefault(q => q.ID == id);
            if (repQuery != null && !String.IsNullOrEmpty(repQuery.FILE_NAMES))
            {
                fileName = repQuery.FILE_NAMES;   
            }
            
            return File(str.ToArray(), "application/zip", fileName);
        }


        public ActionResult DropResult(decimal id)
        {
            _repository.DropReport(id);
            return Json(new { status = "ok" }, JsonRequestBehavior.AllowGet); 
        }
        
        public ActionResult RegionsBook()
        {
            return View();
        }
        public ActionResult RegionsBookGrid(DataSourceRequest request)
        {
            var regions = _repository.GetRegions().ToList();
            DataSourceResult result = regions.ToDataSourceResult(request);
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        private FrxParameters BindParamsFromUrl(IEnumerable<ReportParam> listParam)
        {
            var list = new FrxParameters();
            foreach (var item in listParam)
            {
                var typeCode = ConvertStringToTypeCode(item.Type);
                var value = CotvertObjectToType(typeCode, HttpContext.Request.Params.Get(item.Name));
                list.Add(new FrxParameter(
                    item.Name,
                    typeCode,
                    value));
            }

            return list;
        }
        private object CotvertObjectToType(TypeCode type, object value)
        {

            switch (type)
            {
                case TypeCode.DateTime:
                    if (string.IsNullOrWhiteSpace(Convert.ToString(value)))
                    {
                        return null;
                    }
                    return Convert.ToDateTime(value);
                case TypeCode.Decimal:
                    if (string.IsNullOrWhiteSpace(Convert.ToString(value)))
                    {
                        return null;
                    }
                    return Convert.ToDecimal(value);
                default :
                    return Convert.ToString(value);
            }
        }

        private TypeCode ConvertStringToTypeCode(string str)
        {
            switch (str)
            {
                case "Date":
                    return TypeCode.DateTime;
                case "Decimal":
                    return TypeCode.Decimal;
                default:
                    return TypeCode.String;
            }
        }
    }
}