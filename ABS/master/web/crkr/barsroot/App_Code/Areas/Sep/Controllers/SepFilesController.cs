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
        public ActionResult Recreate(SepFileDocParams docParams)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repo.RecreateZagB(docParams.FileName, docParams.FileCreated);
                result.message = string.Format("Файл '{0}' успішно переформовано.", docParams.FileName);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet); 
        }
        public ActionResult MatchSepFile(SepFileMatchParams matchParams)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                int error = _repo.MatchSepFile(matchParams);
                if (error <= 0)
                {
                    result.message = string.Format("Файл '{0}' сквитовано.", matchParams.FileName);
                }
                else
                {
                    string errCode = error < 1000 ? "0" : "" + error;
                    var sError = _errors.GetSErrorByCode(errCode);
                    string errMsg;
                    if (sError != null)
                    {
                        errMsg = string.Format("Код помилки: {0}-{1}", sError.K_ER, sError.N_ER);
                    }
                    else
                    {
                        errMsg = "Невідома помилка квитовки файлу.";
                    }
                    throw new Exception(errMsg);
                }
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet); 
        }
        public ActionResult UnCreateSepFile(SepFileUncreateParams uncreateParams)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                int error = _repo.UnCreateSepFile(uncreateParams);
                if (error <= 0)
                {
                    result.message = string.Format("Файл '{0}' успішно розформовано.", uncreateParams.FileName);
                }
                else
                {
                    string errCode = error < 1000 ? "0" : "" + error;
                    var sError = _errors.GetSErrorByCode(errCode);
                    string errMsg;
                    if (sError != null)
                    {
                        errMsg = string.Format("Код помилки: {0}-{1}", sError.K_ER, sError.N_ER);
                    }
                    else
                    {
                        errMsg = "Невідома помилка розформування файлу.";
                    }
                    throw new Exception(errMsg);
                }
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet); 
        }
        public ActionResult DeleteSepFile(SepFilesDelParams delParams)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repo.DeleteSepFile(delParams);
                result.message = string.Format("Файл '{0}' успішно видалено.", delParams.FileName);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet); 
        }
        public ActionResult Index(AccessType accessType, bool? isBack)
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
                var flagsFileDit = _repoSepParam.GetParam("INT_DIR").Value;
                FileStream kFile = new FileStream(flagsFileDit + "\\Q", FileMode.Create, FileAccess.ReadWrite);
                kFile.Close();
                result.message = string.Format("Запит до ІПС на вибрані документи СЕП успішно сформовано!");
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet); 
        }
    }
}