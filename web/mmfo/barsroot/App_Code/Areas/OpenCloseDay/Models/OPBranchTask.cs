using System;

namespace BarsWeb.Areas.OpenCloseDay.Models
{
    public class OPBranchTask
    {
        public decimal? TASK_RUN_ID { get; set; }
        public string BRANCH_CODE { get; set; }
        public string BRANCH_NAME { get; set; }
        public decimal? IS_ON { get; set; }
        public string TASK_RUN_STATE { get; set; }
    }
}