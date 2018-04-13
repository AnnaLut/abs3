using System.Web.Mvc;
using BarsWeb.Areas.Reporting.Infrastructure;
using BarsWeb.Areas.Reporting.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Controllers;

namespace BarsWeb.Areas.Reporting.Controllers
{ 
    /// <summary>
    /// Advertising on tickets
    /// </summary>
    [AuthorizeUser]
    //[Authorize]
    //[CheckAccessPage]
    public class NbuController : ApplicationController
    {
        private readonly INbuRepository _repository;
        public NbuController(INbuRepository repository)
        {
            _repository = repository;
        }

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GetStructure(string id)
        {
            var structure = _repository.GetReportStructure(id);
            var result = new Utils().ConvertReportStructureToFields(structure);

            return Content(result);
        }
    }
}