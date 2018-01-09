using System;
using System.Web.Mvc;
using BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Cdm.Models;
using BarsWeb.Controllers;
using BarsWeb.Models;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Cdm.Controllers
{
    //[CheckAccessPage]
    [Authorize]
    public class DeduplicateController : ApplicationController
    {
        private readonly IDeduplicateRepository _dupeRepo;
        public DeduplicateController(IDeduplicateRepository dupeRepo)
        {
            _dupeRepo = dupeRepo;
        }

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GetDuplicateGroupList([DataSourceRequest] DataSourceRequest request, DupGroupParams dupParams) 
        {
            var data = _dupeRepo.RequestEbkClient(dupParams, request);
            var total = _dupeRepo.RequestEbkClientCount(dupParams, request);
            return Json(new { Data = data, Total = total }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetRnkDuplicates(decimal rnk)
        {
            var mainCard = _dupeRepo.GetMainCard(rnk);
            var childCards = _dupeRepo.GetChildCards(rnk);
            var attrGroups = _dupeRepo.GetAttrGroups(rnk);
            var mainAttributes = _dupeRepo.GetCardAttributes(rnk);
            return Json(new { MainCard = mainCard, ChildCards = childCards, AttrGroups = attrGroups, MainAttributes = mainAttributes }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetRnkAttributes(decimal rnk)
        {
            var cardAttributes = _dupeRepo.GetCardAttributes(rnk);
            return Json(new { Attributes = cardAttributes }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult SetNewMainCard(decimal mRnk, decimal dRnk)
        {
            var result = new JsonResponseEbk(JsonResponseStatus.Ok);
            try
            {
                _dupeRepo.SetCardAsMaster(mRnk, dRnk);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult IgnoreChild(decimal mRnk, decimal dRnk)
        {
            var result = new JsonResponseEbk(JsonResponseStatus.Ok);
            try
            {
                _dupeRepo.IgnoreChild(mRnk, dRnk);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult MergeDupes(decimal mRnk, decimal dRnk)
        {
            var result = new JsonResponseEbk(JsonResponseStatus.Ok);
            try
            {
                _dupeRepo.MergeDupes(mRnk, dRnk);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult MoveAttributesFromChild(decimal rnk, string[] attributes, string[] values)
        {
            var result = new JsonResponseEbk(JsonResponseStatus.Ok);
            try
            {
                _dupeRepo.MoveAttributesFromChild(rnk, attributes, values);
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