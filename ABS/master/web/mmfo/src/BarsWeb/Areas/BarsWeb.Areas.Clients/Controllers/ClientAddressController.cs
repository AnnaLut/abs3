using System.Web.Mvc;
using BarsWeb.Core.Controllers;
using Kendo.Mvc.UI;
using System.Linq;
using BarsWeb.Areas.Clients.Models;
using BarsWeb.Areas.Clients.Infrastructure.Repository;
using System;
using System.Collections.Generic;
using System.Web;

namespace BarsWeb.Areas.Clients.Controllers
{
    // [CheckAccessPage]
    [Authorize]
    public class ClientAddressController : ApplicationController
    {
        private readonly IClientAddressRepository _repo;

        public ClientAddressController(IClientAddressRepository repo)
        {
            _repo = repo;
        }

        public ViewResult ClientAddress()
        {
            return View();
        }

        [HttpGet]
        public ActionResult GetRegions(string columnName, [DataSourceRequest] DataSourceRequest request)
        {

            List<V_ADR_REGIONS> data = _repo.GetRegions(columnName, request);
            return Json(data, JsonRequestBehavior.AllowGet);

        }

        [HttpGet]
        public ActionResult GetAreas(string columnName, decimal? regionId, [DataSourceRequest] DataSourceRequest request)
        {

            List<V_ADR_AREAS> data = _repo.GetAreas(columnName, regionId, request);
            return Json(data, JsonRequestBehavior.AllowGet);

        }

        [HttpGet]
        public ActionResult GetDropDownSettlement()
        {

            List<V_ADR_SETTLEMENT_TYPES> data = _repo.GetDropDownSettlement();
            return Json(data, JsonRequestBehavior.AllowGet);

        }

        [HttpGet]
        public ActionResult GetDropDownStreet()
        {

            List<V_ADR_STREET_TYPES> data = _repo.GetDropDownStreet();
            return Json(data, JsonRequestBehavior.AllowGet);


        }
        [HttpGet]
        public ActionResult GetDropDownHouse()
        {

            List<HouseType> data = _repo.GetDropDownHouse();
            return Json(data, JsonRequestBehavior.AllowGet);


        }

        [HttpGet]
        public ActionResult GetDropDownSection()
        {

            List<SectionType> data = _repo.GetDropDownSection();
            return Json(data, JsonRequestBehavior.AllowGet);


        }

        [HttpGet]
        public ActionResult GetDropDownRoom()
        {

            List<RoomType> data = _repo.GetDropDownRoom();
            return Json(data, JsonRequestBehavior.AllowGet);

        }

        [HttpGet]
        public ActionResult GetSettlement(string columnName, decimal? regionId, decimal? areaId, [DataSourceRequest] DataSourceRequest request)
        {

            List<V_ADR_SETTLEMENTS> data = _repo.GetSettlement(columnName, regionId, areaId, request);
            return Json(data, JsonRequestBehavior.AllowGet);

        }

        [HttpGet]
        public ActionResult GetStreet(string columnName, decimal? settlementId, [DataSourceRequest] DataSourceRequest request)
        {
            List<V_ADR_STREETS> data = _repo.GetStreet(columnName, settlementId, request);
            return Json(data, JsonRequestBehavior.AllowGet);

        }

        [HttpGet]
        public ActionResult GetHouse(string columnName, decimal? streetId, [DataSourceRequest] DataSourceRequest request)
        {
            List<V_ADR_HOUSES> data = _repo.GetHouse(columnName, streetId, request);
            return Json(data, JsonRequestBehavior.AllowGet);

        }
        
        public ViewResult ClearAddress()
        {
            return View();
        }

    }
}
