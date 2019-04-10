using System;
using System.Web.Mvc;
using System.Linq;
using BarsWeb.Controllers;
using BarsWeb.Areas.CreditUi.Infrastructure.DI.Abstract;
using BarsWeb.Areas.CreditUi.Models;
using Kendo.Mvc.UI;
using Kendo.Mvc.Extensions;
using System.Collections.Generic;
using BarsWeb.Areas.CreditUi.Infrastructure.DI.Implementation;

namespace BarsWeb.Areas.CreditUi.Controllers
{
    [AuthorizeUser]
    public class NewCreditController : ApplicationController
    {
        private readonly INewCreditRepository _creditRepository;

        public NewCreditController(INewCreditRepository creditRepository)
        {
            _creditRepository = creditRepository;
        }

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult CreditParams()
        {
            return View();
        }

        public ActionResult DataMaturity()
        {
            return View();
        }

        public ActionResult CommitionLimit()
        {
            return View();
        }

        public ActionResult MoreCreditParams()
        {
            return View();
        }
        public ActionResult Authorization()
        {
            return View();
        }

        public ActionResult getVidd(decimal rnk)
        {
            return Json(_creditRepository.getVidd(rnk).ToList(), JsonRequestBehavior.AllowGet);
        }

        public ActionResult getAim(byte vidd, string dealDate)
        {
            return Json(_creditRepository.getAim(vidd, dealDate).ToList(), JsonRequestBehavior.AllowGet);
        }

        public ActionResult getRang(byte vidd)
        {
            return Json(_creditRepository.getRang(vidd).ToList(), JsonRequestBehavior.AllowGet);
        }

        public ActionResult getBusMod(decimal rnk)
        {
            return Json(_creditRepository.getBusMod(rnk).ToDictionary(p => p.Key, p => p.Key + ") " + p.Value).ToList(), JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult createDeal(CreateDeal credit)
        {
            string Status = "OK";
            decimal Nd = -1;
            try
            {
                Nd = _creditRepository.createDeal(credit);
            }
            catch (Exception e) { Status = e.Message + " StackTrace=" + e.StackTrace; }
            return Json(new { Status = Status, Nd = Nd });
        }

        [HttpPost]
        public ActionResult updateDeal(CreateDeal credit)
        {
            string Status = "OK";
            decimal Nd = -1;
            try
            {
                Nd = _creditRepository.updateDeal(credit);
            }
            catch (Exception e) { Status = e.Message + " StackTrace=" + e.StackTrace; }
            return Json(new { Status = Status, Nd = Nd });
        }

        [HttpPost]
        public ActionResult setNdTxt(decimal nd, List<NdTxt> txt)
        {
            string Status = "OK", Error_data = "";
            try
            {
                Error_data = _creditRepository.setNdTxt(nd, txt);
            }
            catch (Exception e) { Status = e.Message + " StackTrace=" + e.StackTrace; }
            return Json(new { Status = Status, Error_data = Error_data });
        }

        [HttpPost]
        public ActionResult afterSaveDeal(AfterParams param)
        {
            string Status = "OK";
            try
            {
                _creditRepository.afterSaveDeal(param);
            }
            catch (Exception e) { Status = e.Message + " StackTrace=" + e.StackTrace; }
            return Json(new { Status = Status });
        }

        [HttpPost]
        public ActionResult setMultiExtInt(MultiExtIntParams param)
        {
            string Status = "OK";
            try
            {
                _creditRepository.setMultiExtInt(param);
            }
            catch (Exception e) { Status = e.Message + " StackTrace=" + e.StackTrace; }
            return Json(new { Status = Status });
        }

        public ActionResult getDeal(decimal nd)
        {
            string Status = "OK";
            try
            {
                CreditFormData session = _creditRepository.getDeal(nd);
                return Json(new { Status = session.Deal.CUST_DATA.Error_Message ?? Status, Data = session.Deal, MultiExt = session.MultiInts, Gkd = session.DealGkd }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { Status = e.Message + " StackTrace=" + e.StackTrace; }
            return Json(new { Status = Status }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetProlog(decimal nd)
        {
            PrologParam session = _creditRepository.GetProlog(nd);
            return Json(session, JsonRequestBehavior.AllowGet);
        }


        [HttpPost]
        public ActionResult SetProlog(decimal nd, DateTime bnkDate, decimal kprolog, decimal sos, DateTime dateStart, DateTime dateEnd)
        {
            string session = _creditRepository.SetProlog(nd, bnkDate, kprolog, sos, dateStart, dateEnd);
            return Json(session);
        }

        public ActionResult GetAuthData(decimal nd)
        {
            AuthStaticData session = _creditRepository.GetAuthStaticData(nd);
            return Json(session, JsonRequestBehavior.AllowGet);
        }

        public ActionResult Authorize(decimal nd, int type, string pidstava, string initiative)
        {
            string session = _creditRepository.Authorize(nd,type,pidstava,initiative);
            return Json(session, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetDataSources()
        {
            return Json( _creditRepository.GetDataSources(), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetMoreCreditsParams(decimal? nd)
        {
            return Json(_creditRepository.GetMoreCreditsParams(nd), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetIFRS(int bus_mod, string sppi) 
        {
            return Json(new { IFRS = _creditRepository.GetIFRS(bus_mod, sppi) }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetSPPI(decimal rnk)
        {
            return Json(new { SPPI = _creditRepository.GetSPPI(rnk) }, JsonRequestBehavior.AllowGet);
        }

		public ActionResult GetCustData(decimal rnk)
        {
            string Status = "OK";
            try
            {
                CustomerInfo cust_data = _creditRepository.GetCustomerInfo(rnk);
                return Json(new { Status = cust_data.Error_Message ?? Status, Data = cust_data }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { Status = e.Message + " StackTrace=" + e.StackTrace; }
            return Json(new { Status = Status }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetActualLimit(long? sub_nd, long? gkd_nd)
        {
            return Json(new { Limit = _creditRepository.GetActualLimit(sub_nd, gkd_nd) }, JsonRequestBehavior.AllowGet);
        }
    }
}