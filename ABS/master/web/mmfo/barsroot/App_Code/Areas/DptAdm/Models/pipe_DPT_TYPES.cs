using System;

namespace BarsWeb.Areas.DptAdm.Models
{
    public class pipe_DPT_TYPES
    {
        public decimal TYPE_ID { get; set; }
        public string TYPE_NAME { get; set; }
        public string TYPE_CODE { get; set; }
        public string FL_ACTIVE { get; set; }
        public string FL_DEMAND { get; set; }
        public string FL_WEBBANKING { get; set; }
        public decimal SORT_ORD { get; set; }
        public int FL_ACT { get; set; }
        public int FL_DEM { get; set; }
        public int FL_WB { get; set; }
        public int COUNT_ACTIVE { get; set; }
    }
}