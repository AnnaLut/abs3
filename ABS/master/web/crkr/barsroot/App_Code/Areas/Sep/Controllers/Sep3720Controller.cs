using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sep.Models;
using BarsWeb.Controllers;
using BarsWeb.Models;
using Kendo.Mvc.UI;
using System;
using System.Linq;
using System.Web.Mvc;

namespace BarsWeb.Areas.Sep.Controllers
{
    [CheckAccessPage]
    [Authorize]
    public class Sep3720Controller : ApplicationController
    {
        private readonly ISep3720Repository _repo;
        private readonly IErrorsRepository _errors;
        private readonly IParamsRepository _paramsRepo;
        public Sep3720Controller(ISep3720Repository repository, IErrorsRepository errorRepo, IParamsRepository paramsRepo)
        {
            _repo = repository;
            _errors = errorRepo;
            _paramsRepo = paramsRepo;
        }
        public ActionResult Index(AccessType accessType)
        {
            ViewBag.Ord902Param = _paramsRepo.GetParam("ORD902").Value;
            ViewBag.SumT902 = _repo.GetSumT902();
            //ViewBag.RefCount = _repo.GetSep3720Count(accessType);
            return View(accessType);
        }
        public ActionResult GetSep3720List([DataSourceRequest] DataSourceRequest request, AccessType accessType)
        {
            IQueryable<Sep3720> fileList = _repo.GetSep3720List(request, accessType);
            decimal total = _repo.GetSep3720Count(accessType, request);
            return Json(new { Data = fileList, Total = total }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult DeleteRecord(int delSepREFnumber)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repo.DeleteSep3720Record(delSepREFnumber);
                result.message = string.Format("Файл за номером {0} учпішно видалено.", delSepREFnumber);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetAccount(int accNumber)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                var account = _repo.GetAccount().Where(acc => acc.ACC == accNumber).Select(acc => acc).SingleOrDefault();
                result.data = new { account.NLS, account.NMS };
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult SetRequest(string requestList, string recordNumber)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                var requestedDoc = _repo.SetRequest(requestList);
                if (requestedDoc == 1)
                {
                    result.message = "Сформовано " + requestedDoc + " запитів";
                }
                else
                {
                    result.message = "Неможливо сформувати запит на уточнення реквізитів документа " + recordNumber;
                }
                
            }
            catch (Exception e) 
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetAltAccount(string nls, int kv)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                var altAccount = _repo.GetAltAccount(nls, kv);
                result.data = altAccount;
            }
            catch (Exception e) 
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult ToAltAccounts(string docList, int rowSelected)
        {
           var result = new JsonResponse(JsonResponseStatus.Ok);
           try
           {
                var successedDoc = _repo.SetToAltAccounts(docList);
                if (successedDoc == rowSelected)
                {
                   result.message = "Проведено всі " + successedDoc + " документів";
                }
                else
                {
                   result.message = "Не всі документи проведено";
                }
           }
           catch (Exception e)
           {
                result.status = JsonResponseStatus.Error;
                result.message = "Виникла помилка при проведенні документів";
           }
           return Json(result, JsonRequestBehavior.AllowGet);   
        }
    }
}