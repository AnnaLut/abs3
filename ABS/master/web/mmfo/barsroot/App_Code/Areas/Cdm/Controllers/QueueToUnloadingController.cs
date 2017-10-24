using System;
using System.Web.Mvc;
using BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract.Individual;
using BarsWeb.Areas.Cdm.Infrastructure.DI.Abstract.Legal;
using BarsWeb.Areas.Cdm.Infrastructure.DI.Abstract.PrivateEn;
using BarsWeb.Areas.Cdm.Models;
using BarsWeb.Controllers;
using BarsWeb.Models;
using Kendo.Mvc.UI;
using System.Configuration;

namespace BarsWeb.Areas.Cdm.Controllers
{
    [CheckAccessPage]
    [Authorize]
    public class QueueToUnloadingController : ApplicationController
    {
        private readonly IQueueToUnloadingRepository _queueToUnloadingRepo;
        private readonly ICdmRepository _cdmRepository;
        private readonly ICdmLegalRepository _cdmLegalRepository;
        private readonly ICdmPrivateEnRepository _cdmPrivateRepository;

        public QueueToUnloadingController(IQueueToUnloadingRepository queueToUnloadingRepo, ICdmRepository cdmRepository, ICdmLegalRepository cdmLegalRepository, ICdmPrivateEnRepository cdmPrivateRepository)
        {
            _queueToUnloadingRepo = queueToUnloadingRepo;
            _cdmRepository = cdmRepository;
            _cdmLegalRepository = cdmLegalRepository;
            _cdmPrivateRepository = cdmPrivateRepository;
        }

        public ActionResult Index()
        {
            return View();
        }

        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "None")]
        public ActionResult ReturnDataToGrid(DataSourceRequest request)
        {
            var data = _queueToUnloadingRepo.GetQueueToUnloading(request);
            return Json(new { Data = data}, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "None")]
        public decimal? SendCards(string custType, string kf)
        {

            decimal? data = 0;
            string packSizeString = ConfigurationManager.AppSettings["ebk.PackSize"];
            int packSize = int.Parse(packSizeString);

            if (custType == "I")
            {
                data =  _cdmRepository.PackAndSendClientCards(null, packSize, kf);
                return data;
            }
            else if (custType == "L")
            {
                data = _cdmLegalRepository.PackAndSendClientCards(null, packSize, kf);
                return data;
            }
            else if (custType == "P")
            {
                data = _cdmPrivateRepository.PackAndSendClientCards(null, packSize, kf);
                return data;
            }
            return data;
        }
    }
}
