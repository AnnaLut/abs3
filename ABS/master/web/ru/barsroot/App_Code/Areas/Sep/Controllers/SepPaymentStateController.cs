using System;
using System.Linq;
using System.Web.Mvc;
using BarsWeb.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sep.Models;
using BarsWeb.Controllers;
using Kendo.Mvc.UI;
using System.Collections.Generic;


namespace BarsWeb.Areas.Sep.Controllers
{
    [CheckAccessPage]
    [AuthorizeUser]
    public class SepPaymentStateController: ApplicationController
    {
        private readonly ISepPaymentStateRepository _repo;
        private readonly IErrorsRepository _errors;

        
        public SepPaymentStateController(ISepPaymentStateRepository repository, IErrorsRepository errorsRepo)
        {
            _repo = repository;
            _errors = errorsRepo;
        }

        public ActionResult Index(AccessType accessType, bool? isBack)
        {           
            return View(accessType);
        }

        public ActionResult GetSepPaymentStateList(AccessType accessType)
        {
            List<SepPaymentStateInfo> filelist = _repo.GetSepPaymentStateInfo(null, null);
            return Json(new { Data = filelist, }, JsonRequestBehavior.AllowGet);
        }
        
    }
}