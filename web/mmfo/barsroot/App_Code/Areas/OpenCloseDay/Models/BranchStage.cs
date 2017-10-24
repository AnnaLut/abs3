using System;

namespace BarsWeb.Areas.OpenCloseDay.Models
{
    public class BranchStage
    {
        public string BRANCH { get; set; }
        public string BRANCH_NAME { get; set; }
        public string STAGE_NAME { get; set; }
        public DateTime? STAGE_TIME { get; set; }
        public string STAGE_USER { get; set; }
        public int? IS_READY { get; set; }
    }
}