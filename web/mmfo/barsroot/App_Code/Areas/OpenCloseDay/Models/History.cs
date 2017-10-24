using System;

namespace BarsWeb.Areas.OpenCloseDay.Models
{
    public class History
    {
        public decimal ID_GROUP_LOG { get; set; }
        public DateTime BANK_DATE { get; set; }
        public DateTime START_DATE_GROUP { get; set; }
        public TimeSpan DURATION_GROUP { get; set; }
        public string STATUS_GROUP { get; set; }
        public string TASK_ACTIVE { get; set; }
        public string START_DATE_TASK { get; set; }
        public string DURATION_TASK { get; set; }
        public string STATUS_TASK { get; set; }
        public string ERR_MSG { get; set; }
        public string TASK_DESCRIPTION { get; set; }
        public decimal TASK_RANK { get; set; }

    }
}