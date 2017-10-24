using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Areas.Sep.Models;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Implementation;
using System.Collections.Generic;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Implementation;

namespace BarsWeb.Areas.Sep.Controllers.Api
{
    [AuthorizeApi]
    public class WorkDatesController : ApiController
    {
        private readonly IWorkDatesRepository _repo;
        public WorkDatesController()
        {
            _repo = new WorkDatesRepository();
        }
        public WorkDatesController(IWorkDatesRepository repository)
        {
            _repo = repository;
        }
        public HttpResponseMessage Get()
        {
            List<FDAT> fDats = _repo.GetWorkDates().OrderByDescending(d => d.FDAT1).ToList();
            List<string> datesList = fDats.Select(d => d.FDAT1.ToString("dd-MM-yyyy")).ToList();
            return Request.CreateResponse(HttpStatusCode.OK, datesList);
        }
    }
}