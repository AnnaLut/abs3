using System.Web.Mvc;
using BarsWeb.Areas.Reference.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Reference.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Reference.Models;
using BarsWeb.Controllers;

namespace BarsWeb.Areas.Reference.Controllers
{ 
    /// <summary>
    /// Advertising on tickets
    /// </summary>
    [AuthorizeUser]
    //[Authorize]
    //[CheckAccessPage]
    public class HandBookMetadataController : ApplicationController
    {
        private readonly IHandBookMetadataRepository _repository;
        private readonly IUtils _utils;
        public HandBookMetadataController(IHandBookMetadataRepository repository,IUtils utils)
        {
            _repository = repository;
            _utils = utils;
        }

        public ActionResult Index(HandBookRequest request)
        {
            return View(request);
        }

        public ActionResult GetStructure(string id, string[] columns = null)
        {
            var metadata = _utils.MetadataToWebGrid(_repository.GetHandBookByName(id),columns);
            return Json(metadata,JsonRequestBehavior.AllowGet);
        }
    }
}