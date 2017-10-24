using System;

namespace BarsWeb.Areas.Pfu.Models.Grids
{
    public class V_PFU_ENVELOP_ARH
    {
        public decimal? ID { get; set; }
        public decimal? PFU_ENVELOP_ID { get; set; }
        public DateTime? REGISTER_DATE { get; set; }
        public DateTime? CRT_DATE { get; set; }
        public DateTime? SENT_DATE { get; set; }
        public decimal? REG_DATE { get; set; }
        public decimal? REG_CNT { get; set; }
        public decimal? CHECK_SUM { get; set; }
        public string STATE_NAME { get; set; }
    }

}