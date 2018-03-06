using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using AttributeRouting.Web.Http;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Zay.Models;

namespace BarsWeb.Areas.Zay.Controllers.Api
{
    [AuthorizeApi]
    public class SetVisaController : ApiController
    {
        private readonly ICurrencySightRepository _repository;
        public SetVisaController(ICurrencySightRepository repository)
        {
            _repository = repository;
        }
        /*
        [HttpPost]
        [POST("api/zay/setvisa")]
        public HttpResponseMessage Post(Visa item)
        {
            try
            {
                _repository.SetVisa(item);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new { Status = 1, Message = "Зміни збережено" });
                return response;
            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.OK,
                    new { Status = 0, Message = exception.Message });
            }
        }
        */
        [HttpPost]
        [POST("api/zay/setvisa")]
        public HttpResponseMessage Post(List<Visa> items)
        {
            IList<VisaResponse> vResponseList = new List<VisaResponse>();
            foreach (var item in items)
            {
                try
                {
                    _repository.SetVisa(item);
                    vResponseList.Add(new VisaResponse() { Id = item.Id, Msg = "Зміни збережено", Status = 1 });
                }
                catch (Exception ex)
                {
                    vResponseList.Add(new VisaResponse() { Id = item.Id, Msg = ex.Message, Status = 0 });
                }
            }
            HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                vResponseList);
            return response;
        }
    }
}