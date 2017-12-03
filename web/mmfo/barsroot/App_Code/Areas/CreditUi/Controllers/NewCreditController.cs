using System;
using System.Web.Mvc;
using System.Linq;
using BarsWeb.Controllers;
using BarsWeb.Areas.CreditUi.Infrastructure.DI.Abstract;
using BarsWeb.Areas.CreditUi.Models;
using Kendo.Mvc.UI;
using Kendo.Mvc.Extensions;
using System.Collections.Generic;

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

        public ActionResult getCurrency()
        {
            IQueryable<CurrencyList> session = _creditRepository.getCurrency();
            return Json(session, JsonRequestBehavior.AllowGet);
        }

        public ActionResult getStanFin()
        {
            IQueryable<StanFinList> session = _creditRepository.getStanFin();
            return Json(session, JsonRequestBehavior.AllowGet);
        }

        public ActionResult getStanObs()
        {
            IQueryable<StanObsList> session = _creditRepository.getStanObs();
            return Json(session, JsonRequestBehavior.AllowGet);
        }

        public ActionResult getCRisk(decimal fin, decimal obs)
        {
            IQueryable<CRiskList> session = _creditRepository.getCRisk(fin,obs);
            return Json(session, JsonRequestBehavior.AllowGet);
        }

        public ActionResult getVidd(decimal rnk)
        {
            IQueryable<ViddList> session = _creditRepository.getVidd(rnk);
            return Json(session, JsonRequestBehavior.AllowGet);
        }

        public ActionResult getSour()
        {
            IQueryable<SourList> session = _creditRepository.getSour();
            return Json(session, JsonRequestBehavior.AllowGet);
        }

        public ActionResult getAim(byte vidd, string dealDate)
        {
            IQueryable<AimList> session = _creditRepository.getAim(vidd, dealDate);
            return Json(session, JsonRequestBehavior.AllowGet);
        }
        [HttpGet]
        public ActionResult getAimBal(byte vidd, decimal? aim, bool yearDiff)
        {
            NlsParam session = _creditRepository.getAimBal(vidd, aim, yearDiff);
            return Json(session, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public void setMasIni(string nbs)
        {
            _creditRepository.setMasIni(nbs);
        }

        public ActionResult getBasey()
        {
            IQueryable<BaseyList> session = _creditRepository.getBasey();
            return Json(session, JsonRequestBehavior.AllowGet);
        }

        public ActionResult getRang(byte vidd)
        {
            IQueryable<RangList> session = _creditRepository.getRang(vidd);
            return Json(session, JsonRequestBehavior.AllowGet);
        }

        public ActionResult getFreq()
        {
            IQueryable<FreqList> session = _creditRepository.getFreq();
            return Json(session, JsonRequestBehavior.AllowGet);
        }

        public ActionResult getMetr()
        {
            IQueryable<MetrList> session = _creditRepository.getMetr();
            return Json(session, JsonRequestBehavior.AllowGet);
        }

        public ActionResult getTabList()
        {
            IQueryable<ParamsList> session = _creditRepository.getTabList();
            return Json(session, JsonRequestBehavior.AllowGet);
        }

        public ActionResult getDaynpList()
        {
            Dictionary<int, string> getDaynpList = _creditRepository.getDaynpList();
            return Json(getDaynpList.ToList(), JsonRequestBehavior.AllowGet);

        }

        public ActionResult getNdTxt([DataSourceRequest]DataSourceRequest request, string code)
        {
            IQueryable<NdTxtList> session = _creditRepository.getNdTxt(code);
            return Json(session.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        public ActionResult getNdTxtDeal([DataSourceRequest]DataSourceRequest request, decimal nd, string code)
        {
            IQueryable<NdTxtList> session = _creditRepository.getNdTxtDeal(nd, code);
            return Json(session.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
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
            CreateDeal session = _creditRepository.getDeal(nd);
            return Json(session, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetProlog(decimal nd)
        {
            PrologParam session = _creditRepository.GetProlog(nd);
            return Json(session, JsonRequestBehavior.AllowGet);
        }

        public ActionResult getMultiExtInt(decimal nd)
        {
            IQueryable<MultiExtInt> session = _creditRepository.getMultiExtInt(nd);
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
    }
}