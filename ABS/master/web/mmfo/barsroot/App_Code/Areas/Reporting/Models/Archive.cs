using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.Reporting.Models
{
    public class Archive
    {
        public DateTime REPORT_DATE { get; set; }
        public string TIME { get; set; }
        public string FIO { get; set; }
        public decimal? FILE_ID { get; set; }
        public string PERIOD { get; set; }
        public string FILE_CODE { get; set; }
        public string FILE_TYPE { get; set; }
        public string KF { get; set; }
        public string FILE_NAME { get; set; }


    }
}