using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.Reporting.Models
{
    public class Archive
    {
        public DateTime DATF { get; set; }
        public DateTime? DAT_BLK { get; set; }
        public string FIO { get; set; }
        public decimal? ISP { get; set; }
        public string KODF { get; set; }
        public decimal TP { get; set; }
    }
}