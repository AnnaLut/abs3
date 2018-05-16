using System.Web.Mvc;
using System.Linq;
using BarsWeb.Controllers;
using BarsWeb.Areas.CreditUi.Infrastructure.DI.Abstract;
using BarsWeb.Areas.CreditUi.Models;
using Kendo.Mvc.UI;
using Kendo.Mvc.Extensions;
using System.Collections.Generic;
using System;
using System.Web.Script.Serialization;

/// <summary>
/// Summary description for glkController
/// </summary>
namespace BarsWeb.Areas.CreditUi.Controllers
{
    [AuthorizeUser]
    public class PortfolioController : ApplicationController
    {
        private readonly IPortfolioRepository _PortfolioRepository;

        public PortfolioController(IPortfolioRepository PortfolioRepository)
        {
            _PortfolioRepository = PortfolioRepository;
        }

        public ActionResult Index()
        {
            return View("~/Areas/CreditUi/Views/Portfolio/Index.cshtml");
        }

        public ActionResult GetPortfolio(byte custtype, [DataSourceRequest]DataSourceRequest request)
        {
            IQueryable<Portfolio> session = _PortfolioRepository.GetPortfolio(custtype);
            return Json(session.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetBankDate()
        {
            return Json(_PortfolioRepository.GetBankDate());
        }

    }
}