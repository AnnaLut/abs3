using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Implementation;
using BarsWeb.Areas.Kernel.Models;
using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.Kernel.Controllers.Api
{
    [AuthorizeUser]
    public class CalendarController : ApiController
    {
        private readonly IBankDatesRepository _repo;
        public CalendarController(IBankDatesRepository repository)
        {
            _repo = repository;
        }
        [HttpGet]
        public HttpResponseMessage GetHolidays(string year, int? kv)
        {
            List<Holiday> dates = _repo.GetHolidays(year, kv);
           return Request.CreateResponse(HttpStatusCode.OK, dates);
        }
        [HttpPost]
        public HttpResponseMessage InitHolidays(string year, int? kv)
        {
            _repo.InitHolidays(year, kv);
            return Request.CreateResponse(HttpStatusCode.OK);
        }
        [HttpPost]
        public HttpResponseMessage SaveCalendar([FromBody] dynamic request)
        {
            _repo.SaveCalendar((string)request.year, (int?)request.kv, request.holiday.ToObject<List<DateTime>>());
            return Request.CreateResponse(HttpStatusCode.OK, "Дати збережені");
        }
        
    }
}