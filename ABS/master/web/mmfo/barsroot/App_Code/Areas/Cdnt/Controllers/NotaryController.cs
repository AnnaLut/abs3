using System;
using System.Linq;
using BarsWeb.Controllers;
using System.Web.Mvc;
using Areas.Cdnt.Models;
using BarsWeb.Areas.Cdnt.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using BarsWeb.Models;

// ReSharper disable once CheckNamespace
namespace BarsWeb.Areas.Cdnt.Controllers
{
    [CheckAccessPage]
    [Authorize]
    public class NotaryController : ApplicationController
    {
        private readonly ICdntRepository _repo;
        private readonly IBanksRepository _banksRepo;
        public NotaryController(ICdntRepository repo, IBanksRepository banksRepo)
        {
            _repo = repo;
            _banksRepo = banksRepo;
        }
        public ActionResult Index(string mode)
        {
            ViewBag.Mode = mode;
            return View();
        }

        public ActionResult IndexData([DataSourceRequest] DataSourceRequest request, bool onlyNeedAccept)
        {
            var result = _repo.GetNotaries();
            if (onlyNeedAccept)
            {
                result = result.Where(n => n.CNT_REQACCR > 0);
            }
            else
            { 
                result = result.Where(n => n.CNT_REQACCR == 0);
            }
            
            return Json(result.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        public ActionResult CreateNotary(NOTARY data)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                var newId = _repo.AddNotary(data);
                result.data = newId;
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult EditNotary(NOTARY data)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repo.EditNotary(data);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult DeleteNotary(NOTARY notary)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repo.DeleteNotary(notary.ID);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult AccreditationData(decimal notaryId, [DataSourceRequest] DataSourceRequest request)
        {
            return Json(_repo.GetNotaryAccreditations(notaryId).ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        public ActionResult TransactionData(decimal accreditationId, [DataSourceRequest] DataSourceRequest request)
        {
            return Json(_repo.GetTransactions(accreditationId).ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        public ActionResult AccreditationTypes()
        {
            return Json(_repo.GetAccreditationTypes(), JsonRequestBehavior.AllowGet);
        }

        public ActionResult AccreditationStates()
        {
            return Json(_repo.GetAccreditationStates(), JsonRequestBehavior.AllowGet);
        }

        public ActionResult TransactionTypes()
        {
            return Json(_repo.GetTransactionTypes(), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetMfoList()
        {
            return Json(_banksRepo.GetBankList().Select(b => b.Mfo), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetListOfBusiness()
        {
            return Json(_repo.GetSegmentsOfBusiness(), JsonRequestBehavior.AllowGet);
        }

        public ActionResult CreateAccreditation(NOTARY_ACCREDITATION accr)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                var newId = _repo.AddAcreditation(accr);
                result.data = newId;
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetAccBranches(decimal accrId)
        {
            return Json(_repo.GetAccreditationBranches(accrId), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetAccBusinesses(decimal accrId)
        {
            return Json(_repo.GetAccreditationBusinesses(accrId), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetNotaryTypes()
        {
            return Json(_repo.GetNotaryTypes(), JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetDocumentTypes()
        {
            return Json(_repo.GetDocumentTypes(), JsonRequestBehavior.AllowGet);
        }

        public ActionResult EditAccreditation(NOTARY_ACCREDITATION accr)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repo.EditAccreditation(accr);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult CloseAccreditation(decimal accrId)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                var updatedAccr = _repo.CloseAccreditation(accrId);
                result.data = updatedAccr;
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        
        public ActionResult ExportToExcel(string contentType, string base64, string fileName)
        {
            var fileContents = Convert.FromBase64String(base64);

            return File(fileContents, contentType, fileName);
        }
        
    }
}