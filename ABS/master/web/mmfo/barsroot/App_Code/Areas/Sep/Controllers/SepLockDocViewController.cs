using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sep.Models;
using BarsWeb.Controllers;
using BarsWeb.Models;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;


namespace BarsWeb.Areas.Sep.Controllers
{
    //[CheckAccessPage]
    [AuthorizeUser]
    public class SepLockDocViewController : ApplicationController
    {
        private readonly ISepLockDocViewRepository _repo;

        public SepLockDocViewController(ISepLockDocViewRepository repo)
        {
            _repo = repo;            
        }

        public ActionResult Index()
        {
            return View();
        }
        public ActionResult PrintDoc(decimal rec)
        {
            ViewBag.Rec = rec;
            return View();
        }
        
        public ActionResult GetLockDoc(decimal rec)
        {
            try
            {
                IQueryable<SepLockView> session = _repo.GetLockDoc(rec);
                return Json(session, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new {Msg = ex.Message}, JsonRequestBehavior.AllowGet);
            }
        }
    }
}