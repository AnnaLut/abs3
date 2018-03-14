using BarsWeb.Areas.F601.Infrastructure.DI.Abstract;
using BarsWeb.Controllers;
using System;
using System.Web.Mvc;
using BarsWeb.Models;
using Kendo.Mvc.UI;
using Kendo.Mvc.Extensions;
using System.Collections.Generic;
using BarsWeb.Areas.F601.Models;

namespace BarsWeb.Areas.F601.Controllers
{
    [AuthorizeUser]
    public class F601DataController : ApplicationController
    {
        private readonly IF601Repository _repository;

        public F601DataController(IF601Repository repository)
        {
            _repository = repository;
        }

        public ActionResult Index()
        {
            return View();
        }

        // [HttpGet]
        public ActionResult GetCreditInfoObjectsList([DataSourceRequest]DataSourceRequest request)
        {
            try
            {
                var data = _repository.GetCreditInfoList();
                DataSourceResult result = data.ToDataSourceResult(request);
                return Json(result, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                JsonResponse JsonResult = new JsonResponse();
                JsonResult.status = JsonResponseStatus.Error;
                JsonResult.message = ex.InnerException == null ? ex.Message : ex.InnerException.Message;
                return Json(JsonResult, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult GetStatusesList()
        {
            JsonResponse JsonResult = new JsonResponse();
            //try-catch:
            var data = _repository.GetStatusesList();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetObjectTypesList([DataSourceRequest]DataSourceRequest request)
        {
            JsonResponse JsonResult = new JsonResponse();
            //try-catch:
            var data = _repository.GetObjectTypesList();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public ActionResult ShowObjectDetailedInfo(long id)
        {
            JsonResponse JsonResult = new JsonResponse();
            try
            {
                string objInfo = _repository.GetCreditInfoDetail(id);
                JsonResult.data = objInfo;
                JsonResult.status = JsonResponseStatus.Ok;
            }
            catch (Exception ex)
            {
                JsonResult.status = JsonResponseStatus.Error;
                JsonResult.message = ex.InnerException == null ? ex.Message : ex.InnerException.Message;
            }
            
            return Json(JsonResult, JsonRequestBehavior.AllowGet);
        }


    }

}