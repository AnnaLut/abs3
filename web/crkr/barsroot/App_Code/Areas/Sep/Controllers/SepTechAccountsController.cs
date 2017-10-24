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
       
        public ActionResult Index(SepTechAccountsFilterParams sp, bool? isBack, string btn_SortWithoutKR)
        {
            string method = HttpContext.Request.HttpMethod;
            if (method == "GET")
                sp.ShowFinAtrib = "on";

            sp.dat11 = _repo.GetBankDate().Value.AddDays(-30);
            sp.dat22 = _repo.GetBankDate().Value; 

            sp.PartialVariantString = "SepTechAccountsGrid_v";
            sp.GridVariantString = "GetSEPTECHACCOUNT_V1";
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

        public ActionResult GetSEPTECHACCOUNT_V1([DataSourceRequest]DataSourceRequest request, SepTechAccountsFilterParams fp)
        {
            // Обороты за период дат
            if (fp.DateCashFlowPeriod1.HasValue && fp.DateCashFlowPeriod2.HasValue)
            {
                var cashPeriod = _repo.GetCashFlowPeriod(fp, request);
                var count = _repo.GetCashFlowPeriodCount(fp, request);
                return Json(new { Data = cashPeriod, Total = count }, JsonRequestBehavior.AllowGet); 
            }
            // Показывать связанные счета
            if (fp.LinkedAccFlag && fp.NACC.HasValue)
            {
                var linkedAcc = _repo.GetLinkedAcc(fp, request).ToList();
                return Json(new { Data = linkedAcc }, JsonRequestBehavior.AllowGet);
            }
            // substr(nls,1,4)||substr(nls,6,length(nls)-5) des
            var septechaccountv1 = _repo.GetSEPTECHACCOUNTV1(fp, request);           
            return Json(septechaccountv1.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }     
    
        /// <summary>
        /// Данные для таблицы "Технологические счета"
        /// </summary>
        /// <param name="request"></param>
        /// <param name="SortWithoutKR"></param>
        /// <returns></returns>
        public JsonResult GetSEPTECHACCOUNT_V2([DataSourceRequest]DataSourceRequest request, SepTechAccountsFilterParams fp)
        {
            // Обороты за период дат
            if (fp.DateCashFlowPeriod1.HasValue && fp.DateCashFlowPeriod2.HasValue)
            {
                var cashPeriod = _repo.GetCashFlowPeriod(fp, request);
                var count = _repo.GetCashFlowPeriodCount(fp, request);
                return Json(new { Data = cashPeriod, Total = count }, JsonRequestBehavior.AllowGet);
            }
            // Показывать связанные счета
            if (fp.LinkedAccFlag && fp.NACC.HasValue)
            {
                var linkedAcc = _repo.GetLinkedAcc(fp, request).ToList();
                return Json(new { Data = linkedAcc }, JsonRequestBehavior.AllowGet);
            }
            var septechaccountv2 = _repo.GetSEPTECHACCOUNTV2(fp, request);            
            return Json(septechaccountv2.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetSEPTECHACCOUNT_VQF([DataSourceRequest]DataSourceRequest request, SepTechAccountsFilterParams fp)
        { 
              var septechaccountvqf = _repo.GetSEPTECHACCOUNTVQF(fp, request); 
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
      
    }
}