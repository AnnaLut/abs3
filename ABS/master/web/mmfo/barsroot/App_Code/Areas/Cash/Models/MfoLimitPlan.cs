using BarsWeb.Areas.Cash.Models.Bases;

namespace BarsWeb.Areas.Cash.Models
{
    public class MfoLimitPlan : LimitPlanBase
    {
        public string Kf { get; set; }
        public decimal? Kv { get; set; }
        public decimal? LimCurrent { get; set; }
        public decimal? LimMax { get; set; }
        public string LimitType { get; set; }
    }

}
