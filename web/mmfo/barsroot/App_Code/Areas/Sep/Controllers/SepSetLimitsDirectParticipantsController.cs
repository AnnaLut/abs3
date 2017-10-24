using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using BarsWeb.Areas.Sep.Models;
using BarsWeb.Controllers;
using BarsWeb.Models;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using Kendo.Mvc.UI;
using Kendo.Mvc.Extensions;
using Newtonsoft.Json;
using System.IO;

/// <summary>
/// Summary description for SepSetLimitsDirectParticipantsController
/// </summary>
/// 
namespace BarsWeb.Areas.Sep.Controllers
{
    //[CheckAccessPage]
    [AuthorizeUser]
    public class SepSetLimitsDirectParticipantsController : ApplicationController
    {
        private readonly ILimitsDirParticipants _lim;
        public SepSetLimitsDirectParticipantsController(ILimitsDirParticipants limits)
        {
            _lim = limits;
        }
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult SetLimitsHistory(string mfo)
        {
            ViewBag.MFO = mfo;
            return View();
        }


        [HttpGet]
        public ActionResult GetParticipantsHistoryInfo([DataSourceRequest] DataSourceRequest request, string MfoCode)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            result.message = "";

            try
            {
                result.data = _lim.GetAllParticipantLockHistory(MfoCode);
                //result.message += string.Format("Файл '{0}' успішно видалено.\n", delParams.FileName);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message += e.InnerException == null ? e.Message : e.InnerException.Message;
            }

            return Json(result, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ActionResult GetParticipantsInfo([DataSourceRequest] DataSourceRequest request)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            result.message = "";
            
            try
            {
                result.data = _lim.GetAllParticipantLock();
                //result.message += string.Format("Файл '{0}' успішно видалено.\n", delParams.FileName);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message += e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult SaveParticipantsChanges(List<SepParticipantsModel> changedData)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            result.message = "";

            try
            {
                _lim.SaveAllParticipantChanges(changedData);
                //result.message += string.Format("Файл '{0}' успішно видалено.\n", delParams.FileName);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message += e.InnerException == null ? e.Message : e.InnerException.Message;
                return Json(result, JsonRequestBehavior.AllowGet);
            }

            return Json(result, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult CreateFlagFIle()
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            result.message = "";

            try
            {
                _lim.CreateFlagFIle();
                //result.message += string.Format("Файл '{0}' успішно видалено.\n", delParams.FileName);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message += e.InnerException == null ? e.Message : e.InnerException.Message;
                return Json(result, JsonRequestBehavior.AllowGet);
            }

            return Json(result, JsonRequestBehavior.AllowGet);
        }
    }
}