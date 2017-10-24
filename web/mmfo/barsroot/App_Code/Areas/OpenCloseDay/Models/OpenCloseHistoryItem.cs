using System;

namespace BarsWeb.Areas.OpenCloseDay.Models
{
    public class OpenCloseHistoryItem
    {
        public decimal? ID { get; set; }
        public DateTime? CURRENT_BANK_DATE { get; set; }
        public DateTime? NEW_BANK_DATE { get; set; }
        public string RUN_STATE { get; set; }
    }
}