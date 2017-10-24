using System;

namespace BarsWeb.Areas.Cash.Models
{
    public class Treshold
    {
        public decimal? Id { get; set; }
        public string LimitType { get; set; }
        public decimal? NacCurrencyFlag { get; set; }
        public decimal? DeviationPercent { get; set; }
        public decimal? ViolationDeys { get; set; }
        //public int? MaxLoadLimit { get; set; }
        public string ViolationColor { get; set; }
        public DateTime? DateStart { get; set; }
        //public DateTime? DateStop { get; set; }
        public string Mfo { get; set; }
        public string MfoName { get; set; }
        public DateTime? DateSet { get; set; }
        public DateTime? DateUpdate { get; set; }
    }
}
