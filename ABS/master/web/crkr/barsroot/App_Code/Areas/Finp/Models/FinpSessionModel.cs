using System.Linq;
using Areas.Finp.Models;

namespace BarsWeb.Areas.Finp.Models
{
    /// <summary>
    /// Summary description for FinpSessionModel
    /// </summary>
    public class FinpSessionModel
    {
        public IQueryable<V_FINP_SESSIONS> Sessions { get; set; }

        public IQueryable<FINP_METHODS> Metods { get; set; }

        public IQueryable<FINP_OBJ_TYPES> ObjectTypes { get; set; }

        public IQueryable<V_FINP_QUESTION_LIST_ITEMS> QuestionListItems { get; set; }
    }
}