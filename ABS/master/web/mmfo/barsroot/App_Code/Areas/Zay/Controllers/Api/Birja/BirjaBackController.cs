using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Zay.Models;

namespace BarsWeb.Areas.Zay.Controllers.Api.Birja
{
    [AuthorizeApi]
    public class BirjaBackController : ApiController
    {
        private readonly ICurrencySightRepository _repository;
        public BirjaBackController(ICurrencySightRepository repository)
        {
            _repository = repository;
        }
        [HttpPost]
        public HttpResponseMessage Post(List<Back> items)
        {
            IList<VisaResponse> vResponseList = new List<VisaResponse>();
            foreach (var item in items)
            {
                try
                {
                    _repository.BirjaBackRequest(item.id);
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
        public class Back
        {
            public decimal id { get; set; }
        }
    }
}