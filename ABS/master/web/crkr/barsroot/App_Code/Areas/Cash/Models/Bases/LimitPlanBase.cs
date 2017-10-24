using System;

namespace BarsWeb.Areas.Cash.Models.Bases
{
    public class LimitPlanBase
    {
        public decimal? Id { get; set; }
        public DateTime? StartDate { get; set; }
        public DateTime? SetDate { get; set; }
    }
}
