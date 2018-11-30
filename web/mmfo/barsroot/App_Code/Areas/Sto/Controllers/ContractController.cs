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

        /// <summary>
        /// Список групп рег. платежей
        /// </summary>
        public ActionResult GetGroupList([DataSourceRequest] DataSourceRequest request)
        {
            var result = _repo.GetGroupsList().ToDataSourceResult(request);
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Список договоров на рег. платежи по выбранной группе
        /// </summary>
        /// <param name="request"></param>
        /// <param name="group_id">ИД группы РП</param>
        public ActionResult GetContractList([DataSourceRequest] DataSourceRequest request, int group_id)
        {
            var response = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
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

        /// <summary>
        /// Список макетов рег. платежей по выбранному договору
        /// </summary>
        /// <param name="request"></param>
        /// <param name="ids">ИД договора на РП</param>
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

        /// <summary>
        /// Список предустановленных допреквизитов макета платежа
        /// </summary>
        /// <param name="request"></param>
        /// <param name="paymentIdd">ИД макета РП</param>
        public ActionResult GetDopRekvForPayment([DataSourceRequest] DataSourceRequest request, decimal paymentIdd)
        {
            JsonResponse result = new JsonResponse(JsonResponseStatus.Ok);
                var dopRekvforPaymentList = _repo.GetDopRekvforPaymentList(paymentIdd);
                var data = dopRekvforPaymentList.ToDataSourceResult(request);
                return Json(data, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Список (справочник) кодов госзакупок
        /// </summary>
        public ActionResult GetGovCodesValues([DataSourceRequest] DataSourceRequest request)
        {
            JsonResponse result = new JsonResponse(JsonResponseStatus.Ok);

            var dopRekvforPaymentList = _repo.GetGovCodesValue();
            DataSourceResult data = dopRekvforPaymentList.ToDataSourceResult(request);

            return Json(data, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Подтверждение / отмена макета рег. платежа
        /// </summary>
        /// <param name="idd">ИД макета РП</param>
        /// <param name="statusId">ИД Статуса (ОК / отмена)</param>
        /// <param name="disclaimId">ИД причины отмены</param>
        /// <returns></returns>
        public ActionResult GetClaim(string idd, string statusId, string disclaimId)
        {
            JsonResponse result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                int claimReult = _repo.ClaimProc(idd, statusId, disclaimId);
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

        /// <summary>
        /// Список причин отмены макета рег. платежа
        /// </summary>
        public ActionResult GetDisclaimerList([DataSourceRequest] DataSourceRequest request)
        {
            var list = _repo.DisclaimerData();
            DataSourceResult result = list.Where(x => x.ID != 0).Select(c => new
            {
                c.ID,
                c.NAME
            }).OrderBy(e => e.ID).ToDataSourceResult(request);

            return Json(result, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Получение истории изменений макета рег. платежа
        /// </summary>
        /// <param name="request"></param>
        /// <param name="idd">ИД макета РП</param>
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

        /// <summary>
        /// Получение списка вариантов частоты выполнения рег. платежа
        /// </summary>
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

        /// <summary>
        /// Получение списка допустимых операций (tts) для рег. платежа
        /// </summary>
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

        /// <summary>
        /// Получение счетов клиента
        /// </summary>
        /// <param name="RNK">РНК</param>
        /// <param name="KV">Валюта - цифровой код</param>
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

        /// <summary>
        /// Получение списка валют, доступных клиенту
        /// </summary>
        /// <param name="RNK">РНК</param>
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

        /// <summary>
        /// Поиск клиентов по ИНН / РНК
        /// </summary>
        /// <param name="OKPO">ИНН</param>
        /// <param name="RNK">РНК</param>
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

        /// <summary>
        /// Получение наименования / ФИО клиента по РНК
        /// </summary>
        /// <param name="RNK">РНК</param>
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

        /// <summary>
        /// Создание нового макета платежа
        /// </summary>
        /// <param name="newpayment">Данные макета платежа</param>
        /// <returns>ИД созданного макета</returns>
         public ActionResult AddPayment(payment newpayment)
        {
            JsonResponse result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repo.BeginTransaction();
                decimal idd = _repo.AddPayment(newpayment);
                result.data = idd;
                _repo.SetStoOperw(idd, "KODDZ", newpayment.govBuyCode);
                _repo.Commit();
            }
            catch (Exception e)
            {
                _repo.Rollback();
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Создание нового договора на рег. платежи
        /// </summary>
        /// <param name="newids">Данные договора</param>
        /// <returns>ИД созданного договора</returns>
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

        /// <summary>
        /// Получение следующего порядкового номера макета рег. платежа для договора
        /// </summary>
        /// <param name="IDS">ИД договора РП</param>
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

        /// <summary>
        /// Удаление / закрытие договора на рег. платежи
        /// </summary>
        /// <param name="ids">ИД договора РП</param>
        /// <returns>Результирующее сообщение</returns>
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