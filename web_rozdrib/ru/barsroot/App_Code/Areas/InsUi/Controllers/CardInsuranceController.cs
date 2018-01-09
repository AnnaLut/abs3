using BarsWeb.Areas.InsUi.Infrastructure.DI.Abstract;
using BarsWeb.Areas.InsUi.Models.Transport;
using BarsWeb.Controllers;
using Kendo.Mvc.UI;
using Kendo.Mvc.Extensions;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;


namespace BarsWeb.Areas.InsUi.Controllers
{
    [AuthorizeUser]
    public class CardInsuranceController : ApplicationController
    {
        private readonly IInsRepository _insRepository;

        public CardInsuranceController(IInsRepository insRepository)
        {
            _insRepository = insRepository;
        }

        public ViewResult Index()
        {
            return View();
        }

        public ActionResult GetCardsInsur([DataSourceRequest]DataSourceRequest request, SearchModel par)
        {
            //IEnumerable<CardInsurance> CardsInsur = String.IsNullOrEmpty(dateFrom) || dateFrom == "null" ? _insRepository.GetCardsInsur() : _insRepository.GetCardsInsur().Where(i => Convert.ToDateTime(i.DATE_FROM) == Convert.ToDateTime(dateFrom));
            IEnumerable<CardInsurance> CardsInsur = _insRepository.GetCardsInsur(par);
            return Json(CardsInsur.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }
      

    }

   
}