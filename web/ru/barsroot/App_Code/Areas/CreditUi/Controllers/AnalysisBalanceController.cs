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
    public class AnalysisBalanceController : ApplicationController
    {
        private readonly IAnalysisBalanceRepository _balanceRepository;

        public AnalysisBalanceController(IAnalysisBalanceRepository balanceRepository)
        {
            _balanceRepository = balanceRepository;
        }

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GetInfo(decimal nd)
        {
            CreditInfo session = _balanceRepository.GetInfo(nd);
            return Json(session, JsonRequestBehavior.AllowGet);
        }

        public ActionResult getAccKredit([DataSourceRequest]DataSourceRequest request, decimal nd)
        {
            IQueryable<AccKredit> session = _balanceRepository.getAccKredit(nd);
            return Json(session.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        public ActionResult getAccDebit([DataSourceRequest]DataSourceRequest request, decimal nd, string ccId)
        {
            IQueryable<AccKredit> session = _balanceRepository.getAccDebit(nd, ccId);
            return Json(session.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        public ActionResult createIsg(List<CreateIsg> isg)
        {
            List<CreateResponse> session = _balanceRepository.createIsg(isg);
            return Json(session, JsonRequestBehavior.AllowGet);
        }
    }
}