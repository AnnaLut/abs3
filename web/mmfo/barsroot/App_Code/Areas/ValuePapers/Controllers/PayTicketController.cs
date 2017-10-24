using System.Web.Mvc;
using BarsWeb.Areas.ValuePapers.Infrastructure.DI.Abstract;
using BarsWeb.Controllers;

namespace BarsWeb.Areas.ValuePapers.Controllers
{
    public class PayTicketController : ApplicationController
    {
        private readonly IPayTicketRepository _repository;

        public PayTicketController(IPayTicketRepository repository)
        {
            _repository = repository;
        }

        public ActionResult Index(string strPar01, string strPar02, decimal? nGrp, decimal? nMode, decimal? nID, string CP_ID)
        {
            ViewBag.strPar01 = strPar01;
            ViewBag.strPar02 = strPar02;
            ViewBag.nGrp = nGrp;
            ViewBag.nMode = nMode;
            ViewBag.nID = nID;
            ViewBag.CP_ID = CP_ID;
            return View();
        }

        public ActionResult PayTicketOrNominal(string strPar02, decimal? nGrp, decimal? nID, string CP_ID)//string strPar01,  decimal? nMode, 
        {
            ViewBag.strPar02 = strPar02;
            ViewBag.nGrp = nGrp;
            ViewBag.nID = nID;
            ViewBag.CP_ID = CP_ID;
            return View();
        }
    }
}
