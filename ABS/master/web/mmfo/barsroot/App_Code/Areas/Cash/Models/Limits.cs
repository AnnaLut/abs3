using System;

namespace BarsWeb.Areas.Cash.Models
{
    public class Limits
    {
        public string Id
        {
            get { return Kf + Kv; }
        }
        public string Kf { get; set; }
        public string MfoName { get; set; }
        public string LimitType { get; set; }
        public decimal? Kv { get; set; }
        public decimal? SumBal { get; set; }
        public decimal? LimCurrent { get; set; }
        public decimal? LimMax { get; set; }
        public decimal? AccLimCurrent { get; set; }
        public decimal? AccLimMax { get; set; }
        public decimal? SumOverLimit { get; set; }
        public decimal? SumOverMaxLimit { get; set; }
        public decimal? NextLimCurrent { get; set; }
        public DateTime? NextStartDate { get; set; }
    }
}
