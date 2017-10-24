using System;
using Oracle.DataAccess.Types;

namespace BarsWeb.Areas.OpenCloseDay.Models
{
    public class Function
    {
        public decimal TASK_ID { get; set; }
        public string TASK_ACTIVE { get; set; }
        public string TASK_DESCRIPTION { get; set; }
        public decimal TASK_RANK { get; set; }
        public string TASK_TYPE { get; set; }
        public string STATUS_TASK { get; set; }
        public string START_TIME { get; set; }
        public string TAST_DURATION { get; set; }
    }
}