using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sep.Models;
using BarsWeb.Controllers;
using BarsWeb.Models;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using System;
using System.Linq;
using System.Web.Mvc;



namespace BarsWeb.Areas.Sep.Controllers
{
    //[CheckAccessPage]
    [AuthorizeUser]
    public class SepFutureDocsController : ApplicationController
    {

        private readonly ISepFutureDocsRepository _repo;
        private IParamsRepository _kernelParams;
        private IKendoRequestTransformer _requestTransformer;

        public SepFutureDocsController(ISepFutureDocsRepository repository, IParamsRepository kernelParams, IKendoRequestTransformer requestTransformer)
        {
            _repo = repository;
            _kernelParams = kernelParams;
            _requestTransformer = requestTransformer;
        }

        public ActionResult Index(AccessType accessType, bool? isBack)
        {
            int mfo = 0;
            int.TryParse(_kernelParams.GetParam("MFO").Value, out mfo);
            ViewBag.MFO = mfo;

            return View();
        }

        public ActionResult GetSepFutureDoc([DataSourceRequest] DataSourceRequest request)
        {
            var res = _repo.GetSepFutureDoc();
            var _request = _requestTransformer.CenturaDateFilterValue(request, new[] { "datval" });
            return Json(res.ToDataSourceResult(_request), JsonRequestBehavior.AllowGet);
        }

        public ActionResult SetSepFutureDoc(decimal? ref_, DateTime? datd)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repo.SetSepFutureDoc(ref_, datd);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = "Виникла помилка SetSepFutureDoc";
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult RemoveSepFutureDoc(decimal? ref_)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repo.RemoveSepFutureDoc(ref_);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = "Виникла помилка RemoveSepFutureDoc";
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetSepFutureDocAccount(decimal? ref_)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                var acc = _repo.GetSepFutureDocAccount(ref_);
                result.data = acc;

            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = "Виникла помилка GetSepFutureDocAccount";
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
    }
}