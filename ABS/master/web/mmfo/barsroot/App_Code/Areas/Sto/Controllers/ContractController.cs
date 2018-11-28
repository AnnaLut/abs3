using BarsWeb.Areas.Sto.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Controllers;
using BarsWeb.Models;
using System;
using System.Web.Mvc;
using System.Linq;
using BarsWeb.Areas.Sto.Models;
using Kendo.Mvc.UI;
using Kendo.Mvc.Extensions;

namespace BarsWeb.Areas.Sto.Controllers
{
    [CheckAccessPage]
    [Authorize]
    public class ContractController : ApplicationController
    {
        private readonly IContractRepository _repo;
        public ContractController(IContractRepository repo)
        {
            _repo = repo;
        }
        public ActionResult Index(AccessMode accessMode)
        {
            return View(accessMode);
        }
        public ActionResult GetGroupList([DataSourceRequest] DataSourceRequest request)
        {
            //var list = _repo.GroupData();
            //var result = list.Select(c => new
            //{
            //    c.IDG,
            //    c.NAME
            //}).OrderBy(e => e.IDG).ToDataSourceResult(request);

            var result = _repo.GetGroupsList().ToDataSourceResult(request);

            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetContractList([DataSourceRequest] DataSourceRequest request, int group_id)
        {
            var response = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                //var branch = _repo.CurrentBranch();
                //var list = _repo.ContractData();
                //response.data = list.Where(a => a.BRANCH.Contains(branch)).Select(x => new { x.IDS, x.RNK, x.NAME, x.SDAT, x.IDG, x.KF, x.BRANCH }).ToDataSourceResult(request); 

                response.data = _repo.GetContractDataList(group_id).ToDataSourceResult(request);
            }
            catch (Exception ex) {
                response.status = JsonResponseStatus.Error;
                response.message = ex.Message;
            }
            JsonResult result = Json(response, JsonRequestBehavior.AllowGet);
            result.MaxJsonLength = Int32.MaxValue;
            return result;
        }
        public ActionResult GetContractDetList([DataSourceRequest] DataSourceRequest request, decimal ids)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                var list = _repo.ContractDetData();
                result.data = list.Where(x => x.IDS == ids).Select(a => new { 
                    a.IDS, a.TT, a.NLSA, a.KVA, a.NLSB, a.KVB, a.MFOB,
                    a.POLU, a.NAZN, a.FSUM, a.OKPO, a.DAT1, a.DAT2, a.FREQ, a.DAT0,
                    a.WEND, a.IDD, a.ORD, a.BRANCH, a.BRANCH_MADE,
                    a.DATETIMESTAMP, a.BRANCH_CARD, a.USERID_MADE, a.STATUS_ID,
                    a.DISCLAIM_ID, a.STATUS_DATE, a.STATUS_UID, a.OPERW_EXISTANCE
                }).ToDataSourceResult(request);
            }
            catch (Exception ex)
            {
                result.status = JsonResponseStatus.Error;
                result.message = ex.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetDopRekvForPayment([DataSourceRequest] DataSourceRequest request, decimal paymentIdd)
        {
            JsonResponse result = new JsonResponse(JsonResponseStatus.Ok);
                var dopRekvforPaymentList = _repo.GetDopRekvforPaymentList(paymentIdd);
                var data = dopRekvforPaymentList.ToDataSourceResult(request);
                return Json(data, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetGovCodesValues([DataSourceRequest] DataSourceRequest request)
        {
            JsonResponse result = new JsonResponse(JsonResponseStatus.Ok);

            var dopRekvforPaymentList = _repo.GetGovCodesValue();
            var data = dopRekvforPaymentList.ToDataSourceResult(request);

            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetClaim(string idd, string statusId, string disclaimId)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                var claimReult = _repo.ClaimProc(idd, statusId, disclaimId);
                switch (claimReult)
                {
                    case 0:
                        result.message = "При виконанні функції виникла помилка!";
                        result.status = JsonResponseStatus.Error;
                        break;
                    case 1:
                        result.message = "Функція успішно виконана!";
                        result.status = JsonResponseStatus.Ok;
                        break;
                }
            }
            catch (Exception ex)
            {
                result.status = JsonResponseStatus.Error;
                result.message = ex.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetDisclaimerList([DataSourceRequest] DataSourceRequest request)
        {
            var list = _repo.DisclaimerData();
            var result = list.Where(x => x.ID != 0).Select(c => new
            {
                c.ID,
                c.NAME
            }).OrderBy(e => e.ID).ToDataSourceResult(request);

            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetDetListRowInfo([DataSourceRequest] DataSourceRequest request, decimal idd)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                var list = _repo.DetInfoData();
                result.data = list.Where(x => x.IDD == idd).Select(a => new
                {
                    a.IDD,
                    a.ACTION,
                    a.WHEN,
                    a.USER_MADE,
                    a.USER_CLAIMED,
                    a.STATUS,
                    a.STATUS_DATE,
                    a.DISCLAIM
                }).ToDataSourceResult(request);
            }
            catch (Exception ex)
            {
                result.status = JsonResponseStatus.Error;
                result.message = ex.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetFREQ()
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repo.GetFREQ();
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetTTS()
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repo.GetTTS();
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetNLS(decimal RNK, decimal? KV = null)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repo.GetNLS(RNK, KV);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetKVs(decimal? RNK)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repo.GetKVs(RNK);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetRNKLIST(string OKPO, decimal? RNK)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repo.GetRNKLIST(OKPO, RNK);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetNMK(decimal RNK)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repo.GetNMK(RNK);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
         public ActionResult AddPayment(payment newpayment)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repo.AddPayment(newpayment);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
         public ActionResult AddIDS(ids newids)
         {
             var result = new JsonResponse(JsonResponseStatus.Ok);
             try
             {
                 result.data = _repo.AddIDS(newids);
             }
             catch (Exception e)
             {
                 result.status = JsonResponseStatus.Error;
                 result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
             }
             return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult AvaliableNPP(decimal IDS)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repo.AvaliableNPP(IDS);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult Delete_Contract(decimal ids)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repo.Remove_Contract(ids);
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