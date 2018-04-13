using System.Linq;
using Areas.Finp.Models;
using BarsWeb.Areas.Finp.Models;

namespace BarsWeb.Areas.Finp.Infrastructure.Repository.DI.Abstract
{
    public interface IFinpRepository
    {
        IQueryable<V_FINP_ANSWERS> GetAnswers(decimal? sessionId);
        IQueryable<V_FINP_QUESTIONS> GetQuestions();
        IQueryable<V_FINP_SURVEY_GROUPS> GetSurveyGroups(string surveyId);
        IQueryable<V_FINP_SURVEY_GROUPS_HIDE> GetSurveyGroupsHide(int sessionId, string surveyId);
        IQueryable<V_FINP_SURVEY_QUESTIONS_HIDE> GetSurveyQuestions(int sessionId, string surveyId, string groupId);
        IQueryable<V_FINP_SESSIONS> GetSessions();
        IQueryable<V_FINP_SESSIONS> GetSessionFiltered(string typeId, string methodId);
        IQueryable<V_FINP_SESSIONS> GetSessionObjectSrc(string typeId, decimal srcObjId);
        IQueryable<FINP_METHODS> GetMethods();
        IQueryable<FINP_OBJ_TYPES> GetObjectTypes();
        IQueryable<V_FINP_QUESTION_LIST_ITEMS> GetQuestionListItems();
        FinpSessionModel GetSessionModels();
        FinpQuestionParamsModel GetQuestionParamsModels(int sessionId, string surveyId, string groupId);
        string GetSurveyId(string methId);
        int CreateSession(string objType, int objId, string methId, int countGuarantor);
        void SetAnswers(int sessionId, string questionId, string value);
        void SetStatus(int sessionId, string statusId, string comment);
        void RemoveAnswers(int sessionId, string questionId);
    }
}
