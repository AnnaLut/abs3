using System;

namespace BarsWeb.Areas.OpenCloseDay.Models
{
    public class OpenCLoseFuncMonitorItem
    {
        public decimal? ID { get; set; }
        public decimal? SEQUENCE_NUMBER { get; set; }
        public string TASK_NAME { get; set; }
        public string BRANCH_CODE { get; set; }
        public string BRANCH_NAME { get; set; }
        public DateTime? START_TIME { get; set; }
        public DateTime? FINISH_TIME { get; set; }
        public string TASK_RUN_STATE { get; set; }
        public decimal[] BUTTON_FLAGS { get; set; }
    }
}