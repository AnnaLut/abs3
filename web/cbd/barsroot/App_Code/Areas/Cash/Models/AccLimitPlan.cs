using BarsWeb.Areas.Cash.Models.Bases;

namespace BarsWeb.Areas.Cash.Models
{
    public class AccLimitPlan : LimitPlanBase
    {
        public decimal? LimitCurrent { get; set; }
        public decimal? LimitMax { get; set; }
    }

}
