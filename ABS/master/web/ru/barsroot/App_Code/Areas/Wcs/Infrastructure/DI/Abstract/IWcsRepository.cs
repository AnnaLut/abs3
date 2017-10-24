using System.Linq;
using System.Collections.Generic;
using BarsWeb.Areas.Wcs.Models;

namespace BarsWeb.Areas.Wcs.Infrastructure.DI.Abstract
{
    public interface IWcsRepository
    {
        IQueryable<ScoringQuestion> GetScoringQuestion(int bidId);
        int GetCountGarantees(int? bidId);
        ScoringResult GetResult(int? bidId);
        IQueryable<ServiceList> GetServiceList();
        string GetValue(string bid_id, string question_id);
        void SetServices(string bidId, string services);
        IQueryable<GroupList> GetGroups(decimal bid_id);
        IQueryable<GroupQuestionList> GetGroupQuestions(decimal bid_id, string survey_id, string group_id);
        void CalcAnsw(decimal bid_id, string question_id);
        IQueryable<QuestRelationResult> GetRelationQuestion(decimal bid_id, string survey_id, string group_id, string question_id, string val);
        string CheckQuestion(decimal bid_id, string survey_id, string group_id, string question_id, string val);
        void SetAllAnsw(List<ParamsSetAnswers> param);
        void SetAnsw(decimal bid_id, string question_id, string val);
        void DeleteState(decimal bid_id);
        void BidStateCheckOut(decimal bid_id, string state_id);
    }
}