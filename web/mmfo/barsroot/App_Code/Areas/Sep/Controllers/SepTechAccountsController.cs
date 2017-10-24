using System;
using System.Linq;
using System.Web.Mvc;
using BarsWeb.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sep.Models;
using BarsWeb.Controllers;
using Kendo.Mvc.UI;
using Kendo.Mvc.Extensions;
using System.Collections.Generic;
using Newtonsoft.Json;
using Ninject;
using BarsWeb.Core.Logger;

namespace BarsWeb.Areas.Sep.Controllers
{
    //  [CheckAccessPage]
    [AuthorizeUser]
    public class SepTechAccountsController : ApplicationController
    {
        private readonly ISepTechAccountsRepository _repo;
        private readonly IErrorsRepository _errors;

        public SepTechAccountsController(ISepTechAccountsRepository repository, IErrorsRepository errorsRepo)
        {
            _repo = repository;
            _errors = errorsRepo;
        }
        [Inject]
        public IDbLogger Logger { get; set; }
        string LoggerPrefix = "SepTechAccountsController";
        public ActionResult Index(SepTechAccountsFilterParams sp, bool? isBack, string btn_SortWithoutKR)
        {
            Logger.Info("begin index", LoggerPrefix);
            string method = HttpContext.Request.HttpMethod;
            if (method == "GET")
                sp.ShowFinAtrib = "on";

            sp.dat11 = _repo.GetBankDate().Value.AddDays(-30);
            sp.dat22 = _repo.GetBankDate().Value;

            sp.PartialVariantString = "SepTechAccountsGrid_v";


            //Не знаходило ідентифікатор складного фільтру тому змінив на GetSEPTECHACCOUNT_V2
            sp.GridVariantString = "GetSEPTECHACCOUNT_V2";
            //sp.GridVariantString = "GetSEPTECHACCOUNT_V1";
            // Если банковский день не ровняется текущему системному дню, тогда
            // установить лог. переключатель SepTechAccountFlag_v2 в true
            // И вызваьб второй вариант GetSEPTECHACCOUNT_V2_Partial с Уровня Index View
            if (_repo.GetBankDate().Value.Date != DateTime.Now.Date)
            {
                sp.GridVariantString = "GetSEPTECHACCOUNT_V2";
            }
            sp.bankdate = _repo.GetBankDate().Value.ToString("dd.MM.yyyy");
            // установлено отображение "Показывать эквиваленты"
            if (!string.IsNullOrEmpty(sp.ShowEquivalents))
            {
                sp.PartialVariantString = "SepTechAccountsGrid_vQF";
                sp.GridVariantString = "GetSEPTECHACCOUNT_VQF";
            }
            return View(sp);
        }

