using BarsWeb.Areas.Cash.Models.Bases;

namespace BarsWeb.Areas.Cash.Models
{
    public class AtmLimitPlan : LimitPlanBase
    {
        public decimal? LimitMaxLoad { get; set; }
    }

}
