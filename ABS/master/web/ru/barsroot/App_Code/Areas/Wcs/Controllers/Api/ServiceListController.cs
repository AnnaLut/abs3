using System.Linq;
using System.Net;
using System.Collections.Generic;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Wcs.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Wcs.Infrastructure.DI.Implementation;
using BarsWeb.Areas.Wcs.Models;

namespace BarsWeb.Areas.Wcs.Controllers.Api
{
    public class ServiceListController : ApiController
    {
        private readonly IWcsRepository _repo;
        public ServiceListController()
        {
            _repo = new WcsRepository();
        }
        public ServiceListController(IWcsRepository repository)
        {
            _repo = repository;
        }
        public HttpResponseMessage Get()
        {
            IQueryable<ServiceList> service = _repo.GetServiceList();
            return Request.CreateResponse(HttpStatusCode.OK, service);
        }
        public HttpResponseMessage Post(string bid_id, string services)
        {
            _repo.SetServices(bid_id, services);
            return Request.CreateResponse(HttpStatusCode.OK);
        }
    }
}