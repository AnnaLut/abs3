using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sep.Models;
using BarsWeb.Controllers;
using BarsWeb.Models;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;


namespace BarsWeb.Areas.Sep.Controllers
{
    //[CheckAccessPage]
    [AuthorizeUser]
    public class SepLockDocsController : ApplicationController
    {
        private readonly ISepLockDocsRepository _repo;
        private IParamsRepository _kernelParams;
        private readonly IKendoRequestTransformer _requestTransformer;
        public SepLockDocsController(ISepLockDocsRepository repo, IParamsRepository kernelParams, IKendoRequestTransformer requestTransformer)
        {
            _requestTransformer = requestTransformer;
            _kernelParams = kernelParams;
            _repo = repo;
            
        }

        public ActionResult Index()
        {
            ViewBag.MFO = _kernelParams.GetParam("MFO").Value;
            ViewBag.IsValidDate = _repo.isValidUserBankDate();
            return View();
        }

        public ActionResult GetSepLockDoc(int? DefCode, [DataSourceRequest] DataSourceRequest request)
        {
            int def = DefCode == null ? 0 : DefCode.Value;
            var _request = _requestTransformer.MultiplyFilterValue(request, new string[] { "s" });
            var res = _repo.GetSepLockDoc(def, 0, _request);
            var total = _repo.GetSepLockDocCount(def, 0, _request);
            return Json(new { Data = res, Total = total }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GeSepLockDocsByCodeCount(int? DefCode, int Code, [DataSourceRequest] DataSourceRequest request)
        {
            int def = DefCode == null ? 0 : DefCode.Value;
            var _request = _requestTransformer.MultiplyFilterValue(request, new string[] { "s" });
            var count = _repo.GetSepLockDocCount(def, Code, _request);
            return Json(new { Count = count, status = JsonResponseStatus.Ok}, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetSepLockDocResource([DataSourceRequest] DataSourceRequest request)
        {
            var resource = _repo.GetSepLockDocResource(request);
            return Json(new { Resource = resource }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult DeleteSepLockDocs(string Docs, [DataSourceRequest] DataSourceRequest request)
        {
            List<SepLockDoc> listDocs = JsonConvert.DeserializeObject<List<SepLockDoc>>(Docs);
            JsonResponse result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repo.DeleteSepLockDocs(listDocs, request);
            }
            catch (Exception ex)
            {
                result.status = JsonResponseStatus.Error;
                result.message = ex.Message;
                if (ex.InnerException != null)
                {
                    result.message += "<br><pre>" + ex.InnerException.Message + "</pre>";
                }
            }

            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult DeleteSepLockDocsByCode(int? DefCode, int Code, [DataSourceRequest] DataSourceRequest request)
        {
            JsonResponse result = new JsonResponse(JsonResponseStatus.Ok);
            int def = DefCode == null ? 0 : DefCode.Value;

            try
            {
                _repo.DeleteSepLockDocsByCode(def, Code, request);
            }
            catch (Exception ex)
            {
                result.status = JsonResponseStatus.Error;
                result.message = ex.Message;
                if (ex.InnerException != null)
                {
                    result.message += "<br><pre>" + ex.InnerException.Message + "</pre>";
                }
            }

            return Json(result, JsonRequestBehavior.AllowGet);
        }
        
        public ActionResult ReturnSepLockDocs(string Reason, string Docs, [DataSourceRequest] DataSourceRequest request)
        {
            List<SepLockDoc> listDocs = JsonConvert.DeserializeObject<List<SepLockDoc>>(Docs);
            JsonResponse result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repo.ReturnSepLockDocs(Reason, listDocs, request);
            }
            catch (Exception ex)
            {
                result.status = JsonResponseStatus.Error;
                result.message = ex.Message;
                if (ex.InnerException != null)
                {
                    result.message += "<br><pre>" + ex.InnerException.Message + "</pre>";
                }
            }

            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult ReturnSepLockDocsByCode(string Reason, int? DefCode, int Code, [DataSourceRequest] DataSourceRequest request)
        {
            JsonResponse result = new JsonResponse(JsonResponseStatus.Ok);
            int def = DefCode == null ? 0 : DefCode.Value;

            try
            {
                _repo.ReturnSepLockDocsByCode(Reason, def, Code, request);
            }
            catch (Exception ex)
            {
                result.status = JsonResponseStatus.Error;
                result.message = ex.Message;
                if (ex.InnerException != null)
                {
                    result.message += "<br><pre>" + ex.InnerException.Message + "</pre>";
                }
            }

            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult UnLockSepLockDocs(string Docs, [DataSourceRequest] DataSourceRequest request)
        {
            List<SepLockDoc> listDocs = JsonConvert.DeserializeObject<List<SepLockDoc>>(Docs);
            JsonResponse result = new JsonResponse(JsonResponseStatus.Ok);

            try
            {
                _repo.UnlockSepLockDocs(listDocs, request);
            }
            catch (Exception ex)
            {
                result.status = JsonResponseStatus.Error;
                result.message = ex.Message;
                if (ex.InnerException != null)
                {
                    result.message += "<br><pre>" + ex.InnerException.Message + "</pre>";
                }
            }

            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult UnLockSepLockDocsByCode(int? DefCode, int Code, [DataSourceRequest] DataSourceRequest request)
        {
            JsonResponse result = new JsonResponse(JsonResponseStatus.Ok);
            int def = DefCode == null ? 0 : DefCode.Value;

            try
            {
                _repo.UnLockSepLockDocsByCode(def, Code, request);
            }
                        catch (Exception ex)
            {
                result.status = JsonResponseStatus.Error;
                result.message = ex.Message;
                if (ex.InnerException != null)
                {
                    result.message += "<br><pre>" + ex.InnerException.Message + "</pre>";
                }
            }

            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult AcceptSepLockDocs(string Docs, [DataSourceRequest] DataSourceRequest request)
        {
            List<SepLockDoc> listDocs = JsonConvert.DeserializeObject<List<SepLockDoc>>(Docs);
            JsonResponse result = new JsonResponse(JsonResponseStatus.Ok);

            try
            {
                _repo.UnlockSepDocsTo902(listDocs, request);
            }
            catch (Exception ex)
            {
                result.status = JsonResponseStatus.Error;
                result.message = ex.Message;
                if (ex.InnerException != null)
                {
                    result.message += "<br><pre>" + ex.InnerException.Message + "</pre>";
                }
            }

            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult AcceptSepLockDocsByCode(int? DefCode, int Code, [DataSourceRequest] DataSourceRequest request)
        {
            JsonResponse result = new JsonResponse(JsonResponseStatus.Ok);
            int def = DefCode == null ? 0 : DefCode.Value;

            try
            {
                _repo.UnlockSepDocsTo902ByCode(def, Code, request);
            }
            catch (Exception ex)
            {
                result.status = JsonResponseStatus.Error;
                result.message = ex.Message;
                if (ex.InnerException != null)
                {
                    result.message += "<br><pre>" + ex.InnerException.Message + "</pre>";
                }
            }

            return Json(result, JsonRequestBehavior.AllowGet);
        }
    }
}