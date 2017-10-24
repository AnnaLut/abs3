using System;
using System.Web.Mvc;
using BarsWeb.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sep.Models;
using BarsWeb.Controllers;
using Kendo.Mvc.UI;
using System.IO;
using Newtonsoft.Json;
using System.Collections.Generic;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using System.Text;
using Bars.DocPrint;
using System.Text.RegularExpressions;

namespace BarsWeb.Areas.Sep.Controllers
{
    [CheckAccessPage]
    [AuthorizeUser]
    public class SepFilesController : ApplicationController
    {
        private readonly ISepFilesRepository _repo;
        private readonly IErrorsRepository _errors;
        private readonly IKendoRequestTransformer _requestTransformer;
        private readonly ISepParams _repoSepParam;
        public SepFilesController(ISepFilesRepository repository, IErrorsRepository errorsRepo, IKendoRequestTransformer requestTransformer, ISepParams repoSepParam)
        {
            _repo = repository;
            _errors = errorsRepo;
            _requestTransformer = requestTransformer;
            _repoSepParam = repoSepParam;
        }
        public ActionResult GetSepFilesList([DataSourceRequest] DataSourceRequest request, SepFilesFilterParams customFilter)
        {
            var tmpRequest = _requestTransformer.MultiplyFilterValue(request, new[] { "SDE", "SKR" });
            var fileList = _repo.GetSepFilesInfo(customFilter, tmpRequest);
            decimal total = _repo.GetSepFilesCount(customFilter, tmpRequest);
            Session["sepFilesRequest"] = request;
            Session["sepFilesFilter"] = customFilter;
            return Json(new { Data = fileList, Total = total }, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult Recreate(List<SepFileDocParams> docMultyParams)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            result.message = "";
            if (docMultyParams == null)
            {
                throw new Exception("Невдалося передати інформацію про файли");
            }
            foreach (var docParams in docMultyParams)
            {
                try
                {
                    _repo.RecreateZagB(docParams.FileName, docParams.FileCreated);
                    result.message += string.Format("Файл '{0}' успішно переформовано.\n", docParams.FileName);
                }
                catch (Exception e)
                {
                    result.status = JsonResponseStatus.Error;
                    result.message += e.InnerException == null ? e.Message : e.InnerException.Message;
                }
            }
            return Json(result, JsonRequestBehavior.AllowGet); 
        }

        [HttpPost]
        public ActionResult MatchSepFile(List<SepFileMatchParams> docMultyParams)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            result.message = "";
            if (docMultyParams == null)
            {
                throw new Exception("Невдалося передати інформацію про файли");
            }
            foreach (var matchParams in docMultyParams)
            { 
                try
                {
                
                    int error = _repo.MatchSepFile(matchParams);
                    if (error <= 0)
                    {
                        result.message += string.Format("Файл '{0}' сквитовано.\n", matchParams.FileName);
                    }
                    else
                    {
                        string errCode = error < 1000 ? "0" : "" + error;
                        var sError = _errors.GetSErrorByCode(errCode);
                        string errMsg;
                        if (sError != null)
                        {
                            errMsg = string.Format("Проблеми з файлом {0}: Код помилки: {1}-{2}\n", matchParams.FileName, sError.K_ER, sError.N_ER);
                        }
                        else
                        {
                            errMsg = "Невідома помилка квитовки файлу.\n";
                        }
                        throw new Exception(errMsg);
                    }
                }
                catch (Exception e)
                {
                    result.status = JsonResponseStatus.Error;
                    result.message += e.InnerException == null ? e.Message : e.InnerException.Message;
                }
            }
            return Json(result, JsonRequestBehavior.AllowGet); 
        }
        [HttpPost]
        public ActionResult UnCreateSepFile(List<SepFileUncreateParams> uncreateMultyParams)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            result.message = "";
            if (uncreateMultyParams == null)
            {
                throw new Exception("Невдалося передати інформацію про файли\n");
            }
            foreach (var uncreateParams in uncreateMultyParams)
            {
                try
                {
                    int error = _repo.UnCreateSepFile(uncreateParams);
                    if (error <= 0)
                    {
                        result.message += string.Format("Файл '{0}' успішно розформовано.\n", uncreateParams.FileName);
                    }
                    else
                    {
                        string errCode = error < 1000 ? "0" : "" + error;
                        var sError = _errors.GetSErrorByCode(errCode);
                        string errMsg;
                        if (sError != null)
                        {
                            errMsg = string.Format("Проблеми з файлом {0}: Код помилки: {1}-{2}\n", uncreateParams.FileName,sError.K_ER, sError.N_ER);
                        }
                        else
                        {
                            errMsg = "Невідома помилка розформування файлу.\n";
                        }
                        throw new Exception(errMsg);
                    }
                }
                catch (Exception e)
                {
                    result.status = JsonResponseStatus.Error;
                    result.message += e.InnerException == null ? e.Message : e.InnerException.Message;
                }
            }
            return Json(result, JsonRequestBehavior.AllowGet); 
        }
        [HttpPost]
        public ActionResult DeleteSepFile(List<SepFilesDelParams> delMultyParams)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            result.message = "";
            if (delMultyParams == null)
            {
                throw new Exception("Невдалося передати інформацію про файли\n");
            }
            foreach (var delParams in delMultyParams)
            {
                try
                {
                    _repo.DeleteSepFile(delParams);
                    result.message += string.Format("Файл '{0}' успішно видалено.\n", delParams.FileName);
                }
                catch (Exception e)
                {
                    result.status = JsonResponseStatus.Error;
                    result.message += e.InnerException == null ? e.Message : e.InnerException.Message;
                }
            }
            return Json(result, JsonRequestBehavior.AllowGet); 
        }
        public ActionResult Index(AccessType accessType, bool? isBack,bool? onlyRead)
        {
            ViewBag.Request = null;
            ViewBag.CustomFilter = null;
            if (isBack != null && isBack.Value == true)
            {
                ViewBag.Request = Session["sepFilesRequest"];
                ViewBag.CustomFilter = Session["sepFilesFilter"];
                ViewBag.AccessType = Session["sepFilesAccesstype"];
            }
            else
            {
                Session["sepFilesAccesstype"] = accessType;
            }
            if (onlyRead == null)
            {
                ViewBag.ReadType = false;
            }
            else
            {
                ViewBag.ReadType = onlyRead;
            }
            return View(accessType);
        }

        public ActionResult RequestIps(string docListJson)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                SepFileDoc[] docs = JsonConvert.DeserializeObject<SepFileDoc[]>(docListJson);
                foreach (SepFileDoc doc in docs)
                {
                    _repo.DoIpsRequest(doc);    
                }
                var flagsFileDit = _repoSepParam.GetParam("INFORMATIONAL_FLAGS_DIR").Value;
                FileStream kFile = new FileStream(flagsFileDit + "\\Q", FileMode.Create, FileAccess.ReadWrite);
                kFile.Close();
                result.message = string.Format("Запит до ІПС на вибрані документи СЕП успішно сформовано!");
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? result.message = "Параметр INFORMATIONAL_FLAGS_DIR відсутній у таблиці SEP_PARAMS. </br>" + "Причина помилки: " + e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet); 
        }
        public ActionResult SaveFile(string save_type, string rec, string templateName, bool modelbuh = false)
        {
            string app_type = "";
            string file_type = "";
            decimal REC = Convert.ToDecimal(rec);

            string templatePath = FrxDoc.GetTemplatePathByFileName(templateName);
            FrxParameters pars = new FrxParameters()
            {
                new FrxParameter("p_rec", TypeCode.Decimal, REC)
            };
            FrxDoc doc = new FrxDoc(templatePath, pars, null);

            using (var str = new MemoryStream())
            {
                if (save_type == "pdf")
                {
                    doc.ExportToMemoryStream(FrxExportTypes.Pdf, str);
                    app_type = "application/pdf";
                    file_type = ".pdf";
                }
                if (save_type == "txt")
                {
                    MemoryStream stream = new MemoryStream();
                    doc.ExportToMemoryStream(FrxExportTypes.Text, stream);
                    string buffer = Encoding.UTF8.GetString(stream.ToArray());
                    buffer = buffer.Replace("\f\r", string.Empty);

                    MemoryStream treat = new MemoryStream();
                    StreamWriter writer = new StreamWriter(treat);
                    writer.Write(buffer);
                    writer.Flush();
                    treat.Position = 0;
                    app_type = "text/plain";
                    file_type = ".txt";
                    return File(treat.ToArray(), app_type, "report" + file_type);
                }
                if (save_type == "doc")
                {
                    doc.ExportToMemoryStream(FrxExportTypes.Word2007, str);
                    app_type = "application/word";
                    file_type = ".doc";
                }
                return File(str.ToArray(), app_type, "report" + file_type);
            }
        }

        [HttpGet]
        public ActionResult PrintRecDoc(string save_type, string rec, string templateName, bool modelbuh = false)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                var path = _repo.CreateFileRec(save_type, rec, templateName, modelbuh);
                return Json(path, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;

                //return Json(JsonResponseStatus.Error, JsonRequestBehavior.AllowGet);
                return Json(result, JsonRequestBehavior.AllowGet); 
            }
        }
    }
}