using System;
using System.Collections.Generic;
using System.Web.Mvc;
using System.Linq;
using BarsWeb.Areas.Wcs.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Wcs.Infrastructure.DI.Implementation;
using BarsWeb.Controllers;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using BarsWeb.Areas.Wcs.Models;

namespace BarsWeb.Areas.Wcs.Controllers
{
    [AuthorizeUser]
    public class QuestionnaireController : ApplicationController
    {
        private readonly IWcsRepository _csRepository;
        public QuestionnaireController(IWcsRepository cfRepository)
        {
            _csRepository = cfRepository;
        }
        [CheckAccessPage]
        public ActionResult CustomerQNaire()
        {
            return View();
        }

        public ActionResult GetGroup(decimal bid_id)
        {
            IQueryable<GroupList> session = _csRepository.GetGroups(bid_id);
            return Json(session, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetGroupQuestion(decimal bid_id, string survey_id, string group_id)
        {
            IQueryable<GroupQuestionList> session = _csRepository.GetGroupQuestions(bid_id, survey_id, group_id);
            return Json(session, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetQuestRelation(decimal bid_id, string survey_id, string group_id, string question_id, string val)
        {
            IQueryable<QuestRelationResult> session = _csRepository.GetRelationQuestion(bid_id, survey_id, group_id, question_id, val);
            return Json(session, JsonRequestBehavior.AllowGet);
        }

        public string GetCheckQuestion(decimal bid_id, string survey_id, string group_id, string question_id, string val)
        {
            string session = _csRepository.CheckQuestion(bid_id, survey_id, group_id, question_id, val);
            return session;
        }

        public void SetAllAnsw(List<ParamsSetAnswers> param)
        {
            _csRepository.SetAllAnsw(param);
        }

        public void DeleteState(decimal bid_id)
        {
            _csRepository.DeleteState(bid_id);
        }

        public void BidStateCheckOut(decimal bid_id, string state_id)
        {
            _csRepository.BidStateCheckOut(bid_id, state_id);
        }
    }
}