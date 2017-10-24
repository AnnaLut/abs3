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
using BarsWeb.Areas.Sep.Models;

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
            List<tblFDAT> fDats = _repo.GetWorkDates().ToList();//.OrderByDescending(d => d.FDAT).ToList(); // was: FDAT1
            List<string> datesList = fDats.Select(d => d.FDAT.ToString("dd-MM-yyyy")).ToList();
            return Request.CreateResponse(HttpStatusCode.OK, datesList);
        }
    }
}