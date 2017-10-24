using System;

namespace BarsWeb.Areas.Reporting.Models
{
    public class Accessed
    {
        public string FILE_CODE { get; set; }
        public decimal FILE_ID { get; set; }
        public string FILE_NAME { get; set; }
        public string FILE_TYPE { get; set; }
        public DateTime? FINISH_TIME { get; set; }
        public string FIO { get; set; }
        public string KF { get; set; }
        public string PERIOD { get; set; }
        public string SCHEME_CODE { get; set; }
        public DateTime? START_TIME { get; set; }
        public string STATUS { get; set; }
        public string STATUS_CODE { get; set; }
        public decimal VERSION_ID { get; set; }
        public DateTime REPORT_DATE { get; set; }
        public string VERSION { get; set; }
    }
}
