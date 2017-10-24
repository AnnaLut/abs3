using System;
using System.Linq;
using System.Web.Mvc;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Zay.Models;
using BarsWeb.Models;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Zay.Controllers
{
    [CheckAccessPage]
    [AuthorizeUser]
    public class MandatorySaleController : Controller
    {
        private IMandatorySaleRepository _repo;
        private IZayParams _zayParams;
        private IParamsRepository _kernelParams;
        public MandatorySaleController(IMandatorySaleRepository repo, IZayParams zayParams, IParamsRepository kernelParams)
        {
            _repo = repo;
            _zayParams = zayParams;
            _kernelParams = kernelParams;
        }

        public ActionResult GetMandatoryCurrSaleList([DataSourceRequest] DataSourceRequest request)
        {
            var msaleList = _repo.GetMandatorySaleList(request).ToList();
            decimal total = _repo.GetMandatorySaleCount(request);
            return Json(new { Data = msaleList, Total = total }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult Index()
        {
            string tmp = _zayParams.GetParam("OBZ_1919").Value;
            if (String.IsNullOrEmpty(tmp))
            {
                tmp = "0";
            }
            ViewBag.nObz1919 = tmp;

            int baseVal = 0;
            ViewBag.baseVal = int.TryParse(_kernelParams.GetParam("BASEVAL").Value, out baseVal);
            ViewBag.baseVal = baseVal;
            
            return View();
        }

        public ActionResult DelItem(decimal refDoc)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repo.DelZay(refDoc);
            }
            catch (Exception ex)
            {
                result.status = JsonResponseStatus.Error;
                result.message = "Виникла помилка в ході зняття заявки з контролю! <br/>" + 
                    ex.InnerException == null ? ex.Message : ex.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet); 
        }

        public ActionResult GetZayLinkedDocs([DataSourceRequest] DataSourceRequest request, decimal docRef)
        {
            var docList = _repo.GetZayLinkedDocs(docRef, request);
            decimal total = _repo.GetZayLinkedDocCount(docRef, request);
            return Json(new { Data = docList, Total = total }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult LinkedDocs(decimal? docRef)
        {
            return View(docRef);

        }

        public ActionResult GetD27Params(decimal docRef)
        {
            var nazn = _repo.GetOperNazn(docRef);
            return Json(new {nazn}, JsonRequestBehavior.AllowGet);
        }

        public ActionResult CreateBid(ZayDebt bidParams)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repo.DoZayDebt(bidParams);
            }
            catch (Exception ex)
            {
                result.status = JsonResponseStatus.Error;
                result.message = "Виникла помилка в ході оформлення завки! <br/>" + 
                    ex.InnerException == null ? ex.Message : ex.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet); 
        }
    }
}