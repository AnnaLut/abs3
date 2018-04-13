using System.Web.Mvc;
using BarsWeb.Areas.Finp.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Controllers;

namespace BarsWeb.Areas.Finp.Controllers
{
    [AuthorizeUser]
    public class QuestionNaireController : ApplicationController
    {
        private readonly IFinpRepository _finpRepository;

        public QuestionNaireController(IFinpRepository finpRepository)
        {
            _finpRepository = finpRepository;
        }

        public ViewResult GroupList(string surveyId, int sessionId)
        {
            var question = _finpRepository.GetSurveyGroupsHide(sessionId, surveyId);
            return View(question);
        }

        public ViewResult QuestionsList(int sessionId, string surveyId, string groupId)
        {
            var question = _finpRepository.GetQuestionParamsModels(sessionId, surveyId, groupId);
            return View(question);
        }

        public ViewResult ResultList(string surveyId, int sessionId)
        {
            return View();
        }

        public void SetAnswers(int sessionId, string questionId, string value)
        {
            _finpRepository.SetAnswers(sessionId, questionId, value);
        }

        public void SetStatus(int sessionId, string statusId, string comment)
        {
            _finpRepository.SetStatus(sessionId, statusId, comment);
        }

        public void RemoveAnswers(int sessionId, string questionId)
        {
            _finpRepository.RemoveAnswers(sessionId, questionId);
        }
    }
}