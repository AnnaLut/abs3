using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Zay.Models;
using System.Linq;

namespace BarsWeb.Areas.Zay.Controllers.Api.Birja
{
    [AuthorizeApi]
    public class BirjaController : ApiController
    {
        private readonly ICurrencySightRepository _repository;
        public BirjaController(ICurrencySightRepository repository)
        {
            _repository = repository;
        }
        [HttpPost]
        public HttpResponseMessage Post(List<VizaKurs> items)
        {
            IList<VisaResponse> vResponseList = new List<VisaResponse>();
            foreach (var item in items)
            {
                try
                {
                    _repository.BirjaSetViza(item.id, item.datz);
                    vResponseList.Add(new VisaResponse() { Id = item.id, Msg = "Зміни збережено", Status = 1 });
                }
                catch (Exception ex)
                {
                    vResponseList.Add(new VisaResponse() { Id = item.id, Msg = ex.Message, Status = 0 });
                }
            }
            HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                vResponseList);
            return response;
        }
        public class VizaKurs
        {
            public decimal id { get; set; }
            public DateTime? datz { get; set; }
        }

        [HttpGet]
        public HttpResponseMessage GetDdlValues(decimal dk, decimal? sos, decimal? visa, string field)
        {
            try
            {
                var data = _repository.DealerFieldValues(dk, sos, visa, field).ToList();
                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }

    }
}