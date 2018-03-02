using BarsWeb.Areas.Forex.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Forex.Models;
using BarsWeb.Core.Controllers;
using BarsWeb.Core.Models.Json;
using BarsWeb.Models;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Mvc;

namespace BarsWeb.Areas.Forex.Controllers
{
    [CheckAccessPage]
    [AuthorizeUser]
    public class RegularDealsController : ApplicationController
    {
        private readonly IRegularDealsRepository _repo;
        public RegularDealsController(IRegularDealsRepository repo)
        {
            _repo = repo;
        }

        public ViewResult RegularDeals(int? DealTypeId)
        {
            ViewBag.BankDate = _repo.GetBankDate().ToString("dd/MM/yyyy");
            if (DealTypeId != null)
            {
                ViewBag.DealTypeId = DealTypeId;
            }
            else
            {
                var EnterDealTag = _repo.GetDealTag();
                ViewBag.EnterDealTag = EnterDealTag;
                ViewBag.DealTypeId = Int32.Parse(_repo.GetDealType(EnterDealTag));
            }
            
            return View();
        }

        [HttpGet]
        public ActionResult GetCodePurposeOfPayment(string KOD)
        {
            try
            {
                IQueryable<BOPCODE> data = _repo.GetCodePurposeOfPayment(KOD);
                //var dataCount = _repo.GetCodePurposeOfPaymentDataCount(request);
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        [HttpGet]
        public ActionResult GetBanksSWIFTParticipants(string BICK)
        {
            try
            {
                IQueryable<SW_BANKS> data = _repo.GetBanksSWIFTParticipants(BICK);
                //var dataCount = _repo.GetBanksSWIFTParticipantsDataCount(request);
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        [HttpGet]
        public ActionResult GetFortexPart(string KVB, string KEY, string VALUE)
        {
            try
            {
                ForexPartner data = _repo.GetPartnersForexDeals(KVB, KEY, VALUE);                
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                
                return Json(ex.Message, JsonRequestBehavior.AllowGet); ;

            }
        }


        [HttpGet]
        public ActionResult GetCurrencyProp(decimal kv)
        {           
            var result = new BarsWeb.Models.JsonResponse(BarsWeb.Models.JsonResponseStatus.Ok);
            try
            {
                result.data = _repo.GetCurrencyProp(kv);
            }
            catch (Exception e)
            {
                result.status = BarsWeb.Models.JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ActionResult GetRevenueDropDown(decimal? kv)
        {
            if (kv != null)
            {
                try
                {
                    List<Revenue> data = _repo.GetRevenueDropDown(kv);
                    return Json(data, JsonRequestBehavior.AllowGet);
                }
                catch (Exception ex)
                {
                    return null;
                }
            }
            else
            {
                return null;
            }
        }

        [HttpGet]
        public ActionResult GetINICDropDown()
        {
            try
            {
                List<INIC> data = _repo.GetINICDropDown();
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        [HttpGet]
        public ActionResult GetForexType()
        {
            try
            {
                List<FOREX_OB22> forexTypeList = _repo.GetForexType().ToList();
                return Json(forexTypeList, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        [HttpGet]
        public ActionResult GetTransactionLengthType(string datCurr,string datA,string datB)
        {
            CalcTransactionLengthModel calcModel = new CalcTransactionLengthModel()
            {
                CurrentDate = DateTime.Parse(datCurr),
                DateA = DateTime.Parse(datA),
                DateB = DateTime.Parse(datB)
            };

            var result = new BarsWeb.Models.JsonResponse(BarsWeb.Models.JsonResponseStatus.Ok);
            try
            {
                result.data = _repo.GetTransactionLength(calcModel);
            }
            catch (Exception e)
            {
                result.status = BarsWeb.Models.JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        [HttpGet]
        public ActionResult GetRNKB(string MFOB, string BICB, string KOD_B)
        {

            try
            {
                decimal RNKB = _repo.GetRNKB(MFOB, BICB, KOD_B);
                return Json(RNKB, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return null;
            }

        }


        [HttpGet]
        public ActionResult GetNLSA(decimal? codeAgent)
        {
            try
            {
                string NLSA = _repo.GetNLSA(codeAgent);
                return Json( NLSA, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        [HttpGet]
        public ActionResult GetCrossCourse(decimal KVA, decimal KVB)
        {
            var result = new BarsWeb.Models.JsonResponse(BarsWeb.Models.JsonResponseStatus.Ok);
            try
            {
                var BankDate = _repo.GetBankDate();                
                result.data = _repo.GetCrossCourse(KVA, KVB, BankDate); 
            }
            catch (Exception e)
            {
                result.status = BarsWeb.Models.JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
           
        }

        [HttpGet]
        public ActionResult GetFinResult(decimal KVA, decimal NSA, decimal KVB, decimal NSB)
        {
            var result = new BarsWeb.Models.JsonResponse(BarsWeb.Models.JsonResponseStatus.Ok);
            try
            {
                //var BankDate = _repo.GetBankDate();
                result.data = _repo.GetFinResult(KVA, NSA, KVB, NSB);
            }
            catch (Exception e)
            {
                result.status = BarsWeb.Models.JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);

        }

        public ActionResult GetDefSettings()
        {
            var result = new BarsWeb.Models.JsonResponse(BarsWeb.Models.JsonResponseStatus.Ok);
            try
            {                
                result.data = _repo.GetDefSettings();
            }
            catch (Exception e)
            {
                result.status = BarsWeb.Models.JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        [HttpGet]
        public ActionResult getAccModelList(decimal ND, [DataSourceRequest] DataSourceRequest request)
        {
            try
            {
                List<AccountModels> data = _repo.getAccModelList( ND, request);
                var dataCount = _repo.getAccModelListDataCount( ND, request);
                return Json(new { Data = data, Total = dataCount }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        
        public ActionResult GetSwapTag(decimal DealTag)
        {

            var result = new BarsWeb.Models.JsonResponse(BarsWeb.Models.JsonResponseStatus.Ok);
            try
            {
                result.data = _repo.getSwapTag(DealTag);
            }
            catch (Exception e)
            {
                result.status = BarsWeb.Models.JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult InsertOperw(decimal pInic, decimal nND)
        {

            var result = new BarsWeb.Models.JsonResponse(BarsWeb.Models.JsonResponseStatus.Ok);
            try
            {
               _repo.InsertOperw(pInic, nND);
            }
            catch (Exception e)
            {
                result.status = BarsWeb.Models.JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }


        public ActionResult GetCheckPS(string MFOB, decimal KVA, decimal KVB)
        {
            try
            {
                decimal vpsa = _repo.GetCheckPS(MFOB, KVA);
                decimal vpsb = _repo.GetCheckPS(MFOB, KVB);

                return Json(new { VPSA = vpsa, VPSB = vpsb}, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(ex.Message, JsonRequestBehavior.AllowGet); ;
            }
        }

        public ActionResult GetSWRef(decimal DealTag)
        {
            try
            {
                decimal? SWREF = _repo.GetSWRef(DealTag);                

                return Json(SWREF, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(ex.Message, JsonRequestBehavior.AllowGet); ;
            }
        }

        public ActionResult GetCustLimits(decimal OKPOB)
        {
            var result = new BarsWeb.Models.JsonResponse(BarsWeb.Models.JsonResponseStatus.Ok);
            try
            {
                result.data = _repo.GetCustLimits(OKPOB).FirstOrDefault();
            }
            catch (Exception e)
            {
                result.status = BarsWeb.Models.JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult SWIFTCreateMsg(decimal DealTag)
        {
            var result = new BarsWeb.Models.JsonResponse(BarsWeb.Models.JsonResponseStatus.Ok);
            try
            {
                _repo.SWIFTCreateMsg(DealTag);
            }
            catch (Exception e)
            {
                result.status = BarsWeb.Models.JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult PutDepoDealTag(decimal DealTag)
        {
            var result = new BarsWeb.Models.JsonResponse(BarsWeb.Models.JsonResponseStatus.Ok);
            try
            {
                _repo.PutDepo(DealTag);
            }
            catch (Exception e)
            {
                result.status = BarsWeb.Models.JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }


        public ActionResult GetDealType(string DealTag)
        {
            var result = new BarsWeb.Models.JsonResponse(BarsWeb.Models.JsonResponseStatus.Ok);
            try
            {
                result.data = _repo.GetDealType(DealTag);
            }
            catch (Exception e)
            {
                result.status = BarsWeb.Models.JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetFXDealByDealTag(decimal DealTag)
        {
            var result = new BarsWeb.Models.JsonResponse(BarsWeb.Models.JsonResponseStatus.Ok);
            try
            {
                result.data = _repo.GetFXDeal(DealTag);
            }
            catch (Exception e)
            {
                result.status = BarsWeb.Models.JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }


    }
}

