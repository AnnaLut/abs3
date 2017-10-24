using System.Linq;
using System.Web.Mvc;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sep.Models;
using BarsWeb.Controllers;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Sep.Controllers
{
    [CheckAccessPage]
    [AuthorizeUser]
    public class SepDocumentsController : ApplicationController
    {
        private readonly ISepFilesRepository _repo;
        private readonly ISepPaymentStateRepository _repoPaymentState;
        private readonly IKendoRequestTransformer _requestTransformer;
        public SepDocumentsController(ISepFilesRepository repository, ISepPaymentStateRepository repositPaymentState, IKendoRequestTransformer requestTransformer)
        {
            _repo = repository;
            _repoPaymentState = repositPaymentState;
            _requestTransformer = requestTransformer;
        }

        public ActionResult GetSepFileDocs([DataSourceRequest]DataSourceRequest request, SepFileDocParams docParams)
        {
            var tmpRequest = _requestTransformer.MultiplyFilterValue(request, "S");
            var docList = _repo.GetSepFileDocs(docParams, tmpRequest).ToList();
            decimal total = _repo.GetSepDocsCount(docParams, tmpRequest);
            return Json(new { Data = docList, Total = total }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetSepPaymentStateDocs([DataSourceRequest]DataSourceRequest request, SepFileDocParams docParams)
        {
            var docList = _repoPaymentState.GetSepPaymentStateDocs(docParams, request).ToList();
            decimal total = _repoPaymentState.GetSepPaymentStateDocsCount(docParams);
            return Json(new { Data = docList, Total = total }, JsonRequestBehavior.AllowGet);
        }
      
        public ActionResult Index(SepFileDocParams docParams)
        { 
            if (docParams.PaymentStateFlag)
                return View("IndexPaymentState", docParams);

            return View(docParams);
        }
    }
}