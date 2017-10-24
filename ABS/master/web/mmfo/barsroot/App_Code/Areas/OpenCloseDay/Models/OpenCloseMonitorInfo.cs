using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.OpenCloseDay.Models
{
    public class OpenCloseMonitorInfo
    {
        public DateTime? P_CURRENT_DATE { get; set; }
        public DateTime? P_NEW_DATE { get; set; }
        public decimal? P_RUN_STATE_ID { get; set; }
        public string P_RUN_STATE_NAME { get; set; }
        public List<OpenCLoseFuncMonitorItem> P_TASK_DATA { get; set; }
    }
}