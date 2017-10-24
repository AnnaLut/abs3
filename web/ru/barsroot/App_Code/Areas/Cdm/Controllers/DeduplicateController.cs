using System;
using System.Web.Mvc;
using System.Collections.Generic;
using System.Text;
using BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Cdm.Models;
using BarsWeb.Controllers;
using BarsWeb.Core.Logger;
using BarsWeb.Models;
using Kendo.Mvc.UI;
using Ninject;

namespace BarsWeb.Areas.Cdm.Controllers
{
    [CheckAccessPage]
    [Authorize]
    public class DeduplicateController : ApplicationController
    {
        private readonly IDeduplicateRepository _dupeRepo;
        [Inject]
        public IDbLogger Logger { get; set; }
        public DeduplicateController(IDeduplicateRepository dupeRepo)
        {
            _dupeRepo = dupeRepo;
        }

        public ActionResult Index()
        {
            string type = Request.Params["type"];
            string title = string.Empty;
            switch (type)
            {
                case "individualPerson": title = "ФО"; break;
                case "legalPerson": title = "ЮО"; break;
                case "entrepreneurPerson": title = "ФОП"; break;
                default: title = "ФО"; break;
            }
            ViewBag.TitleSuffix = title;
            return View();
        }

        public ActionResult GetDuplicateGroupList([DataSourceRequest] DataSourceRequest request, DupGroupParams dupParams)
        {
            try
            {
                var data = _dupeRepo.RequestEbkClient(dupParams, request);
                var total = _dupeRepo.RequestEbkClientCount(dupParams, request);

                return Json(new { Data = data, Total = total }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                StringBuilder errorMessage = new StringBuilder("Виникла помилка детальна інформація: ");

                errorMessage.Append(ex.Message ?? string.Empty);
                errorMessage.Append(" ");
                errorMessage.Append(ex.InnerException == null ? string.Empty : ex.InnerException.Message);

                Logger.Error("ЕБК GetDuplicateGroupList " + errorMessage);

                return Json(new { ErrorMessage = errorMessage.ToString(), Data = new List<DupGroup>() { } }, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult GetRnkDuplicates(decimal rnk, string type)
        {

            try
            {
                var mainCard = _dupeRepo.GetMainCard(rnk, type);
                var childCards = _dupeRepo.GetChildCards(rnk, type);
                var attrGroups = _dupeRepo.GetAttrGroups(rnk, type);
                var mainAttributes = _dupeRepo.GetCardAttributes(rnk, type);
                return Json(new { MainCard = mainCard, ChildCards = childCards, AttrGroups = attrGroups, MainAttributes = mainAttributes }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Logger.Error("ЕБК GetRnkDuplicates ex.Message : " + ex.Message + " ex.InnerException : " + ex.InnerException +
                             "ex.StackTrace : " + ex.StackTrace);
                return Json(new
                {
                    Error = @"ЕБК GetRnkDuplicates ex.Message : " + ex.Message + " ex.InnerException : " + ex.InnerException +
                             "ex.StackTrace : " + ex.StackTrace
                }, JsonRequestBehavior.AllowGet);

            }

        }

        public ActionResult GetRnkAttributes(decimal rnk, string type)
        {
            try
            {
                var cardAttributes = _dupeRepo.GetCardAttributes(rnk, type);
                return Json(new { Attributes = cardAttributes }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Logger.Error("ЕБК GetRnkAttributes ex.Message : " + ex.Message + " ex.InnerException : " + ex.InnerException +
                             "ex.StackTrace : " + ex.StackTrace);
                return Json(new
                {
                    Error = @"ЕБК GetRnkAttributes ex.Message : " + ex.Message + " ex.InnerException : " + ex.InnerException +
                             "ex.StackTrace : " + ex.StackTrace
                }, JsonRequestBehavior.AllowGet);

            }

        }

        public ActionResult SetNewMainCard(decimal mRnk, decimal dRnk, string type)
        {
            var result = new JsonResponseEbk(JsonResponseStatus.Ok);
            try
            {
                _dupeRepo.SetCardAsMaster(mRnk, dRnk, type);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult IgnoreChild(decimal mRnk, decimal dRnk, string type)
        {
            var result = new JsonResponseEbk(JsonResponseStatus.Ok);
            try
            {
                _dupeRepo.IgnoreChild(mRnk, dRnk, type);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult MergeDupes(decimal mRnk, decimal dRnk, string type)
        {
            var result = new JsonResponseEbk(JsonResponseStatus.Ok);
            try
            {
                _dupeRepo.MergeDupes(mRnk, dRnk, type);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult MoveAttributesFromChild(decimal rnk, string[] attributes, string[] values, string type)
        {
            var result = new JsonResponseEbk(JsonResponseStatus.Ok);
            try
            {
                _dupeRepo.MoveAttributesFromChild(rnk, attributes, values, type);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result);
        }
    }

}