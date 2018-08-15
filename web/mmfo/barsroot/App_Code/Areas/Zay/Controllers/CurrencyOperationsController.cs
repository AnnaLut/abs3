using System.Web.Mvc;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Controllers;
using System;
using BarsWeb.Core.Logger;
using BarsWeb.Core.Models.Json;

namespace BarsWeb.Areas.Zay.Controllers
{
    public class CurrencyOperationsController : ApplicationController
    {
        private readonly ICurrencyOperations _repo;
        private readonly IDbLogger _logger;

        public CurrencyOperationsController(ICurrencyOperations repo)
        {
            _repo = repo;
            _logger = DbLoggerConstruct.NewDbLogger();
        }

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GetCustomerNmk(decimal rnk)
        {
            try
            {
                var nmkArr = _repo.GetCustomerNmk(rnk);
                if (nmkArr.Count == 0)
                    throw new Exception();

                return Json(nmkArr[0].NMK, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                var errText = "Не знайден клієнт з заданим РНК!";
                errText = null;
                return Json(errText, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult GetTabvalName(decimal dfKV)
        {
            try
            {
                var nmkArr = _repo.GetTabvalName(dfKV);
                if (nmkArr.Count == 0)
                    throw new Exception();

                return Json(nmkArr[0].NAME, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                string errText = null;
                return Json(errText, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult GetApplication(decimal dfID, decimal dfKV, decimal dfRNK, decimal nDk)
        {
            JsonResponse JsonResult = new JsonResponse("ok"); 
            try
            {
                var nmkArr = _repo.GetApplication(dfID, dfKV, dfRNK, nDk);
                if (nmkArr.Count == 0)
                {
                    JsonResult.Status = "error";
                    JsonResult.Message = "Заявка із заданими параметрами не знайдена!";
                }
                else
                {
                    JsonResult.Data = nmkArr[0];
                }
            }
            catch (Exception ex)
            {
                JsonResult.Status = "error";
                JsonResult.Message = ex.Message;
            }
            return Json(JsonResult, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetNrefSos(decimal nRef)
        {
            try
            {
                var nmkArr = _repo.GetNrefSos(nRef);
                if (nmkArr.Count == 0)
                    throw new Exception();

                return Json(nmkArr[0].NREFSOS, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                string errText = null;
                return Json(errText, JsonRequestBehavior.AllowGet);
            }
        }
     //   [HttpPost]
        public ActionResult DeleteApplication(decimal dfID)
        {
            try
            {
                _repo.DeleteApplication(dfID);
                _logger.Info(string.Format("ZAY9. Видалена заявка № {0}", dfID), "ZAY9");
                return Json(new {success = "Success"}, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                string errText = ex.Message;
                return Json(new { error = errText }, JsonRequestBehavior.AllowGet);
            }
        }
        [HttpPost]
        public ActionResult RestoreApplication(decimal dfID)
        {
            try
            {
                _repo.RestoreApplication(dfID);
                _logger.Info(string.Format("ZAY9. Відновлена заявка № {0}", dfID), "ZAY9");
                return Json(new { success = "Success" }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                string errText = ex.Message;
                return Json(new { error = errText }, JsonRequestBehavior.AllowGet);
            }
        }
    }
}