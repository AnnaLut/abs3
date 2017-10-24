using System;

namespace BarsWeb.Areas.OpenCloseDay.Models
{
    public class OPTask
    {
        public decimal? TASK_ID { get; set; }
        public decimal? SEQUENCE_NUMBER { get; set; }
        public string TASK_NAME { get; set; }
        public decimal? IS_ON { get; set; }
        public decimal? SHOW_BRANCHES { get; set; }
    }
}