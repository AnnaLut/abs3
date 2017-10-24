using System;

namespace Areas.Pfu.Models
{
    public class V_PFU_NO_TURNOVER_LIST
    {
        public decimal? ID_REQUEST { get; set; }
        public decimal? ID { get; set; }
        public DateTime? DATE_CREATE { get; set; }
        public DateTime? DATE_SENT { get; set; }
        public decimal? FULL_LINES { get; set; }
        public decimal? USER_ID { get; set; }
        public string KF { get; set; }
    }
}
