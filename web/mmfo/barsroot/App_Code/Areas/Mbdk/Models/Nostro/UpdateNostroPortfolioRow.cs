using System;

namespace BarsWeb.Areas.Mbdk.Models
{
    public class UpdateNostroPortfolioRow
    {
        public ulong ND { get; set; }
        public string CC_ID { get; set; }
        public DateTime SDATE { get; set; }
        public DateTime WDATE { get; set; }
        public decimal LIMIT { get; set; }
        public byte FIN23 { get; set; }
        public byte OBS23 { get; set; }
        public byte KAT23 { get; set; }
        public byte SOS { get; set; }
        public byte FIN_351 { get; set; }
        public decimal PD { get; set; }
    }
}