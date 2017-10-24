using System;

namespace Areas.Pfu.Models
{
    public class KvitDeathData
    {
        public decimal LIST_ID { get; set; }
        public decimal REQUEST_ID { get; set; }
        public string COUNT_RES { get; set; }
        public DateTime? DATE_PFU { get; set; }
        public DateTime? DATE_CR { get; set; }
        public string STATE { get; set; }
        public decimal? USERID { get; set; }
        public string PFU_FILE_ID { get; set; }
    }
}
