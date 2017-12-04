using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for glkArchiveBody
/// </summary>

namespace BarsWeb.Areas.CreditUi.Models
{
    public class glkArchiveBody
    {
        public DateTime? FDAT { get; set; }
        public decimal? LIM2 { get; set; }
        public decimal? SUMG { get; set; }
        public decimal? SUMO { get; set; }
        public int? OTM { get; set; }
        public decimal? SUMK { get; set; }
        public int? NOT_SN { get; set; }

    }
}