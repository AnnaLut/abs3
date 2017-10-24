using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Admin.Models.CommunicationObject;
using BarsWeb.Controllers;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace BarsWeb.Areas.Admin.Controllers
{

    [Authorize]
    public class CommunicationObjectController : ApplicationController
    {
        private readonly ICommunicationObjectRepository _rep;
        public CommunicationObjectController(ICommunicationObjectRepository rep)
        {
            _rep = rep;
        }

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GetDropDownCommObj()
        {
            List<CommObjDropDown> data = _rep.GetDropDownCommObj();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetCommObjGrid([DataSourceRequest]DataSourceRequest request, int id)
        {
            List<CommObj> data = _rep.GetCommObjGrid(request, id);
            decimal total = _rep.GetCommObjDataCount(request, id);
            return Json(new { Data = data, Total = total }, JsonRequestBehavior.AllowGet);
        }
    }
}