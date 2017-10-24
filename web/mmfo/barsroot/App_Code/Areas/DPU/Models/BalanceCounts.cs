using System;

namespace BarsWeb.Areas.DPU.Models
{
    public class BalanceCounts
    {
        public decimal? ACC { get; set; }
        public string NLS { get; set; }
        public decimal? KV { get; set; }
        public decimal? OSTC { get; set; }
        public decimal? OSTB { get; set; }
        public string NMS { get; set; }
        public string ND { get; set; }
        public decimal? SUM { get; set; }
        public decimal? REF1 { get; set; }
        public DateTime? VDAT { get; set; }
        public decimal? S_100 { get; set; }
        public decimal? S { get; set; }
        public string NAZN { get; set; }
        public string BAL { get; set; }
    }
}