        public ActionResult GetSEPTECHACCOUNT_V1([DataSourceRequest]DataSourceRequest request, SepTechAccountsFilterParams fp, string parameters)
        {
            Logger.Info("begin request GetSEPTECHACCOUNT_V1", LoggerPrefix);
            // Обороты за период дат
            //if (fp.DateCashFlowPeriod1.HasValue && fp.DateCashFlowPeriod2.HasValue)
            //{
            //    var cashPeriod = _repo.GetCashFlowPeriod(fp, request);
            //    var count = _repo.GetCashFlowPeriodCount(fp, request);
            //    return Json(new { Data = cashPeriod, Total = count }, JsonRequestBehavior.AllowGet); 
            //}
            //// Показывать связанные счета
            //if (fp.LinkedAccFlag && fp.NACC.HasValue)
            //{
            //    var linkedAcc = _repo.GetLinkedAcc(fp, request).ToList();
            //    return Json(new { Data = linkedAcc }, JsonRequestBehavior.AllowGet);
            //}
            // substr(nls,1,4)||substr(nls,6,length(nls)-5) des
            var septechaccountv1 = _repo.GetSEPTECHACCOUNTV1(fp, request, parameters);
            return Json(septechaccountv1.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Данные для таблицы "Технологические счета"
        /// </summary>
        /// <param name="request"></param>
        /// <param name="SortWithoutKR"></param>
        /// <returns></returns>
        public JsonResult GetSEPTECHACCOUNT_V2([DataSourceRequest]DataSourceRequest request, SepTechAccountsFilterParams fp, string parameters)
        {
            try
            {

                Logger.Info(string.Format("bebin request GetSEPTECHACCOUNT_V2 paramreters= {0}", parameters), LoggerPrefix);
                //// Обороты за период дат
                //if (fp.DateCashFlowPeriod1.HasValue && fp.DateCashFlowPeriod2.HasValue)
                //{
                //    var cashPeriod = _repo.GetCashFlowPeriod(fp, request);
                //    var count = _repo.GetCashFlowPeriodCount(fp, request);
                //    return Json(new { Data = cashPeriod, Total = count }, JsonRequestBehavior.AllowGet);
                //}
                //// Показывать связанные счета
                //if (fp.LinkedAccFlag && fp.NACC.HasValue)
                //{
                //    var linkedAcc = _repo.GetLinkedAcc(fp, request).ToList();
                //    return Json(new { Data = linkedAcc }, JsonRequestBehavior.AllowGet);
                //}

                Logger.Info(string.Format("bebin _repo.GetSEPTECHACCOUNTV2  paramreters= {0}", parameters), LoggerPrefix);
                var septechaccountv2 = _repo.GetSEPTECHACCOUNTV2(fp, request, parameters);
                Logger.Info(string.Format("returne json  request.PageSize = {0} cuont: {1}", request.Page, septechaccountv2.Count()), LoggerPrefix);
                return Json(septechaccountv2.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);

            }
            catch (Exception e)
            {
                Logger.Error(string.Format("error msg = {0} ", e.Message), LoggerPrefix);
                return Json(new { status = "error", msg = "Помилка вичитуванні даних " + "<br />" + e.Message });
            }
        }

        public JsonResult GetSEPTECHACCOUNT_VQF([DataSourceRequest]DataSourceRequest request, SepTechAccountsFilterParams fp, string parameters)
        {
            var septechaccountvqf = _repo.GetSEPTECHACCOUNTVQF(fp, request, parameters);
            return Json(septechaccountvqf.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetHistoryParamSelectData([DataSourceRequest]DataSourceRequest request, SepTechAccountsFilterParams fp)
        {
            var selectData = _repo.GetHistoryParamSelect(fp, request);
            return Json(new { Data = selectData }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetHistoryParamSelectFromSelect1([DataSourceRequest]DataSourceRequest request, SepTechAccountsFilterParams fp)
        {
            var selectData = _repo.GetHistoryParamSelectFromSelect1(fp, request);
            return Json(new { Data = selectData }, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// История счета
        /// </summary>
        /// <param name="request"></param>
        /// <param name="fp">Параметры фильтрации</param>
        /// <returns></returns>
        public ActionResult GetGridHistoryAccList([DataSourceRequest]DataSourceRequest request,
            SepTechAccountsFilterParams fp)
        {
            if (!fp.dat11.HasValue && !fp.dat11.HasValue)
            {
                fp.dat11 = _repo.GetBankDate().Value.AddDays(-30);
                fp.dat22 = _repo.GetBankDate().Value;
            }
            var historyAccList = _repo.GetGridHistoryAccList(fp, request);
            return Json(new { Data = historyAccList }, JsonRequestBehavior.AllowGet);
        }
        /// <summary>
        /// История изменения параметров счета
        /// </summary>
        /// <param name="request"></param>
        /// <param name="fp">Параметры фильтрации</param>
        /// <returns></returns>
        public ActionResult GetGridHistoryAccChangeParamList([DataSourceRequest]DataSourceRequest request,
            SepTechAccountsFilterParams fp)
        {
            if (!fp.NACC.HasValue)
                return null;

            var historyParamsList = _repo.GetGridHistoryAccChangeParamList(fp, request);

            return Json(new { Data = historyParamsList }, JsonRequestBehavior.AllowGet);
        }
        /// <summary>
        /// Итоги по валютам
        /// </summary>
        /// <param name="request"></param>
        /// <param name="fp"></param>
        /// <returns></returns>
        public ActionResult GetGridCurrencySummaryList([DataSourceRequest]DataSourceRequest request,
           SepTechAccountsFilterParams fp)
        {
            var currencySummary = _repo.GetCurrencySummaryList(fp, request);
            // var l1 = currencySummary.ToList();
            return Json(new { Data = currencySummary }, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetBankDate()
        {
            var result = _repo.GetBankDate();
            return Json(result.Value, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetSepReplyTechDocs(SepTechAccountsFilterParams fp)
        {
            return View("IndexSepReplyTechAcc", fp);
        }

        public ActionResult GetSepBankInternInitDocs(SepTechAccountsFilterParams fp)
        {
            fp.bankdate = _repo.GetBankDate().Value.ToString("dd/MM/yyyy");
            return View("IndexSepBankInternInit", fp);
        }

        public ActionResult GetSepReplyTechDocsData([DataSourceRequest]DataSourceRequest request,
            SepTechAccountsFilterParams fp)
        {
            fp.bankdate = _repo.GetBankDate().Value.ToString("MM/dd/yyyy");
            var techDocs = _repo.GetSepReplyTechDocsData(fp, request);
            return Json(new { Data = techDocs }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetSepInternInitDocsData([DataSourceRequest]DataSourceRequest request,
            SepTechAccountsFilterParams fp)
        {
            fp.bankdate = _repo.GetBankDate().Value.ToString("MM/dd/yyyy");
            var techDocs = _repo.GetSepInternInitDocsData(fp, request);
            decimal count = _repo.GetSepInternInitDocsCount(fp, request);
            return Json(new { Data = techDocs, Total = count }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult TechDocumentsToExcelFile(string contentType, string base64, string fileName)
        {
            var fileContents = Convert.FromBase64String(base64);
            return File(fileContents, contentType, fileName);
        }

        public ActionResult PercentCalculation(PercentParams item)
        {
            // use _repo to return model ProcCard
            var data = _repo.GetCard(item.acc);
            ViewBag.ACC = data;
            ProcCard card = new ProcCard();
            if (data != null)
            {
                card.ACC_SS = data.ACC_SS;
            }
            return View(card);
        }

    }
}