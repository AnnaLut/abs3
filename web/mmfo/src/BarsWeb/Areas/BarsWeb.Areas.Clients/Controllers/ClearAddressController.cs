using System.Linq;
using System.Web.Mvc;
using BarsWeb.Areas.Clients.Infrastructure.Repository;
using BarsWeb.Areas.Clients.Models;
using BarsWeb.Core.Controllers;
using Kendo.Mvc.UI;
using System.Web;

namespace BarsWeb.Areas.Clients.Controllers
{
    public class ClearAddressController : ApplicationController
    {

        private readonly IClearAddressRepository _repository;
        public ClearAddressController(IClearAddressRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public ActionResult GetClearAddress([DataSourceRequest] DataSourceRequest request,
                                                string domain,
                                                string region,
                                                string street,
                                                string locality,
                                                decimal? regionId,
                                                decimal? areaId,
                                                decimal? settlementId,
                                                decimal all,
                                                string mode)
        {
            domain = HttpUtility.UrlDecode(domain);
            region = HttpUtility.UrlDecode(region);
            street = HttpUtility.UrlDecode(street);
            locality = HttpUtility.UrlDecode(locality);

            IQueryable<ClearAddress> data = _repository.GetClearCustomerAddresses(domain, region, street, regionId, areaId, settlementId, locality, all, mode, request);
            return Json(new { Data = data, Total = request.Page * request.PageSize + 1 }, JsonRequestBehavior.AllowGet);
        }
    }
}