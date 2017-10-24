using System.Linq;
using BarsWeb.Areas.Finp.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Finp.Infrastructure.Repository.DI.Abstract;
using Areas.Finp.Models;

namespace BarsWeb.Areas.Finp.Models
{
    /// <summary>
    /// Summary description for FinpSessionModel
    /// </summary>
    public class FinpQuestionParamsModel
    {
        public IQueryable<V_FINP_SURVEY_QUESTIONS_HIDE> SurQuestionParams { get; set; }

        public IQueryable<V_FINP_QUESTION_REFER_PARAMS> SurQuestionRefParams { get; set; }

        public IQueryable<V_FINP_QUESTION_LIST_ITEMS> SurQuestionListItem { get; set; }
        public IQueryable<V_FINP_ANSWERS> SesAnswers { get; set; }
    }
}