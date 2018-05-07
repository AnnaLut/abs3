using BarsWeb.Areas.Clients.Infrastructure.Repository;
using BarsWeb.Areas.Clients.Models;
using BarsWeb.Areas.Clients.Models.Enums;
using BarsWeb.Core.Controllers;
using Kendo.Mvc.UI;
using System.Collections.Generic;
using System.Web.Mvc;

namespace BarsWeb.Areas.Clients.Controllers
{

    [Authorize]
    [SessionState(System.Web.SessionState.SessionStateBehavior.ReadOnly)]
    public class GeneralClearAddressController : ApplicationController
    {
        private readonly IGeneralClearAddressRepository _generalClearAdrRep;
        public GeneralClearAddressController(IGeneralClearAddressRepository generalClearAdrRep)
        {
            _generalClearAdrRep = generalClearAdrRep;
        }
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GetRegion([DataSourceRequest] DataSourceRequest request)
        {
            List<GeneralClearAddress> data = _generalClearAdrRep.GetRegion(request);
            decimal dataCount = _generalClearAdrRep.GetRegionCount(request);
            return Json(new { Data = data, Total = dataCount }, JsonRequestBehavior.AllowGet);
        }


        public ActionResult GetArea([DataSourceRequest] DataSourceRequest request)
        {
            List<GeneralClearAddress> data = _generalClearAdrRep.GetArea(request);
            decimal dataCount = _generalClearAdrRep.GetAreaCount(request);
            return Json(new { Data = data, Total = dataCount }, JsonRequestBehavior.AllowGet);
        }


        public ActionResult GetLocality([DataSourceRequest] DataSourceRequest request)
        {
            List<GeneralClearAddress> data = _generalClearAdrRep.GetLocality(request);
            decimal dataCount = _generalClearAdrRep.GetLocalityCount(request);
            return Json(new { Data = data, Total = dataCount }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetStreet([DataSourceRequest] DataSourceRequest request)
        {
            List<GeneralClearAddress> data = _generalClearAdrRep.GetStreet(request);
            decimal dataCount = _generalClearAdrRep.GetStreetCount(request);
            return Json(new { Data = data, Total = dataCount }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetInstallConformityGrid([DataSourceRequest] DataSourceRequest request, GeneralClearAddressType type, decimal? regionId, decimal? areaId, decimal? settlementId)
        {
            List<GeneralClearAddress> data = _generalClearAdrRep.GetInstallConformityGrid(request, type, regionId, areaId, settlementId);
            decimal dataCount = _generalClearAdrRep.GetInstallConformityGridCount(request, type, regionId, areaId, settlementId);
            return Json(new { Data = data, Total = dataCount }, JsonRequestBehavior.AllowGet);
        }

    }
}